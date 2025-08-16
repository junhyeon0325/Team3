package com.yedam.service;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.ReviewMapper;
import com.yedam.vo.ReviewVO;

public class ReviewServiceImpl implements ReviewService {
	SqlSession sqlSession = DBUtil.getInstance().openSession(true);
	ReviewMapper mapper = sqlSession.getMapper(ReviewMapper.class);
	
	public boolean addReview(ReviewVO review) {
		int r = mapper.authorityReview(review);
		if (r > 0) {
			mapper.insertReivew(review);
			sqlSession.commit();
			return true;
		}
		return false;
	}
}