package com.yedam.mapper;

import java.util.List;
import java.util.Map;

import com.yedam.vo.ReviewVO;

public interface ReviewMapper {
	int authorityReview(ReviewVO review);
	int insertReview(ReviewVO review);
	List<ReviewVO> selectReviewList(Map<String, Object>param);
	int countReview(int productNo);
	int updateProductScore(int productNo);
}

//db랑 연결