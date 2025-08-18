package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;

public class RemoveCartListSingleControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 삭제할 상품번호 불러오기
		String cno = req.getParameter("cno");
		
		// 서비스 호출
		CartService svc = new CartServiceImpl();
		if(svc.removeCartListSingle(Integer.parseInt(cno))) {
			resp.getWriter().print("{\"retCode\":\"OK\"}");
		} else {
			resp.getWriter().print("{\"retCode\":\"NG\"}");
		}
		
	}

}
