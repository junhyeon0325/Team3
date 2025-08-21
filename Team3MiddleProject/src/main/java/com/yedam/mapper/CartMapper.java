package com.yedam.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yedam.vo.AddCartVO;
import com.yedam.vo.CartProductVO;

public interface CartMapper {
	public List<CartProductVO> selectCartProductList(String memberId); // 목록.

	public int deleteCartListSingle(int cartNo);	// 장바구니 상품 목록 삭제

	public int updateCartListSingle(@Param("productPcs")int productPcs, @Param("cartNo")int cartNo);	// 장바구니 수량 수정

	public int deleteCartByMemberId(String memberId);

	public int deleteCartByMemberNo(int memberNo);

	public int insertCartList(AddCartVO vo);

	public int SelectCartList(String memberId);
	
}
