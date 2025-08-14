package com.yedam.service;

import java.util.List;

import com.yedam.vo.ProductVO;

public interface CartService {

	List<ProductVO> CartList(String member_id);	// 장바구니 리스트

}
