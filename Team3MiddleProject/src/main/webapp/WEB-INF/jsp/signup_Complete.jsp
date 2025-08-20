<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>회원가입 완료</title>
<style>
  body {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    font-family: Arial, sans-serif;
    background-color: #f0f2f5;
  }
  .complete-box {
    text-align: center;
    background: white;
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  }
  .complete-box h1 {
    color: #4CAF50;
    font-size: 2.5em;
    margin-bottom: 10px;
  }
  .complete-box p {
    color: #555;
    font-size: 1.2em;
    margin-bottom: 20px;
  }
  .home-btn {
    background-color: #007bff;
    color: white;
    padding: 12px 24px;
    border: none;
    border-radius: 5px;
    text-decoration: none;
    font-size: 1em;
    transition: background-color 0.3s ease;
  }
  .home-btn:hover {
    background-color: #0056b3;
  }
</style>
</head>
<body>
  <div class="complete-box">
    <h1>🎉 회원가입이 완료되었습니다!</h1>
    <p>저희Fruitable에 오신 것을 환영합니다.<br>즐거운 시간 보내세요!</p>
    <a href="main.do" class="home-btn">메인 화면으로 이동</a>
  </div>
</body>
</html>
