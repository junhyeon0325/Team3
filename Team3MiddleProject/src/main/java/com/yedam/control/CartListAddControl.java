package com.yedam.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedam.common.Control;
import com.yedam.service.CartService;
import com.yedam.service.CartServiceImpl;
import com.yedam.vo.AddCartVO;

public class CartListAddControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/json;charset=utf-8");
		
		HttpSession session = req.getSession(); // 세션 객체 부르기
		String memberId = (String) session.getAttribute("logId"); // 세션의 logId에있는 값을 memberId에 넣기
		if( memberId == null ) {
			resp.getWriter().print("{\"retCode\":\"loginNo\"}");
			return;
		}
		String pno = req.getParameter("productNo"); // productNo 파라미터값 받기
		String pcs = req.getParameter("productPcs"); // productPcs 파라미터값 받기
		
		// 위에서 받은 파라미터값을 AddCartVO객체에 담기
		AddCartVO vo = new AddCartVO();
		vo.setMemberId(memberId);
		vo.setProductNo(Integer.parseInt(pno));
		vo.setProductPcs(Integer.parseInt(pcs));
		
		// 서비스 호출 및 실행
		CartService svc = new CartServiceImpl();
		boolean b = svc.AddCartList(vo);
		
		// 만약에 장바구니에 데이터가 들어갔으면 true실행 안들어갔다면 false실행
		if( b ) {
			resp.getWriter().print("{\"retCode\":\"OK\"}");
		} else {
			resp.getWriter().print("{\"retCode\":\"NG\"}");
		}
		
		
	}

}
