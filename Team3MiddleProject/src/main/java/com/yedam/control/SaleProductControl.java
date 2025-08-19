package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.SaleProductService;
import com.yedam.service.SaleProductServiceImpl;
import com.yedam.vo.ProductVO;

public class SaleProductControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SaleProductService spd = new SaleProductServiceImpl();
		
		int page = 1;
		int pageSize = 6;
		int totalSaleProduct = spd.countTotalSaleProducts();
		int totalSalePage = (int)Math.ceil((double)totalSaleProduct/pageSize);
		
		
		String pageParam = req.getParameter("page");
        if (pageParam != null)
        {
        	page = Integer.parseInt(pageParam);
        }
		
        List<ProductVO> saleList = spd.selectSaleProductList(page, pageSize);
		
		req.setAttribute("saleList", saleList);
		req.setAttribute("totalSalePage", totalSalePage);
		req.setAttribute("currentPage", page);
		
		req.getRequestDispatcher("product/saleProduct.tiles").forward(req, resp);
	}

}
