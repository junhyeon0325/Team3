package com.yedam.mapper;

import com.yedam.vo.OrderMemberVO;

public interface OrderMapper {
	public OrderMemberVO SelectOrderMember(String memberId); // 목록.
}
