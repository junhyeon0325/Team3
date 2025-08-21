package com.yedam.service;

import java.util.List;
import java.util.Map;

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
	
	@Override
	public List<ProductVO> relatedProducts(Map<String, Object>param) {
		return mapper.relatedSelect(param);
	}

}