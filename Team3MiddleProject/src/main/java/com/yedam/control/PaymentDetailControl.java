package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fasterxml.jackson.databind.JsonNode; // Jackson 라이브러리 추가
import com.yedam.common.Control;

public class PaymentDetailControl implements Control {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
        // PaymentController의 showPaymentDetail 메서드 로직을 여기에 옮깁니다.
        // 세션에서 결제 상세 정보를 가져와서 request 속성에 저장하고 JSP로 포워드합니다.
        JsonNode paymentDetail = (JsonNode) req.getSession().getAttribute("paymentDetail");

        if (paymentDetail != null) {
            try {
                // 결제 정보를 request 속성에 저장
                req.setAttribute("paymentKey", paymentDetail.get("paymentKey").asText());
                req.setAttribute("orderId", paymentDetail.get("orderId").asText());
                req.setAttribute("orderName", paymentDetail.get("orderName").asText());
                req.setAttribute("totalAmount", paymentDetail.get("totalAmount").asLong());
                req.setAttribute("method", paymentDetail.get("method").asText());
                req.setAttribute("requestedAt", paymentDetail.get("requestedAt").asText());
                
                // 상세 내역 페이지로 이동 (WEB-INF/jsp/paymentDetail.jsp)
                req.getRequestDispatcher("/WEB-INF/jsp/paymentDetail.jsp").forward(req, resp);
                
            } catch (ServletException | IOException e) {
                e.printStackTrace();
                // 오류 발생 시 fail.jsp로 리디렉션하거나 오류 메시지 표시
                try {
                    resp.sendRedirect(req.getContextPath() + "/paymentFail.do?code=DETAIL_ERROR&message=결제 상세정보 조회 실패");
                } catch (IOException redirectException) {
                    redirectException.printStackTrace();
                }
            }
        } else {
            // 세션에 정보가 없으면 실패 페이지로 리디렉션
            try {
                resp.sendRedirect(req.getContextPath() + "/paymentFail.do?code=NO_DETAIL&message=결제 상세정보를 찾을 수 없습니다.");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
