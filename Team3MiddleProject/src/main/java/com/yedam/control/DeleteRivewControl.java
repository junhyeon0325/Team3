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

public class DeleteRivewControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		resp.setContentType("text/json;charset=utf-8");
		
		HttpSession session = req.getSession();
        String logId = (String) session.getAttribute("logId");
        
        int reviewNo = Integer.parseInt(req.getParameter("reviewNo"));
        ReviewServiceImpl svc = new ReviewServiceImpl();
        ReviewVO review = svc.selectReviewNo(reviewNo);
		
        
        Map<String, Object> result = new HashMap<>();

        if (review != null && review.getMemberId().equals(logId)) {
            boolean success = svc.deleteReview(reviewNo);
            if (success) {
                result.put("status", "SUCCESS");

                // ⭐ 리뷰 삭제 후 해당 상품의 평균 별점 조회
                int productNo = review.getProductNo();
                double avgScore = svc.getProductScore(productNo); // 이 메서드는 아래 참고
                result.put("productScore", avgScore);
        	} else {
        		result.put("status", "FAIL");
        	}
        } else {
        	result.put("status", "FORBIDDEN");
        }
		
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
		resp.getWriter().print(gson.toJson(result));
	}

}
