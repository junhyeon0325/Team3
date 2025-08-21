package com.yedam.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.yedam.common.Control;
import com.yedam.mapper.OrderDAO;
import com.yedam.dao.ReviewDAO;
import com.yedam.vo.OrderVO;
import com.yedam.vo.ReviewVO;

public class MyPageControl implements Control {

    @Override
    public void execute(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String memberId = (String) session.getAttribute("member_id");

        if (memberId == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        // 주문내역 조회
        OrderDAO odao = new OrderDAO();
        List<OrderVO> orderList = odao.getOrdersByMember(memberId);

        // 리뷰내역 조회
        ReviewDAO rdao = new ReviewDAO();
        List<ReviewVO> reviewList = rdao.getReviewsByMember(memberId);

        // JSP로 전달
        req.setAttribute("orderList", orderList);
        req.setAttribute("reviewList", reviewList);

        req.getRequestDispatcher("mypage.jsp").forward(req, resp);
    }
}
