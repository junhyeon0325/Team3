<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 실패</title>
</head>
<body>
    <h1>결제 실패</h1>
    <p>결제에 실패했습니다. 다시 시도해 주세요.</p>
    <p>오류 코드: ${param.code}</p>
    <p>오류 메시지: ${param.message}</p>
    <a href="/">홈으로 돌아가기</a>
</body>
</html>