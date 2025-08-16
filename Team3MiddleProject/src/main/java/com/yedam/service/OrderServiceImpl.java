package com.yedam.service;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.CartMapper;
import com.yedam.mapper.OrderMapper;
import com.yedam.vo.OrderMemberVO;

public class OrderServiceImpl implements OrderService {
	SqlSession sqlSession = DBUtil.getInstance().openSession();
	OrderMapper mapper = sqlSession.getMapper(OrderMapper.class);
	
	@Override
	public OrderMemberVO OrderMember(String memberId) {
		return mapper.SelectOrderMember(memberId);
	}
	
}
