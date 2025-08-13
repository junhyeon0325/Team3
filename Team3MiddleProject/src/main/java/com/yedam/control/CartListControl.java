package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;

public class CartListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		
		ppcs = "5";	// 테스트
		
		//CartService svc = new CartServiceImpl();
		
		req.setAttribute("productPcs", Integer.parseInt(ppcs) );
		
		req.getRequestDispatcher("product/cart.tiles").forward(req, resp);
	}

}
