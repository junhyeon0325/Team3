package com.yedam.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession; // SqlSession 임포트 유지

import com.yedam.common.DBUtil; // DBUtil 임포트 유지
import com.yedam.mapper.CartMapper; // CartMapper 임포트 유지
import com.yedam.vo.CartProductVO; // CartProductVO 임포트 유지

public class CartServiceImpl implements CartService {
	// 🌟 수정: SqlSession과 CartMapper 인스턴스는 각 메서드에서 새롭게 얻거나,
	//       생성자에서 SqlSession을 필드로 유지하고 각 메서드에서 사용할 수 있도록 구조 변경
	//       (현재 DBUtil.getInstance().openSession()은 매번 새로운 세션을 열게 됩니다.)
	//       여기서는 기존 코드의 흐름을 유지하되, commit/close를 추가하는 방식으로 진행합니다.
	//       더 효율적인 방법은 SqlSession을 필드로 두고, 각 트랜잭션마다 commit/rollback/close를 관리하는 것입니다.

	// 이전에 전역 변수로 선언했던 SqlSession은 각 메서드마다 새로운 세션을 열어야 하므로 삭제합니다.
	// SqlSession sqlSession = DBUtil.getInstance().openSession();
	// CartMapper mapper = sqlSession.getMapper(CartMapper.class);

	// 장바구니 상품 목록 조회
	@Override
	public List<CartProductVO> CartProductList(String memberId) {
		SqlSession sqlSession = DBUtil.getInstance().openSession(); // 🌟 추가: 메서드 시작 시 SqlSession 열기
		CartMapper mapper = sqlSession.getMapper(CartMapper.class); // 🌟 추가: Mapper 얻기
		try {
			return mapper.selectCartProductList(memberId);
		} finally {
			sqlSession.close(); // 🌟 추가: 세션 닫기
		}
	}

	// 장바구니 상품 목록 삭제 (단건)
	@Override
	public boolean removeCartListSingle(int cartNo) {
		SqlSession sqlSession = DBUtil.getInstance().openSession(); // 🌟 추가: 메서드 시작 시 SqlSession 열기
		CartMapper mapper = sqlSession.getMapper(CartMapper.class); // 🌟 추가: Mapper 얻기
		try {
			int r = mapper.deleteCartListSingle(cartNo);
			if (r > 0) {
				sqlSession.commit(); // 🌟 유지: 커밋
				return true;
			}
			return false;
		} finally {
			sqlSession.close(); // 🌟 추가: 세션 닫기
		}
	}
	
	// 장바구니 상품 목록 수정
	@Override
	public boolean modifyCartProductPcs(int productPcs, int cartNo) {
		SqlSession sqlSession = DBUtil.getInstance().openSession(); // 🌟 추가: 메서드 시작 시 SqlSession 열기
		CartMapper mapper = sqlSession.getMapper(CartMapper.class); // 🌟 추가: Mapper 얻기
		try {
			int r = mapper.updateCartListSingle(productPcs, cartNo);
			if (r > 0) {
				sqlSession.commit(); // 🌟 유지: 커밋
				return true;
			}
			return false;
		} finally {
			sqlSession.close(); // 🌟 추가: 세션 닫기
		}
	}

	// 장바구니 전체 삭제 (회원 ID 기준)
	@Override
	public int removeCart(String memberId) {
        SqlSession sqlSession = DBUtil.getInstance().openSession(); // 🌟 추가: 메서드 시작 시 SqlSession 열기
        CartMapper mapper = sqlSession.getMapper(CartMapper.class); // 🌟 추가: Mapper 얻기
        try {
            int result = mapper.deleteCartByMemberId(memberId);
            if (result > 0) {
                sqlSession.commit(); // 🌟 추가: 커밋!
            }
            return result;
        } catch (Exception e) {
            System.err.println("장바구니(ID) 삭제 중 오류 발생: " + e.getMessage());
            sqlSession.rollback(); // 🌟 추가: 오류 시 롤백
            return 0; // 실패를 나타내는 값 반환
        } finally {
            sqlSession.close(); // 🌟 추가: 세션 닫기
        }
	}

	// 장바구니 전체 삭제 (회원 번호 기준)
	@Override
	public int removeCart(int memberNo) {
        SqlSession sqlSession = DBUtil.getInstance().openSession(); // 🌟 추가: 메서드 시작 시 SqlSession 열기
        CartMapper mapper = sqlSession.getMapper(CartMapper.class); // 🌟 추가: Mapper 얻기
        try {
            int result = mapper.deleteCartByMemberNo(memberNo);
            if (result > 0) {
                sqlSession.commit(); // 🌟 추가: 커밋!
            }
            return result;
        } catch (Exception e) {
            System.err.println("장바구니(No) 삭제 중 오류 발생: " + e.getMessage());
            sqlSession.rollback(); // 🌟 추가: 오류 시 롤백
            return 0; // 실패를 나타내는 값 반환
        } finally {
            sqlSession.close(); // 🌟 추가: 세션 닫기
        }
	}
}
