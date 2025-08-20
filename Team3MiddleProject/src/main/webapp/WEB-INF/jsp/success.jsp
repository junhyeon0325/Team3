<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 성공</title>
</head>
<body>
    <script>
        const urlParams = new URLSearchParams(window.location.search);
        const paymentKey = urlParams.get("paymentKey");
        const orderId = urlParams.get("orderId");
        const amount = urlParams.get("amount");

        fetch(window.location.origin + "/Team3MiddleProject/paymentConfirm.do", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                paymentKey: paymentKey,
                orderId: orderId,
                amount: amount,
            }),
        })
        .then(function(response) {
            return response.json();
        })
        .then(function(data) {
            if (data.code && data.message) {
                alert("결제 실패: " + data.message);
                window.location.href = window.location.origin + "/Team3MiddleProject/paymentFail.do?code=" + data.code + "&message=" + data.message;
            } else {
                alert("결제 성공!");
                window.location.href = window.location.origin + "/Team3MiddleProject/paymentDetail.do?orderId=" + data.orderId;
            }
        })
        .catch(function(error) {
            console.error("Error:", error);
            alert("결제 실패: 서버 오류 발생");
            window.location.href = window.location.origin + "/Team3MiddleProject/paymentFail.do";
        });
    </script>
    <h1>결제 처리 중...</h1>
    <p>잠시만 기다려 주세요.</p>
</body>
</html>