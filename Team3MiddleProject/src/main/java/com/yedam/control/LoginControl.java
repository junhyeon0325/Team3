package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedam.common.Control;
import com.yedam.service.MemberService;
import com.yedam.service.MemberServiceImpl;
import com.yedam.vo.MemberVO;

public class LoginControl implements Control {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// param : uname, psw
		String id = req.getParameter("uname");
		String pw = req.getParameter("psw");
		
		// DB 처리
		MemberService svc = new MemberServiceImpl();
		MemberVO member = svc.userCheck(id, pw);

		//세션정보활용
		if (member == null) {
			
		} else {
			// 세션을 활용하여 정보저장
			// 정상적으로 id, pw를 입력했다는 의미
			HttpSession session = req.getSession();	//쿠키정보를 확인해서 session객체를 만들어줌
			session.setAttribute("logId", id);	// logid라는 속성 = 로그인아이디
			session.setAttribute("auth", member.getGetResponsibility());  // user / 관리자
			resp.sendRedirect("login.do");
		}
	}

}
