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

public class ProductListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ProductListService svc = new ProductListServiceImpl();
		List<ProductVO> list = svc.getProductList(); // 글목록.
		
		req.setAttribute("products",list);
		
		req.getRequestDispatcher("product/productList.tiles").forward(req, resp);
	}

}
