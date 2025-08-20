package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.SearchService;
import com.yedam.service.SearchServiceImpl;
import com.yedam.vo.SearchVO;

public class SearchControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pd = req.getParameter("value");	// 받은 상품파라미터값을 pd(product)에 저장
		SearchService svc = new SearchServiceImpl();
		List<SearchVO> list = svc.searchList(pd);
		
		req.setAttribute("searchList", list);
		req.getRequestDispatcher("product/test.tiles").forward(req, resp);
	}

}
