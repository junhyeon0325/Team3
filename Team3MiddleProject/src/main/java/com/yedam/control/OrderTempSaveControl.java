package com.yedam.control;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.yedam.common.Control;
import com.yedam.vo.CartProductVO; // CartProductVO 임포트
import com.yedam.vo.OrderTempVO; // OrderTempVO 임포트 (아래에서 정의)

public class OrderTempSaveControl implements Control {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        ObjectMapper objectMapper = new ObjectMapper();
        HttpSession session = req.getSession();

        try {
            // 클라이언트에서 보낸 JSON 데이터를 읽습니다.
            String requestBody = req.getReader().lines().collect(Collectors.joining());
            JsonNode jsonNode = objectMapper.readTree(requestBody);

            // OrderTempVO에 담을 데이터를 파싱합니다.
            String orderAddress = jsonNode.has("orderAddress") ? jsonNode.get("orderAddress").asText() : null;
            String orderDetailAddress = jsonNode.has("orderDetailAddress") ? jsonNode.get("orderDetailAddress").asText() : null;
            String orderRequest = jsonNode.has("orderRequest") ? jsonNode.get("orderRequest").asText() : null;
            int usedPoint = jsonNode.has("usedPoint") ? jsonNode.get("usedPoint").asInt() : 0;
            // memberNo는 이미 세션에 있다고 가정합니다. (로그인된 사용자)
            int memberNo = session.getAttribute("memberNo") != null ? (Integer) session.getAttribute("memberNo") : 0; // 예시: 실제 로그인 memberNo 사용

            // 장바구니 목록은 이미 세션에 있다고 가정합니다.
            @SuppressWarnings("unchecked")
            List<CartProductVO> cartList = (List<CartProductVO>) session.getAttribute("cp_list");

            // 임시 주문 정보를 OrderTempVO 객체에 담습니다.
            OrderTempVO tempOrder = new OrderTempVO();
            tempOrder.setOrderAddress(orderAddress + " " + orderDetailAddress);
            tempOrder.setOrderRequest(orderRequest);
            tempOrder.setUsedPoint(usedPoint);
            tempOrder.setMemberNo(memberNo);
            tempOrder.setCartList(cartList); // 장바구니 목록도 임시 정보로 함께 저장

            // 세션에 임시 주문 정보를 저장합니다.
            session.setAttribute("tempOrderInfo", tempOrder);

            System.out.println("Temporary order info saved to session: " + tempOrder);

            // 성공 응답
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"status\":\"success\", \"message\":\"Temporary order data saved.\"}");

        } catch (IOException e) {
            e.printStackTrace();
            try {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                resp.setContentType("application/json");
                resp.setCharacterEncoding("UTF-8");
                resp.getWriter().write("{\"status\":\"error\", \"message\":\"Failed to save temporary order data.\"}");
            } catch (IOException ioException) {
                ioException.printStackTrace();
            }
        }
    }
}
