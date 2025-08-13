<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
body {font-family: Arial, Helvetica, sans-serif;}
* {box-sizing: border-box;}

/* Full-width input fields */
input[type=text], input[type=password] {
  width: 100%;
  padding: 15px;
  margin: 5px 0 22px 0;
  display: inline-block;
  border: none;
  background: #f1f1f1;
}

/* Add a background color when the inputs get focus */
input[type=text]:focus, input[type=password]:focus {
  background-color: #ddd;
  outline: none;
}

/* Set a style for all buttons */
button {
  background-color: #04AA6D;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  cursor: pointer;
  width: 100%;
  opacity: 0.9;
}

button:hover {
  opacity:1;
}

/* Extra styles for the cancel button */
.cancelbtn {
  padding: 14px 20px;
  background-color: #f44336;
}

/* Float cancel and signup buttons and add an equal width */
.cancelbtn, .signupbtn {
  float: left;
  width: 50%;
}

/* Add padding to container elements */
.container {
  padding: 16px;
}

/* The Modal (background) */
.modal {
  display: block; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: #474e5d;
  padding-top: 50px;
}

/* Modal Content/Box */
.modal-content {
  background-color: #fefefe;
  margin: 5% auto 15% auto; /* 5% from the top, 15% from the bottom and centered */
  border: 1px solid #888;
  width: 80%; /* Could be more or less, depending on screen size */
}

/* Style the horizontal ruler */
hr {
  border: 1px solid #f1f1f1;
  margin-bottom: 25px;
}
 
/* The Close Button (x) */
.close {
  position: absolute;
  right: 35px;
  top: 15px;
  font-size: 40px;
  font-weight: bold;
  color: #f1f1f1;
}

.close:hover,
.close:focus {
  color: #f44336;
  cursor: pointer;
}

/* Clear floats */
.clearfix::after {
  content: "";
  clear: both;
  display: table;
}

/* Change styles for cancel button and signup button on extra small screens */
@media screen and (max-width: 300px) {
  .cancelbtn, .signupbtn {
     width: 100%;
  }
}
</style>
</head>


 <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">회원가입</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
            </ol>
        </div>
        <!-- Single Page Header End -->

<!-- Cart Page Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
  <form class="modal-content" action="signup.do">
    <div class="container">
      <h1>회원가입</h1>
      <p>회원가입을 위해 아래 양식을 작성해주세요.</p>
      <hr>
      <label for="id"><b>ID</b></label>
      <input type="text" placeholder="아이디를 입력하세요" name="id" required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="비밀번호를 입력하세요" name="psw" required>
      
       <label for="pswh"><b>Password확인</b></label>
      <input type="password" placeholder="비밀번호를 입력하여 확인하세요" name="pswh" required>

      <label for="name"><b>Name</b></label>
      <input type="text" placeholder="실명을 입력하세요" name="name" required>
      
      <label for="phone"><b>전화번호</b></label>
      <input type="text" placeholder="숫자만입력해주세요" name="phone" required>
      
      <label for="gender"><b>성별</b></label>
      <input type="text" placeholder="-" name="gender" required>
      
      <label for="email"><b>E-mail</b></label>
      <input type="text"  name="email" required>
      
      <label for="phone"><b>생년월일</b></label>
      <input type="text" placeholder="숫자만입력해주세요" name="birth" required>

      <label for="address"><b>주소</b></label>
      <input type="text"  name="address" required>
      
      


      <div class="clearfix">
        <button type="button" onclick="document.getElementById('id01').style.display='none'" class="cancelbtn">취소</button>
        <button type="submit" class="signupbtn">회원가입</button>
      </div>
    </div>
  </form>
</div>
        </div>
        <!-- Cart Page End -->
</html>