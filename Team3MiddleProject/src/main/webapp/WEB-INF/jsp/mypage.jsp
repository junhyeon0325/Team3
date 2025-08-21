<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.yedam.vo.MemberVO" %>

<%
    MemberVO member = (MemberVO) session.getAttribute("loginMember");
    if (member == null) {
        response.sendRedirect("login_form.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h2 { color: #005BAC; }
        table { border-collapse: collapse; width: 80%; margin-bottom: 30px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: center; }
        th { background-color: #f2f2f2; }
        .menu { margin-bottom: 20px; }
        .menu a { margin-right: 15px; text-decoration: none; color: blue; }
    </style>
</head>
<body>

    <!-- 로그인한 ID 표시 -->
    <h2>마이페이지</h2>
    <p><b><%= member.getMemberId() %></b> 님, 환영합니다!</p>

    <!-- 상단 메뉴 -->
    <div class="menu">
        <a href="update_signup.jsp">회원정보수정</a>
        <a href="orderList.do">주문내역조회</a>
        <a href="reviewList.do">내가 작성한 리뷰</a>
    </div>

    <!-- 주문내역 테이블 -->
    <h3>주문내역</h3>
    <table>
        <tr>
            <th>구매일시</th>
            <th>상품번호</th>
            <th>상품내용</th>
        </tr>
        <c:forEach var="order" items="${orderList}">
            <tr>
                <td>${order.orderDate}</td>
                <td>${order.productNo}</td>
                <td>${order.productName}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty orderList}">
            <tr>
                <td colspan="3">주문 내역이 없습니다.</td>
            </tr>
        </c:if>
    </table>

    <!-- 리뷰내역 테이블 -->
    <h3>내가 작성한 리뷰</h3>
    <table>
        <tr>
            <th>작성일</th>
            <th>상품번호</th>
            <th>리뷰내용</th>
        </tr>
        <c:forEach var="review" items="${reviewList}">
            <tr>
                <td>${review.reviewDate}</td>
                <td>${review.productNo}</td>
                <td>${review.content}</td>
            </tr>
        </c:forEach>
        <c:if test="${empty reviewList}">
            <tr>
                <td colspan="3">작성한 리뷰가 없습니다.</td>
            </tr>
        </c:if>
    </table>

</body>
</html>
