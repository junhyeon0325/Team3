package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.DetailService;
import com.yedam.service.DetailServiceImpl;
import com.yedam.vo.ProductVO;

public class DetailSelectcontrol implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int prno = Integer.parseInt(req.getParameter("productNo"));
		
		DetailService svc = new DetailServiceImpl();
		ProductVO product = svc.productDetail(prno); 
		
		req.setAttribute("product", product);
		
		req.getRequestDispatcher("product/productDetail.tiles")
		.forward(req, resp);
	}

}
