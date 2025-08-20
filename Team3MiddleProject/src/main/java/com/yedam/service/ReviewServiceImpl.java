package com.yedam.service;

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
			mapper.updateProductScore(review.getProductNo());
			sqlSession.commit();
			return true;
		}
		return false;
	}
	
	//페이징 리뷰목록
	@Override
	public List<ReviewVO> reviewList(Map<String, Object> param) {
		return mapper.selectReviewList(param);
	}
	
	//리뷰 카운트
	@Override
	public int countReview(int productNo) {
		return mapper.countReview(productNo);
	}

	public ReviewVO selectReviewNo(int reviewNo) {
		return mapper.selectReviewNo(reviewNo);
		
	}
	//리뷰삭제
	public boolean deleteReview(int reviewNo) {
	    ReviewVO review = mapper.selectReviewNo(reviewNo);
	    if (review == null) return false;
	    int r = mapper.deleteReview(reviewNo);
	    if (r > 0) {
	        mapper.updateProductScore(review.getProductNo());
	        sqlSession.commit();
	        return true;
	    }
	    return false;
	}
	
	public double getProductScore(int productNo) {
	    Double r = mapper.getProductScore(productNo);
	    return r != null ? r : 0.0;
	}
	
}