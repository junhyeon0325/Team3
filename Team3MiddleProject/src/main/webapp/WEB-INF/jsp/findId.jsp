<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<body>
    <h2>아이디 찾기</h2>
    <form action="findId.do" method="post">
        이름: <input type="text" name="userName" required><br>
        이메일: <input type="email" name="userEmail" required><br>
        <button type="submit">아이디 찾기</button>
    </form>
    <a href="login_form.jsp">로그인 페이지로 돌아가기</a>
</body>
</html>