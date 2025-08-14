package com.yedam.service;

import java.util.List;

import com.yedam.vo.CartProductVO;

public interface CartService {

	public List<CartProductVO> CartProductList(String memberId);	// 장바구니 리스트



}
