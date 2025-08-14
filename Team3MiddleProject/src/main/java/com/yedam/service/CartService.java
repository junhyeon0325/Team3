package com.yedam.service;

import java.util.List;

import com.yedam.vo.ProductVO;

public interface CartService {

	public List<ProductVO> cartList(String memberId);	// 장바구니 리스트

}
