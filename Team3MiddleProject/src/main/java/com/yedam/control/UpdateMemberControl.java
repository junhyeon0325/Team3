package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedam.common.Control;
import com.yedam.service.MemberService;
import com.yedam.service.MemberServiceImpl;
import com.yedam.vo.MemberVO;

// Control 인터페이스를 구현하는 UpdateMemberControl 클래스 정의
public class UpdateMemberControl implements Control {

    @Override // execute 메서드 위에 @Override 어노테이션을 붙입니다.
    public void execute(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            req.setCharacterEncoding("utf-8");

            String id = req.getParameter("id");
            String pwd = req.getParameter("pwd");
            String name = req.getParameter("name");
            String phone = req.getParameter("phone");
            String gender = req.getParameter("gender");
            String email = req.getParameter("email");
            String birth = req.getParameter("birth");
            String address = req.getParameter("address");

            MemberVO vo = new MemberVO();
            vo.setMemberId(id);
            vo.setMemberPwd(pwd);
            vo.setMemberName(name);
            vo.setMemberPhone(phone);
            vo.setMemberGender(gender);
            vo.setMemberEmail(email);
            vo.setMemberBirth(birth);
            vo.setMemberAddress(address);

            MemberService service = new MemberServiceImpl();
            if(service.updateMember(vo)) {
                req.getSession().setAttribute("loginMember", vo);
                resp.sendRedirect("mypage.jsp");
            } else {
                resp.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp");
        }
    }
}