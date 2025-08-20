package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;

public class PaymentSuccessControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");

		try {
            // success.jsp로 포워드
            req.getRequestDispatcher("/WEB-INF/jsp/success.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }

	}

}
