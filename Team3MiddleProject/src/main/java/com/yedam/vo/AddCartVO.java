package com.yedam.vo;

import lombok.Data;

@Data
public class AddCartVO { // 장바구니 테이블에 넣을 데이터
	private String memberId; // 현제 세션에 있는 아이디
	private int productNo; // 상품번호
	private int productPcs; // 상품수량
}
