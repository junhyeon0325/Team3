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

            // ====================================================================
            // 시작: ORDER_ADDRESS 오류 해결을 위한 주소 파싱 및 조합 수정
            // ====================================================================
            // JSON에서 각 주소 필드를 안전하게 가져오고, 바로 trim() 처리합니다.
            // null 체크 대신 has()를 사용하고, 값이 없으면 빈 문자열로 초기화합니다.
            String postcode = jsonNode.has("postcode") ? jsonNode.get("postcode").asText().trim() : "";
            String basicAddress = jsonNode.has("orderAddress") ? jsonNode.get("orderAddress").asText().trim() : "";
            String detailAddress = jsonNode.has("orderDetailAddress") ? jsonNode.get("orderDetailAddress").asText().trim() : "";
            
            // 디버깅: 각 주소 필드 값이 제대로 넘어오는지 확인
            // 콘솔 인코딩 문제로 한글이 깨져 보여도, 실제 문자열 값은 제대로 넘어올 수 있습니다.
            System.out.println("OrderTempSaveControl - Parsed Postcode: '" + postcode + "'");
            System.out.println("OrderTempSaveControl - Parsed Basic Address: '" + basicAddress + "'");
            System.out.println("OrderTempSaveControl - Parsed Detail Address: '" + detailAddress + "'");

            // 최종 ORDER_ADDRESS 문자열을 조합합니다.
            StringBuilder fullAddressBuilder = new StringBuilder();
            
            if (!postcode.isEmpty()) {
                fullAddressBuilder.append("(").append(postcode).append(") ");
            }
            if (!basicAddress.isEmpty()) {
                fullAddressBuilder.append(basicAddress);
            }
            if (!detailAddress.isEmpty()) {
                // 기본 주소가 있으면 띄어쓰기 후 상세 주소 추가, 없으면 바로 추가
                if (fullAddressBuilder.length() > 0 && !basicAddress.isEmpty()) { // 앞에 주소 내용이 있고, 기본 주소가 비어있지 않은 경우만 띄어쓰기
                    fullAddressBuilder.append(" ");
                }
                fullAddressBuilder.append(detailAddress);
            }
            
            String finalOrderAddress = fullAddressBuilder.toString().trim(); // 최종 주소 문자열 앞뒤 공백 제거
            // ====================================================================
            // 끝: ORDER_ADDRESS 오류 해결을 위한 주소 파싱 및 조합 수정
            // ====================================================================

            String orderRequest = jsonNode.has("orderRequest") ? jsonNode.get("orderRequest").asText().trim() : "";
            int usedPoint = jsonNode.has("usedPoint") ? jsonNode.get("usedPoint").asInt() : 0;
            
            Integer memberNoObj = (Integer) session.getAttribute("memberNo"); 
            int memberNo = (memberNoObj != null) ? memberNoObj : 0; 

            @SuppressWarnings("unchecked")
            List<CartProductVO> cartList = (List<CartProductVO>) session.getAttribute("cp_list");

            OrderTempVO tempOrder = new OrderTempVO();
            tempOrder.setOrderAddress(finalOrderAddress); // <<--- 조합된 최종 주소 설정
            tempOrder.setOrderRequest(orderRequest);
            tempOrder.setUsedPoint(usedPoint);
            tempOrder.setMemberNo(memberNo);      
            tempOrder.setCartList(cartList);      

            session.setAttribute("tempOrderInfo", tempOrder);

            // 디버깅: 최종 OrderTempVO에 저장된 값 확인
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