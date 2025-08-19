package com.yedam.control;

import com.yedam.common.Control;
import com.yedam.vo.CartProductVO;
import com.yedam.vo.OrderTempVO;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

public class OrderTempSaveControl implements Control {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        ObjectMapper objectMapper = new ObjectMapper();
        HttpSession session = req.getSession();

        try {
            String requestBody = req.getReader().lines().collect(Collectors.joining());
            JsonNode jsonNode = objectMapper.readTree(requestBody);

            String orderAddressPart = jsonNode.has("orderAddress") ? jsonNode.get("orderAddress").asText() : "";
            String orderDetailAddressPart = jsonNode.has("orderDetailAddress") ? jsonNode.get("orderDetailAddress").asText() : "";
            String orderAddress = (orderAddressPart.trim() + " " + orderDetailAddressPart.trim()).trim();
            
            String orderRequest = jsonNode.has("orderRequest") ? jsonNode.get("orderRequest").asText() : "";
            int usedPoint = jsonNode.has("usedPoint") ? jsonNode.get("usedPoint").asInt() : 0;
            
            // 세션에서 memberNo 가져오기 (OrderFormControl에서 설정된 값)
            Integer memberNoObj = (Integer) session.getAttribute("memberNo"); 
            int memberNo = (memberNoObj != null) ? memberNoObj : 0; // 세션에 없으면 0으로 설정 (주의: FK 오류 유발 가능)

            // 세션에서 장바구니 목록 (cp_list) 가져오기
            @SuppressWarnings("unchecked")
            List<CartProductVO> cartList = (List<CartProductVO>) session.getAttribute("cp_list");

            OrderTempVO tempOrder = new OrderTempVO();
            tempOrder.setOrderAddress(orderAddress);
            tempOrder.setOrderRequest(orderRequest);
            tempOrder.setUsedPoint(usedPoint);
            tempOrder.setMemberNo(memberNo);      // 세션에서 가져온 memberNo 설정
            tempOrder.setCartList(cartList);      // 세션에서 가져온 cartList 설정

            session.setAttribute("tempOrderInfo", tempOrder);

            System.out.println("Temporary order info saved to session: " + tempOrder); // 이 로그를 통해 실제 저장된 값 확인

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