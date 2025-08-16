package com.yedam.mapper;

import com.yedam.vo.ReviewVO;

public interface ReviewMapper {
	int authorityReview(ReviewVO review);
	int insertReivew(ReviewVO review);
}

//db랑 연결