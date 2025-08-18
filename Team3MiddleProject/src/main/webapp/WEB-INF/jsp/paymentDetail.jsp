<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>결제 상세 내역</title>
    <style>
        body { font-family: sans-serif; padding: 20px; }
        .container { max-width: 600px; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; }
        h1 { text-align: center; }
        .detail-item { margin-bottom: 10px; }
        .detail-item strong { display: inline-block; width: 120px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>✅ 결제가 성공적으로 완료되었습니다!</h1>
        <hr/>
        <h2>결제 상세 정보</h2>
        <div class="detail-item">
            <strong>주문번호:</strong> ${orderId}
        </div>
        <div class="detail-item">
            <strong>상품명:</strong> ${orderName}
        </div>
        <div class="detail-item">
            <strong>결제 금액:</strong> ${totalAmount}원
        </div>
        <div class="detail-item">
            <strong>결제 수단:</strong> ${method}
        </div>
        <div class="detail-item">
            <strong>결제일시:</strong> ${requestedAt}
        </div>
        <div class="detail-item">
            <strong>Payment Key:</strong> ${paymentKey}
        </div>
        <p style="text-align: center; margin-top: 20px;">
            <a href="${pageContext.request.contextPath}/main.do" style="text-decoration: none; color: #007bff;">홈으로 돌아가기</a>
        </p>
    </div>
</body>
</html>