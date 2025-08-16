package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

		// HttpSession session = req.getSession();
		String memberId = "jjh";// (String) session.getAttribute("logId");
		
		CartService svc = new CartServiceImpl();	// 장바구니 서비스 호출
		List<CartProductVO> list = svc.CartProductList(memberId); // 현재 로그인한 ID의 장바구니 상품상세 출력
		
		OrderService svco = new OrderServiceImpl();	// 주문/결제 서비스 호출, svco는 svc에 Order의 o를 붙임
		OrderMemberVO vo = svco.OrderMember(memberId);	// 현재 로그인한 ID의 회원정보를 가져오는 서비스실행
		
		System.out.println(list);
		System.out.println(vo);
		
		req.setAttribute("cp_list", list);	// CartProduct약자 cp
		req.setAttribute("om", vo);	// OrderMember약자 om
		req.getRequestDispatcher("product/order.tiles").forward(req, resp);
	}

}
