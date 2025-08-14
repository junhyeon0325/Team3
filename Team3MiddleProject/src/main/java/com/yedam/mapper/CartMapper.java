package com.yedam.mapper;

import java.util.List;

import com.yedam.vo.ProductVO;

public interface CartMapper {
	public List<ProductVO> selectCartList(String member_id); // 목록.
	
}
