package com.yedam.mapper;

import java.util.List;

import com.yedam.vo.CartProductVO;

public interface CartMapper {
	public List<CartProductVO> selectCartProductList(String memberId); // 목록.
	
}
