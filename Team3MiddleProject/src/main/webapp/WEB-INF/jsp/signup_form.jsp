<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">

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

.container {
  text-align: center;
}

/* 라벨 */
label {
  display: block;
  margin-top: 10px;
  font-weight: bold;
}

/* 입력창 스타일 */
input[type=text], input[type=password], input[type=tel] {
  text-align: center;
  width: 40%;
  padding: 10px;
  margin-top: 5px;
  border: 1px solid #ccc;
  border-radius: 5px;
  box-sizing: border-box;
}

/* 비밀번호 확인, 아이디 메시지 */
#pwdMessage, #idMessage {
  font-size: 14px;
  margin-top: 5px;
}
#idMessage {
  text-align: center;
}

/* 버튼 스타일 */
.signupbtn, .cancelbtn {
  padding: 12px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  width: 20%;
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
  justify-content: center;
  gap: 20px;
  margin-top: 20px;
}

/* 에러 메시지 */
.error-msg {
  color: red;
  font-size: 14px;
  margin-top: 3px;
}
</style>

<script>
// 🔹 아이디 중복체크
function checkIdDuplicate() {
    let userId = document.getElementById("id").value;
    let message = document.getElementById("idMessage");

    if (userId.length > 0) {
        fetch("checkId.do?id=" + userId)
            .then(response => response.json())
            .then(data => {
                if (data.isDuplicate) {
                    message.style.color = "red";
                    message.textContent = "같은 ID가 있습니다.";
                } else {
                    message.style.color = "green";
                    message.textContent = "ID 등록이 가능합니다.";
                }
            })
            .catch(error => {
                console.error('Error:', error);
                message.style.color = "red";
                message.textContent = "ID 중복 확인 중 오류가 발생했습니다.";
            });
    } else {
        message.textContent = "";
    }
}

// 🔹 유효성 검사 (실시간)
window.onload = function() {
  // 이름
  document.getElementById("name").addEventListener("input", function() {
    let val = this.value.trim();
    let msg = document.getElementById("nameError");
    if (val.length > 5) {
      msg.textContent = "이름은 5자 이내로 입력해주세요.";
    } else {
      msg.textContent = "";
    }
  });

  // 비밀번호
  document.getElementById("pwd").addEventListener("input", function() {
    let val = this.value;
    let msg = document.getElementById("pwdError");
    let regex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*]).{6,}$/;
    if (!regex.test(val)) {
      msg.textContent = "비밀번호는 영문+숫자+특수문자를 포함한 6자리 이상이어야 합니다.";
    } else {
      msg.textContent = "";
    }
  });

  // 비밀번호 확인
  document.getElementById("pwdConfirm").addEventListener("input", function() {
    let pwd = document.getElementById("pwd").value;
    let val = this.value;
    let msg = document.getElementById("pwdMessage");
    if (pwd !== val) {
      msg.textContent = "비밀번호가 일치하지 않습니다.";
    } else {
      msg.textContent = "";
    }
  });

  // 전화번호
  document.getElementById("phone").addEventListener("input", function() {
    let val = this.value;
    let msg = document.getElementById("phoneError");
    let regex = /^\d{0,11}$/;
    if (!regex.test(val)) {
      msg.textContent = "전화번호는 숫자만 입력할 수 있으며 최대 11자리입니다.";
      this.value = val.replace(/\D/g, "").substring(0, 11);
    } else if (val.length !== 11) {
      msg.textContent = "전화번호는 정확히 11자리여야 합니다.";
    } else {
      msg.textContent = "";
    }
  });

  // 생년월일
  document.getElementById("birth").addEventListener("input", function() {
    let val = this.value;
    let msg = document.getElementById("birthError");
    let regex = /^\d{6}$/;
    if (!regex.test(val)) {
      msg.textContent = "생년월일은 YYMMDD 형식(6자리 숫자)이어야 합니다.";
      this.value = val.replace(/\D/g, "").substring(0, 6);
    } else {
      msg.textContent = "";
    }
  });
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
        
        <!-- ID -->
        <label for="id">ID</label>
        <div style="display: flex; justify-content: center; align-items: center; gap: 10px;">
          <input type="text" id="id" placeholder="아이디를 입력하세요" name="id" required>
          <button type="button" onclick="checkIdDuplicate()">중복확인</button>
        </div>
        <div id="idMessage"></div>

        <!-- Password -->
        <label for="pwd">Password</label>
        <input type="password" id="pwd" placeholder="비밀번호를 입력하세요" name="pwd" required>
        <div id="pwdError" class="error-msg"></div>
        
        <label for="pwdConfirm">Password 확인</label>
        <input type="password" id="pwdConfirm" placeholder="비밀번호를 다시 입력하세요" name="pwdConfirm" required>
        <div id="pwdMessage" class="error-msg"></div>

        <!-- Name -->
        <label for="name">Name</label>
        <input type="text" id="name" placeholder="실명을 입력하세요" name="name" maxlength="5" required>
        <div id="nameError" class="error-msg"></div>

        <!-- Phone -->
        <label for="phone">전화번호</label>
        <input class="phonetest" type="tel" id="phone" placeholder="숫자만 입력해주세요" name="phone" required>
        <div id="phoneError" class="error-msg"></div>
        
        <!-- Gender -->
        <label for="gender"><b>성별</b></label>
        <div>
          <label><input type="radio" name="gender" value="남" required> 남
          <input type="radio" name="gender" value="여"> 여</label>
        </div>
        
        <!-- Email -->
        <label for="email">E-mail</label>
        <input type="text" placeholder="이메일 주소를 입력하세요" name="email" required>
        
        <!-- Birth -->
        <label for="birth">생년월일</label>
        <input type="text" id="birth" placeholder="YYMMDD" name="birth" required>
        <div id="birthError" class="error-msg"></div>

        <!-- Address -->
        <label for="address">주소</label>
        <input type="text" placeholder="주소를 입력하세요" name="address" required>

        <div class="clearfix">
          <button type="button" onclick="location.href='signup_form.jsp'" class="cancelbtn">취소</button>
          <button type="submit" class="signupbtn">회원가입</button>
        </div>
      </div>
    </form>
  </div>
</div>
</body>
</html>
