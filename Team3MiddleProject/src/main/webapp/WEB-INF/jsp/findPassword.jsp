<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
    <h2>비밀번호 찾기</h2>
    <form action="findPassword.do" method="post">
        아이디: <input type="text" name="userId" required><br>
        이메일: <input type="email" name="userEmail" required><br>
        <button type="submit">비밀번호 찾기</button>
    </form>
    <a href="login_form.jsp">로그인 페이지로 돌아가기</a>
</body>
</html>