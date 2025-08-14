<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

 <div class="container-fluid page-header py-5">
    <h1 class="text-center text-white display-6">회원가입</h1>
    <ol class="breadcrumb justify-content-center mb-0">
      <li class="breadcrumb-item"><a href="#">Home</a></li>
    </ol>
 </div>
<title>회원가입</title>
<style>
.container h1 {
  text-align: center;
  margin-bottom: 10px;
}

/* 설명 문구 */
.container p {
  text-align: center;
  color: #555;
}

/* 라벨 */
label {
  display: block;
  margin-top: 10px;
  font-weight: bold;
}

/* 입력창 스타일 */
input[type=text], input[type=password] {
  width: 100%;
  padding: 10px;
  margin-top: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-sizing: border-box;
}

/* 비밀번호 확인 메시지 */
#pwdMessage {
  font-size: 14px;
  margin-top: 5px;
}

/* 버튼 스타일 */
.signupbtn, .cancelbtn {
  padding: 12px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  width: 48%;
  font-size: 16px;
}

.signupbtn {
  background-color: #4CAF50;
  color: white;
}

.signupbtn:hover {
  background-color: #45a049;
}

.cancelbtn {
  background-color: #f44336;
  color: white;
}

.cancelbtn:hover {
  background-color: #da190b;
}

/* 버튼 컨테이너 */
.clearfix {
  display: flex;
  justify-content: space-between;
  margin-top: 20px;
}
</style>
<script>
function checkPasswordMatch() {
    let pwd = document.getElementById("pwd").value;
    let pwdConfirm = document.getElementById("pwdConfirm").value;
    let message = document.getElementById("pwdMessage");

    if (pwdConfirm.length > 0) {
        if (pwd === pwdConfirm) {
            message.style.color = "green";
            message.textContent = "비밀번호가 일치합니다.";
        } else {
            message.style.color = "red";
            message.textContent = "비밀번호가 일치하지 않습니다.";
        }
    } else {
        message.textContent = "";
    }
}
</script>
</head>
<body>


<div class="container-fluid py-5">
  <div class="container py-5">
    <form action="signup.do" method="post">
      <div class="container">
        <h1>환영합니다!</h1>
        <p>회원가입을 위해 아래의 양식을 작성해주세요.</p>
        <hr>
        
        <label for="id">ID</label>
        <input type="text" placeholder="아이디를 입력하세요" name="id" required>

        <label for="pwd">Password</label>
        <input type="password" id="pwd" placeholder="비밀번호를 입력하세요" name="pwd" required>
        
        <label for="pwdConfirm">Password 확인</label>
        <input type="password" id="pwdConfirm" placeholder="비밀번호를 다시 입력하세요" name="pwdConfirm" onkeyup="checkPasswordMatch()" required>
        <div id="pwdMessage"></div>

        <label for="name">Name</label>
        <input type="text" placeholder="실명을 입력하세요" name="name" required>
        
        <label for="phone">전화번호</label>
        <input type="text" placeholder="숫자만 입력해주세요" name="phone" required>
        
        
        <label for="gender"><b>성별</b></label>
			<div>
  		<label><input type="radio" name="gender" value="남" required> 남
  		<input type="radio" name="gender" value="여"> 여</label>
			</div>
        
        <label for="email">E-mail</label>
        <input type="text" placeholder="이메일 주소를 입력하세요" name="email" required>
        
        <label for="birth">생년월일</label>
        <input type="text" placeholder="YYYYMMDD" name="birth" required>

        <label for="address">주소</label>
        <input type="text" placeholder="주소를 입력하세요" name="address" required>

        <div class="clearfix">
          <button type="button" onclick="history.back()" class="cancelbtn">취소</button>
          <button type="submit" class="signupbtn">회원가입</button>
        </div>
      </div>
    </form>
  </div>
</div>

	
</body>
</html>
