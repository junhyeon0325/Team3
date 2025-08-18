package com.yedam.mapper;

import com.yedam.vo.ReviewVO;

public interface ReviewMapper {
	int authorityReview(ReviewVO review);
	int insertReview(ReviewVO review);
}

//db랑 연결