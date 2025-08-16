package com.yedam.service;

import java.util.List;

import com.yedam.vo.CartProductVO;
import com.yedam.vo.OrderMemberVO;

public interface CartService {

	public List<CartProductVO> CartProductList(String memberId);	// 장바구니 리스트

	public boolean modifyCartProductPcs(int productPcs, int cartNo);// 수량 수정
	
	public boolean removeCartListSingle(int cartNo);	// 장바구니 리스트 단건 삭제





}
