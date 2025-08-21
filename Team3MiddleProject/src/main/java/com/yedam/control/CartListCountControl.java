package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;

public class CartListCountControl implements Control {
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");
		
		HttpSession session = req.getSession(); // 세션 객체 부르기
		String memberId = (String) session.getAttribute("logId"); // 세션의 logId에있는 값을 memberId에 넣기
		if (memberId == null) {
	        resp.getWriter().print("{\"count\":0}");
	        return;
	    }
		
		CartService svc = new CartServiceImpl();
		int cartCount = svc.CountCartList(memberId);

		resp.getWriter().print("{\"count\":" + cartCount + "}");	
	}
}
