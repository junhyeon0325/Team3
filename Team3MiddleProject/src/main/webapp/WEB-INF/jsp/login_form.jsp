<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<link href="./css/login.css" rel="stylesheet">

<div id="id01" class="modal">

	<form class="modal-content animate" action="login.do" method="post">
		<div class="imgcontainer">
			<span onclick="document.getElementById('id01').style.display='none'"
					class="close" title="Close Modal">&times;</span> 
			<img src="http://www.w3schools.com/howto/img_avatar2.png" alt="Avatar" class="avatar">
		</div>

		<!-- modal content -->
		<div class="container">
			<label for="id"><b>Username</b></label> 
			<input type="text" placeholder="ID를 입력하세요" name="id" required> 
			<label for="pwd"><b>Password</b></label>
			<input type="password" placeholder="비밀번호를 입력하세요" name="pwd" required>
			<button type="submit">Login</button>
			<label> <input type="checkbox" checked="checked" name="remember"> 기억하기 </label>
		</div>

		<div class="container" style="background-color: #f1f1f1">
			<button type="button" onclick="document.getElementById('id01').style.display='none'"
					class="cancelbtn">취소</button>
			<span class="psw">비밀번호를 <a href="#">잊으셨나요?</a></span>
		</div>
	</form>
</div>

</body>
</html>