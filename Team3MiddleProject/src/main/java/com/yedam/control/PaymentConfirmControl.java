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
import com.yedam.service.CartService; // CartService 임포트
import com.yedam.service.CartServiceImpl; // CartServiceImpl 임포트
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
		resp.setContentType("text/json;charset=utf-8");

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
				
                System.out.println("Toss Payments API 요청 본문 (서버): " + requestBody); // 요청 본문 로그


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
						OrderDAO orderDao = new OrderDAO(); // OrderDAO 인스턴스
						CartService cartService = new CartServiceImpl(); // CartService 인스턴스

						// 세션에서 임시 주문 정보 (OrderTempVO) 가져오기
						OrderTempVO tempOrderInfo = (OrderTempVO) session.getAttribute("tempOrderInfo");
						String memberId = (String) session.getAttribute("logId"); // 로그인된 회원 ID 가져오기
                        Integer memberNo = (Integer) session.getAttribute("memberNo"); // 로그인된 회원 번호 가져오기

						if (tempOrderInfo == null) {
							System.err.println("오류: 세션에 임시 주문 정보 (tempOrderInfo)가 없습니다. DB 저장 실패.");
							resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
							resp.setContentType("application/json");
							resp.setCharacterEncoding("UTF-8");
							resp.getWriter()
									.write("{\"code\":\"ORDER_DATA_MISSING\",\"message\":\"주문 정보가 세션에 없습니다.\"}");
							return;
						}

						// 1. tbl_order에 저장할 데이터 준비
						OrderVO orderVO = new OrderVO();
						long orderNo = orderDao.getNextOrderNo();

						orderVO.setOrderNo(orderNo);
						orderVO.setOrderAddress(tempOrderInfo.getOrderAddress());
						orderVO.setUsedPoint(tempOrderInfo.getUsedPoint());
						orderVO.setOrderPrice((int) amount); // Toss에서 받은 amount를 사용
						orderVO.setOrderRequest(tempOrderInfo.getOrderRequest());
						orderVO.setMemberNo(tempOrderInfo.getMemberNo());

						// 2. tbl_order에 주문 정보 삽입
						int orderResult = orderDao.insertOrder(orderVO);
						System.out.println("tbl_order 삽입 결과: " + (orderResult > 0 ? "성공" : "실패"));

						// 3. tbl_order_items 삽입
                        List<CartProductVO> cartList = tempOrderInfo.getCartList();
                        if (orderResult > 0 && cartList != null && !cartList.isEmpty()) { 
                            int orderItemsResult = orderDao.insertOrderItems(orderNo, cartList);
                            System.out.println("tbl_order_items 삽입 결과: " + orderItemsResult + "건 삽입");
                            
                            // 🌟🌟🌟 추가: 장바구니 데이터 삭제 로직 🌟🌟🌟
                            if (orderItemsResult > 0) { // 주문 상세 항목이 성공적으로 삽입되었다면
                                if (memberId != null && !memberId.isEmpty()) {
                                    int deletedCartItems = cartService.removeCart(memberId);
                                    System.out.println("장바구니에서 " + deletedCartItems + "개의 항목이 삭제되었습니다. (회원 ID: " + memberId + ")");
                                } else if (memberNo != null && memberNo > 0) { // memberId가 없으면 memberNo 사용 (DB 스키마에 따라 선택)
                                	// 🌟 수정: memberNo를 사용하여 removeCart 메서드 호출 (int value로 변환)
                                    int deletedCartItems = cartService.removeCart(memberNo.intValue()); 
                                    System.out.println("장바구니에서 " + deletedCartItems + "개의 항목이 삭제되었습니다. (회원 번호: " + memberNo + ")");
                                } else {
                                    System.err.println("경고: 로그인된 회원 정보를 찾을 수 없어 장바구니를 비우지 못했습니다.");
                                }
                                // 세션에 저장된 장바구니 목록도 삭제
                                session.removeAttribute("cp_list"); 
                            }
                        } else {
                            System.out.println("경고: 장바구니 목록(cartList)이 비어 있거나 tbl_order 삽입 실패로 인해 주문 상세 항목을 저장하지 못했습니다.");
                        }
						
						session.removeAttribute("tempOrderInfo"); // 임시 주문 정보 삭제

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
			} catch (IOException e) {
				System.err.println("HTTP Connection Error (IOException): " + e.getMessage());
				e.printStackTrace();
				resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
				resp.setContentType("application/json");
				resp.setCharacterEncoding("UTF-8");
				try {
					resp.getWriter().write("{\"code\":\"NETWORK_ERROR\",\"message\":\"네트워크 통신 오류가 발생했습니다.\"}");
				} catch (IOException e1) {
					e1.printStackTrace();
				}
			} finally {
				if (conn != null) {
					conn.disconnect();
				}
			}
		} catch (IOException e) {
			System.err.println("Request Parsing Error (IOException): " + e.getMessage());
			e.printStackTrace();
			resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			try {
				resp.getWriter().write("{\"code\":\"INVALID_REQUEST\",\"message\":\"요청 데이터 형식이 올바르지 않습니다.\"}");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		} catch (Exception e) {
			System.err.println("Unhandled Error in PaymentConfirmControl: " + e.getMessage());
			e.printStackTrace();
			resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			resp.setContentType("application/json");
			resp.setCharacterEncoding("UTF-8");
			try {
				resp.getWriter().write("{\"code\":\"SERVER_ERROR\",\"message\":\"서버 내부 오류가 발생했습니다.\"}");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}
}
