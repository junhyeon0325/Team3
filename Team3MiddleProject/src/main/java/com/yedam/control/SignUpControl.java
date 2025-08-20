package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.MemberService;
import com.yedam.service.MemberServiceImpl;
import com.yedam.vo.MemberVO;

public class SignUpControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		resp.setContentType("text/json;charset=utf-8");

		// param : id, psw, name
		// 회원정보등록 -> 게시글목록 페이지
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pwd");
		String name = req.getParameter("name");
		String phone = req.getParameter("phone");
		String email = req.getParameter("email");
		String birth = req.getParameter("birth");
		String Address = req.getParameter("address");
		String gender = req.getParameter("gender");
		//
		MemberVO param = new MemberVO();
		param.setMemberId(id);
		param.setMemberPwd(pw);
		param.setMemberName(name);
		param.setMemberPhone(phone);
		param.setMemberEmail(email);
		param.setMemberBirth(birth);
		param.setMemberAddress(Address);
		param.setMemberGender(gender);
		
		
		MemberService svc = new MemberServiceImpl();
		if ( svc.insertMember(param)) {
			// 목록이동
			req.getRequestDispatcher("product/signup_Complete.tiles")
			.forward(req, resp);
		} else {
			System.out.println("Error발생");
			req.setAttribute("msg", "회원가입실패");
			req.getRequestDispatcher("product/signup_form.tiles")
			.forward(req, resp);
		}
	}

}
