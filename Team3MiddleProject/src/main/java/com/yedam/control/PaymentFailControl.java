package com.yedam.control;

import com.yedam.common.Control;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PaymentFailControl implements Control {
    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) {
		resp.setContentType("text/json;charset=utf-8");

        try {
            // fail.jsp로 포워드
            req.getRequestDispatcher("/WEB-INF/jsp/fail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}