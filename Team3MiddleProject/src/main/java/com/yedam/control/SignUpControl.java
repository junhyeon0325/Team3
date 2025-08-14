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

		// param : id, psw, name
		// 회원정보등록 -> 게시글목록 페이지
		
		String id = req.getParameter("id");
		String pw = req.getParameter("pwd");
		String name = req.getParameter("name");
		
		//
		MemberVO param = new MemberVO();
		param.setMemberId(id);
		param.setMemberPwd(pw);
		param.setMemberName(name);
		
		MemberService svc = new MemberServiceImpl();
		if ( svc.insertMember(param)) {
			// 목록이동
			resp.sendRedirect("main.do");
		} else {
			System.out.println("Error발생");
		}
	}

}
