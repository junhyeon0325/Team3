package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;
import com.yedam.service.OrderService;
import com.yedam.service.OrderServiceImpl;
import com.yedam.vo.CartProductVO;
import com.yedam.vo.OrderMemberVO;

public class OrderFormControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");
		
		HttpSession session = req.getSession(); // 세션 객체 가져오기
		String memberId = (String) session.getAttribute("logId"); // 실제 로그인 ID를 세션에서 가져옴
		if (memberId == null) {
			// 로그인되지 않은 경우의 처리: 로그인 페이지로 리디렉션하거나, 테스트용 ID 사용
			memberId = "jjh"; // 테스트를 위해 임시로 하드코딩된 ID (이 ID가 DB에 존재하는 회원이어야 합니다!)
		}

		CartService svc = new CartServiceImpl(); // 장바구니 서비스 호출
		List<CartProductVO> list = svc.CartProductList(memberId); // 현재 로그인한 ID의 장바구니 상품상세 출력

		OrderService svco = new OrderServiceImpl(); // 주문/결제 서비스 호출, svco는 svc에 Order의 o를 붙임
		OrderMemberVO vo = svco.OrderMember(memberId); // 현재 로그인한 ID의 회원정보를 가져오는 서비스실행

		System.out.println("장바구니 목록 (OrderFormControl): " + list);
		System.out.println("회원 정보 (OrderFormControl): " + vo);

		req.setAttribute("cp_list", list); // CartProduct약자 cp

		// 중요: cp_list (장바구니 목록)와 memberNo를 세션에 저장하여 다른 컨트롤러에서 접근할 수 있도록 합니다.
		session.setAttribute("cp_list", list); // <<--- cp_list를 세션에 저장
		if (vo != null) { // OrderMemberVO가 null이 아닌지 확인
			session.setAttribute("memberNo", vo.getMemberNo()); // <<--- memberNo를 세션에 저장
		} else {
			System.err.println("경고: OrderMemberVO가 null이거나 memberNo를 가져올 수 없습니다. memberNo=0으로 진행.");
			session.setAttribute("memberNo", 0); // 기본값 0으로 설정 (FK 오류 발생 가능성 있음)
		}
		req.setAttribute("om", vo);
		req.getRequestDispatcher("product/order.tiles").forward(req, resp);

		
	}

}