package com.yedam.service;

import java.util.List;

import com.yedam.vo.ReviewVO;

public interface ReviewService {
	boolean addReview(ReviewVO review);
	List<ReviewVO> reviewList(int productNo, int page);
	int countReview(int productNo);
}
//실행