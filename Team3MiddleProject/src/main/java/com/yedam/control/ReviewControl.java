package com.yedam.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yedam.common.Control;
import com.yedam.service.ReviewServiceImpl;
import com.yedam.vo.ReviewVO;

public class ReviewControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");
		HttpSession session = req.getSession();
		
		String memberId = (String)session.getAttribute("member_id");
		String memberName = (String)session.getAttribute("member_name");
		
		Map<String, Object> map = new HashMap<>();
		
		if(memberId == null) {
			map.put("status", "NOT_LOGIN");
			Gson gson = new GsonBuilder().setPrettyPrinting().create();
			resp.getWriter().print(gson.toJson(map));
			return;
		}
		
		String productNo = req.getParameter("productNo");
		String reviewContent = req.getParameter("reviewContent");
		Double reviewScore = Double.parseDouble(req.getParameter("reviewScore"));
		
		ReviewVO vo = new ReviewVO();
		vo.setMemberId(memberId);
		vo.setMemberName(memberName);
		vo.setProductNo(Integer.parseInt(productNo));
		vo.setReviewContent(reviewContent);
		vo.setReviewScore(reviewScore);
				
		ReviewServiceImpl svc = new ReviewServiceImpl();
		boolean result = svc.addReview(vo);
		
		if(result) {
			map.put("status", "SUCCESS");
			map.put("review", vo);
		} else {
			map.put("status", "NO_ORDER");
		}
		
		Gson gson = new GsonBuilder().setPrettyPrinting().create();
		resp.getWriter().print(gson.toJson(map));
		
		
	}

}
