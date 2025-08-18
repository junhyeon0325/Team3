package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;

public class ModifyCartProductPcsControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 파라미터
		String cno = req.getParameter("cno");	// cartNo
		String pcs = req.getParameter("pcs");	// productPcs
		System.out.println(cno + "," + pcs);
		
		CartService svc = new CartServiceImpl();
		if(svc.modifyCartProductPcs(Integer.parseInt(pcs), Integer.parseInt(cno))){
			resp.getWriter().print("{\"retCode\":\"OK\"}");
		} else {
			resp.getWriter().print("{\"retCode\":\"NG\"}");
		}
		
		
	}

}
