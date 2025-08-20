package com.yedam.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedam.common.Control;
import com.yedam.mapper.MemberDAO;
import com.yedam.vo.MemberVO;

public class UpdateMemberControl implements Control {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        // 폼에서 넘어온 데이터 받기
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

        MemberDAO dao = new MemberDAO();
        boolean result = dao.updateMember(vo);

        HttpSession session = req.getSession();

        if (result) {
            // 세션 정보 갱신
            session.setAttribute("loginMember", vo);
            // 수정 성공 → 마이페이지 이동
            resp.sendRedirect("mypage.do");
        } else {
            // 실패 시 다시 수정페이지
            req.setAttribute("errorMsg", "회원정보 수정 실패");
            req.getRequestDispatcher("update_signup.jsp").forward(req, resp);
        }
    }
}
