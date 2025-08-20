package com.yedam.service;

import java.util.List;
import java.util.Map;

import com.yedam.vo.ReviewVO;

public interface ReviewService {
	boolean addReview(ReviewVO review);
	List<ReviewVO> reviewList(Map<String, Object> param);
	int countReview(int productNo);
}
//실행