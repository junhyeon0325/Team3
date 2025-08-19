<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.yedam.vo.MemberVO" %>

<%
    MemberVO member = (MemberVO) session.getAttribute("loginMember");
    if (member == null) {
        // 로그인 안한 사용자가 들어오면 로그인 페이지로 강제 이동
        response.sendRedirect("login_form.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link href="./css/signup.css" rel="stylesheet"> <!-- 회원가입 CSS 재사용 -->
</head>
<body>

<div class="container-fluid py-5">
  <div class="container py-5">
    <form action="updateMember.do" method="post">
      <div class="container">

        <h1>내 정보 수정</h1>
        <p>변경할 내용을 입력 후 저장하세요.</p>
        <hr>

        <label for="id">ID</label>
        <input type="text" name="id" value="<%= member.getMemberId() %>" readonly>

        <label for="pwd">Password</label>
        <input type="password" name="pwd" value="<%= member.getMemberPwd() %>" required>

        <label for="name">Name</label>
        <input type="text" name="name" value="<%= member.getMemberName() %>" required>

        <label for="phone">전화번호</label>
        <input type="tel" name="phone" value="<%= member.getMemberPhone() %>" required>

        <label for="gender">성별</label>
        <div>
          <label>
            <input type="radio" name="gender" value="남"
                <%= "남".equals(member.getMemberGender()) ? "checked" : "" %> > 남
            <input type="radio" name="gender" value="여"
                <%= "여".equals(member.getMemberGender()) ? "checked" : "" %> > 여
          </label>
        </div>

        <label for="email">E-mail</label>
        <input type="text" name="email" value="<%= member.getMemberEmail() %>" required>

        <label for="birth">생년월일</label>
        <input type="text" name="birth" value="<%= member.getMemberBirth() %>" required>

        <label for="address">주소</label>
        <input type="text" name="address" value="<%= member.getMemberAddress() %>" required>

        <div class="clearfix">
          <button type="button" onclick="location.href='mypage.jsp'" class="cancelbtn">취소</button>
          <button type="submit" class="signupbtn">저장</button>
        </div>

      </div>
    </form>
  </div>
</div>

</body>
</html>
