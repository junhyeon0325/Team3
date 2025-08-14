package com.yedam.service;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.DetailMapper;
import com.yedam.vo.ProductVO;


public class DetailServiceImpl implements DetailService {
	SqlSession sqlSession = DBUtil.getInstance().openSession(true);
	DetailMapper mapper = sqlSession.getMapper(DetailMapper.class);
	
	@Override
	public ProductVO productDetail(int prductNo) {
		return mapper.selectDetail(prductNo);
	}

}