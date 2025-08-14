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
		
		//카테고리
		/*String maincategory = req.getParameter("maincategory");
		String subcategory = req.getParameter("subcategory");
		
		CategoryService ctg = new CategoryServiceImpl();
		List<ProductVO> categoryList = ctg.getCategoryList();
		
		req.setAttribute("categoryList", categoryList);
		*/

		//상품리스트
		ProductListService prd = new ProductListServiceImpl();
		List<ProductVO> productList = prd.getProductList();
		
		req.setAttribute("productList", productList);
		
		req.getRequestDispatcher("product/productList.tiles").forward(req, resp);
	}

}