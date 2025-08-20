package com.yedam.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.yedam.common.Control;
import com.yedam.service.MemberService;
import com.yedam.service.MemberServiceImpl;
import com.yedam.vo.MemberVO;

public class LoginControl implements Control {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // JSP에서 넘어오는 파라미터명과 맞춰야 함!
        String id = req.getParameter("id");
        String pwd = req.getParameter("pwd");

        MemberService svc = new MemberServiceImpl();
        MemberVO member = svc.userCheck(id, pwd);

        if (member != null) { // ✅ 로그인 성공
            HttpSession session = req.getSession();
            session.setAttribute("logId", member.getMemberId());
            session.setAttribute("logSuccess", true);

            resp.sendRedirect("main.do"); // 메인 페이지로 이동
        } else { // ❌ 로그인 실패
            resp.setContentType("text/html; charset=UTF-8");
            resp.getWriter().println("<script>");
            resp.getWriter().println("alert('아이디 또는 비밀번호가 올바르지 않습니다.');");
            resp.getWriter().println("location.href='loginForm.do';"); 
            resp.getWriter().println("</script>");
        }
    }
}


