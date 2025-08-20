package com.yedam.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yedam.common.Control;
import com.yedam.common.PageDTO;
import com.yedam.service.ReviewService;
import com.yedam.service.ReviewServiceImpl;
import com.yedam.vo.ReviewVO;

public class ReviewListControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/json;charset=utf-8");
		
		int productNo = Integer.parseInt(req.getParameter("productNo"));
		int page = req.getParameter("page") == null ? 1 : Integer.parseInt(req.getParameter("page"));

		ReviewService svc = new ReviewServiceImpl();
		
		int totalCnt = svc.countReview(productNo);
		
		PageDTO paging = new PageDTO(page,totalCnt);
		
		Map<String, Object> param = new HashMap<>();
		param.put("productNo", productNo);
		param.put("start", (page-1) * 5 + 1);
		param.put("end", page * 5);
		
		List<ReviewVO> list = svc.reviewList(param);
		
		Map<String, Object> pagingMap = new HashMap<>();
		pagingMap.put("page", paging.getCurrPage());
		pagingMap.put("startPage", paging.getStart());
		pagingMap.put("endPage", paging.getEnd());
		pagingMap.put("prev", paging.isPrevious());
		pagingMap.put("next", paging.isNext());

		
		Map<String, Object> result = new HashMap<>();
		result.put("list", list);
		result.put("paging", pagingMap);
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		resp.getWriter().print(gson.toJson(result));
		
	}	

}
