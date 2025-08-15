package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedam.common.DBUtil;
import com.yedam.mapper.CartMapper;
import com.yedam.vo.CartProductVO;

public class CartServiceImpl implements CartService {
	SqlSession sqlSession = DBUtil.getInstance().openSession();
	CartMapper mapper = sqlSession.getMapper(CartMapper.class);

	// 장바구니 상품 목록 조회
	@Override
	public List<CartProductVO> CartProductList(String memberId) {
		return mapper.selectCartProductList(memberId);
	}

	// 장바구니 상품 목록 삭제
	@Override
	public boolean removeCartListSingle(int cartNo) {
		int r = mapper.deleteCartListSingle(cartNo);
		if (r > 0) {
			sqlSession.commit();
			return true;
		}
		return false;
	}

	@Override
	public boolean modifyCartProductPcs(int productPcs, int cartNo) {
		int r = mapper.updateCartListSingle(productPcs, cartNo);
		if (r > 0) {
			sqlSession.commit();
			return true;
		}
		return false;
	}

}
