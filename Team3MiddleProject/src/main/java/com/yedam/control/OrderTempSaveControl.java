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
		resp.setContentType("text/json;charset=utf-8");

        ObjectMapper objectMapper = new ObjectMapper();
        HttpSession session = req.getSession();

        try {
            String requestBody = req.getReader().lines().collect(Collectors.joining());
            JsonNode jsonNode = objectMapper.readTree(requestBody);

            // ====================================================================
            // 시작: 주소 파싱 로직 수정 (sample5_address 하나만 받음)
            // ====================================================================
            String finalOrderAddress = jsonNode.has("orderAddress") ? jsonNode.get("orderAddress").asText().trim() : "";
            // ====================================================================
            // 끝: 주소 파싱 로직 수정
            // ====================================================================
            
            // 디버깅: 최종 주소 값이 제대로 넘어오는지 확인
            System.out.println("OrderTempSaveControl - Final Order Address: '" + finalOrderAddress + "'");

            String orderRequest = jsonNode.has("orderRequest") ? jsonNode.get("orderRequest").asText().trim() : ""; 
            int usedPoint = jsonNode.has("usedPoint") ? jsonNode.get("usedPoint").asInt() : 0;
            
            Integer memberNoObj = (Integer) session.getAttribute("memberNo"); 
            int memberNo = (memberNoObj != null) ? memberNoObj : 0; 

            @SuppressWarnings("unchecked")
            List<CartProductVO> cartList = (List<CartProductVO>) session.getAttribute("cp_list");

            OrderTempVO tempOrder = new OrderTempVO();
            tempOrder.setOrderAddress(finalOrderAddress); 
            tempOrder.setOrderRequest(orderRequest);
            tempOrder.setUsedPoint(usedPoint);
            tempOrder.setMemberNo(memberNo);      
            tempOrder.setCartList(cartList);      

            session.setAttribute("tempOrderInfo", tempOrder);

            System.out.println("Temporary order info saved to session: " + tempOrder); 

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