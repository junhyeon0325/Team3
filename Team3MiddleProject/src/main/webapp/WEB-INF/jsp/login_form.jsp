<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<link href="./css/login.css" rel="stylesheet">

<div id="id01" class="modal">
	<form class="modal-style" action="login.do" method="post">
		<div class="imgcontainer">
			<span onclick="document.getElementById('id01').style.display='none'"
				class="out" title="Out Modal">&times;</span>
			<img src="http://www.w3schools.com/howto/img_avatar2.png"
				alt="Avatar" class="avatar">
		</div>
		<div class="jstyle">
			<label for="uname"><b>Username</b></label> 
			<input type="text" placeholder="ID를 입력하세요" name="id" required> 

			<label for="pwd"><b>Password</b></label> 
			<input type="password" placeholder="비밀번호를 입력하세요" name="pwd" required>

			<button type="submit">Login</button>
			<label> 
				<input type="checkbox" checked="checked" name="remember"> 저장할끼가
			</label>
		</div>
		<div class="jstyle" style="background-color: #f1f1f1">
			<button type="button"
				onclick="document.getElementById('id01').style.display='none'"
				class="outbtn">Cancel</button>
			<span class="psw">Forgot <a href="#">password?</a></span>
		</div>
	</form>
</div>

<script>
// 모달 바깥 클릭 시 닫기 기능
window.onclick = function(event) {
  let modal = document.getElementById('id01');
  if (event.target == modal) {
    modal.style.display = "none";
  }
}
</script>