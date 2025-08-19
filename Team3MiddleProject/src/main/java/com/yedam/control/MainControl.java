package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.ProductListService;
import com.yedam.service.ProductListServiceImpl;
import com.yedam.vo.ProductVO;

public class MainControl implements Control{
	
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp)// 
			throws ServletException, IOException {
		//req.getRequestDispatcher("index.jsp").forward(req, resp);
		req.getRequestDispatcher("product/signup_form.tiles")
		.forward(req, resp);
	//	req.getRequestDispatcher("product/cart.tiles").forward(req, resp);
		
		ProductListService prdService = new ProductListServiceImpl();
		List<ProductVO> productList = prdService.selectAllProducts();
		
		req.setAttribute("productList", productList);
		
		req.getRequestDispatcher("product/main.tiles").forward(req, resp);
		
		System.out.println("상품 개수: " + (productList == null ? "null" : productList.size()));
	}
	
}

