package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.CartMapper;
import com.yedam.vo.ProductVO;

public class CartServiceImpl implements CartService {
	SqlSession sqlSession = DBUtil.getInstance().openSession();
	CartMapper mapper = sqlSession.getMapper(CartMapper.class);
	

	@Override
	public List<ProductVO> CartList(String member_id) {
		return mapper.selectCartList(member_id);
	}}
