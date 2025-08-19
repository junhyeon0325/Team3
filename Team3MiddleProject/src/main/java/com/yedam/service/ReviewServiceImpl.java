package com.yedam.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.ReviewMapper;
import com.yedam.vo.ReviewVO;

public class ReviewServiceImpl implements ReviewService {
	SqlSession sqlSession = DBUtil.getInstance().openSession();
	ReviewMapper mapper = sqlSession.getMapper(ReviewMapper.class);
	
	//권한체크 및 등록
	public boolean addReview(ReviewVO review) {
		int r = mapper.authorityReview(review);
		if (r > 0) {
			mapper.insertReview(review);
			sqlSession.commit();
			return true;
		}
		return false;
	}
	
	//페이징 리뷰목록
	@Override
	public List<ReviewVO> reviewList(int productNo, int page) {
		int start = (page - 1)* 5 + 1;
		int end = start + 4;
		Map<String, Object> param = new HashMap<>();
		param.put("productNo", productNo);
		param.put("start", start);
		param.put("end", end);
		return mapper.selectReviewList(param);
	}
	
	//리뷰 카운트
	@Override
	public int countReview(int productNo) {
		return mapper.countReview(productNo);
	}
	
}