package com.yedam.service;

import java.util.List;

import com.yedam.vo.AddCartVO;
import com.yedam.vo.CartProductVO;
import com.yedam.vo.OrderMemberVO;

public interface CartService {

	public List<CartProductVO> CartProductList(String memberId);	// 장바구니 리스트

	public boolean modifyCartProductPcs(int productPcs, int cartNo);// 수량 수정
	
	public boolean removeCartListSingle(int cartNo);	// 장바구니 리스트 단건 삭제

	// 장바구니 모두 삭제 메서드 추가 (회원 ID를 기준으로)
    public int removeCart(String memberId);
    // 만약 memberNo를 사용해야 한다면:
    // public int removeCart(int memberNo);
    public int removeCart(int memberNo);

	public boolean AddCartList(AddCartVO vo);

	public int CountCartList(String memberId); 


}
