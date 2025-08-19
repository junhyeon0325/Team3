package com.yedam.control;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // HttpSession 임포트

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yedam.common.Control;
import com.yedam.mapper.OrderDAO; // OrderDAO 임포트 (패키지명에 따라 변경)
import com.yedam.vo.CartProductVO; // CartProductVO 임포트
import com.yedam.vo.OrderTempVO; // OrderTempVO 임포트
import com.yedam.vo.OrderVO; // OrderVO 임포트

public class PaymentConfirmControl implements Control {

	// IMPORTANT: 실제 토스페이먼츠 개발자 센터에서 발급받은 'test_sk_'로 시작하는 시크릿 키를 사용하세요.
	// 키 뒤에 반드시 콜론(:)을 붙여야 합니다.
	private static final String SECRET_KEY = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6:"; // TODO: 여기에 실제 시크릿 키를 정확히
																						// 입력하세요.

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) {
		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode payload = null;
		HttpSession session = req.getSession();

		try { // Outer try block
				// 요청 본문 읽기 및 로그
			String requestBodyString = req.getReader().lines().collect(java.util.stream.Collectors.joining());
			payload = objectMapper.readTree(requestBodyString);
			System.out.println("Received request body: " + payload.toString());

			String paymentKey = payload.get("paymentKey").asText();
			String orderId = payload.get("orderId").asText();
			long amount = payload.get("amount").asLong();

			// 변수 값 로그
			System.out.println("Parsed paymentKey: " + paymentKey);
			System.out.println("Parsed orderId: " + orderId);
			System.out.println("Parsed amount: " + amount);

			// 토스페이먼츠 결제 승인 API 호출
			String url = "https://api.tosspayments.com/v1/payments/confirm";
			String encodedSecret = Base64.getEncoder().encodeToString((SECRET_KEY).getBytes(StandardCharsets.UTF_8));
			
			System.out.println("Encoded Secret (for Toss API Auth): " + encodedSecret);
			
			HttpURLConnection conn = null;
			try { // Inner try block for HTTP Connection
				conn = (HttpURLConnection) new URL(url).openConnection();
				conn.setRequestMethod("POST");
				conn.setRequestProperty("Authorization", "Basic " + encodedSecret);
				conn.setRequestProperty("Content-Type", "application/json");
				conn.setDoOutput(true);

				String requestBody = String.format("{\"paymentKey\":\"%s\",\"orderId\":\"%s\",\"amount\":%d}",
						paymentKey, orderId, amount);

				try (OutputStream os = conn.getOutputStream()) {
					byte[] input = requestBody.getBytes(StandardCharsets.UTF_8);
					os.write(input, 0, input.length);
				}

				int responseCode = conn.getResponseCode();
				System.out.println("Toss Payments API response code: " + responseCode);

				if (responseCode == HttpURLConnection.HTTP_OK) {
					try (BufferedReader br = new BufferedReader(
							new InputStreamReader(conn.getInputStream(), StandardCharsets.UTF_8))) {
						String responseJson = br.readLine();
						JsonNode successNode = objectMapper.readTree(responseJson);

						// 성공 정보를 세션에 저장
						session.setAttribute("paymentDetail", successNode);

						// =========================================================
						// TODO: 데이터베이스 저장 로직
						// =========================================================
						OrderDAO dao = new OrderDAO();

						// 세션에서 임시 주문 정보 (OrderTempVO) 가져오기
						OrderTempVO tempOrderInfo = (OrderTempVO) session.getAttribute("tempOrderInfo");

						if (tempOrderInfo == null) {
							System.err.println("오류: 세션에 임시 주문 정보 (tempOrderInfo)가 없습니다. DB 저장 실패.");
							// 클라이언트에게 오류 응답을 보내거나, 실패 페이지로 리디렉션
							resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
							resp.setContentType("application/json");
							resp.setCharacterEncoding("UTF-8");
							resp.getWriter()
									.write("{\"code\":\"ORDER_DATA_MISSING\",\"message\":\"주문 정보가 세션에 없습니다.\"}");
							return;
						}

						// 1. tbl_order에 저장할 데이터 준비
						OrderVO orderVO = new OrderVO();
						long orderNo = dao.getNextOrderNo();

						orderVO.setOrderNo(orderNo);
						orderVO.setOrderAddress(tempOrderInfo.getOrderAddress());
						orderVO.setUsedPoint(tempOrderInfo.getUsedPoint());
						orderVO.setOrderPrice((int) amount);
						orderVO.setOrderRequest(tempOrderInfo.getOrderRequest());
						orderVO.setMemberNo(tempOrderInfo.getMemberNo());

						// PRODUCT_NO 설정: 장바구니에서 첫 번째 상품의 productNo를 가져옵니다.
						List<CartProductVO> cartList = tempOrderInfo.getCartList();
						if (cartList != null && !cartList.isEmpty()) {
							orderVO.setProductNo(cartList.get(0).getProductNo()); // <<--- 첫 번째 상품의 ProductNo 설정
						} else {
							// 장바구니가 비어있을 경우 (비정상 상황이지만, NullPointerException 방지)
							System.err.println("경고: 장바구니 목록(cartList)이 비어 있어 대표 상품 번호를 설정할 수 없습니다. 기본값 0 또는 에러 처리 필요.");
							orderVO.setProductNo(0); // 또는 적절한 기본값, 에러 코드
						}

						// 2. tbl_order에 주문 정보 삽입
						int orderResult = dao.insertOrder(orderVO);
						System.out.println("tbl_order 삽입 결과: " + (orderResult > 0 ? "성공" : "실패"));

						// 3. tbl_order_items에 주문 상세 항목 삽입
						if (orderResult > 0 && cartList != null && !cartList.isEmpty()) { 
							int orderItemsResult = dao.insertOrderItems(orderNo, cartList);
							System.out.println("tbl_order_items 삽입 결과: " + orderItemsResult + "건 삽입");
						} else {
							System.out.println("경고: 장바구니 목록(cartList)이 비어 있거나 tbl_order 삽입 실패로 인해 주문 상세 항목을 저장하지 못했습니다.");
						}
						
						session.removeAttribute("tempOrderInfo"); // 임시 정보 삭제
						// =========================================================

						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resp.getWriter().write(responseJson);
						System.out.println("Toss API success response: " + responseJson);
					}
				} else {
					try (BufferedReader br = new BufferedReader(
							new InputStreamReader(conn.getErrorStream(), StandardCharsets.UTF_8))) {
						String errorJson = br.readLine();
						resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						resp.getWriter().write(errorJson);
						System.err.println("Toss API error response: " + errorJson);
					}
				}
			} catch (IOException e) { // Catch for HttpURLConnection's IOException
				System.err.println("HTTP Connection Error (IOException): " + e.getMessage());
				e.printStackTrace();
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				resp.setContentType("application/json");
				resp.setCharacterEncoding("UTF-8");
				resp.getWriter().write("{\"code\":\"NETWORK_ERROR\",\"message\":\"네트워크 통신 오류가 발생했습니다.\"}");
			} finally { // Finally block for HttpURLConnection
				if (conn != null) {
					conn.disconnect();
				}
			}
		} catch (IOException e) { // Catch for Outer try's IOException (e.g., req.getReader(),
									// objectMapper.readTree)
			System.err.println("Request Parsing Error (IOException): " + e.getMessage());
			e.printStackTrace();
			resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			try {
				resp.getWriter().write("{\"code\":\"INVALID_REQUEST\",\"message\":\"요청 데이터 형식이 올바르지 않습니다.\"}");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		} catch (Exception e) { // Catch for any other unexpected Exceptions in the Outer try
			System.err.println("Unhandled Error in PaymentConfirmControl: " + e.getMessage());
			e.printStackTrace();
			resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			try {
				resp.getWriter().write("{\"code\":\"SERVER_ERROR\",\"message\":\"서버 내부 오류가 발생했습니다.\"}");
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
		}
	}
}
