<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> <%-- 이 줄을 추가합니다. --%>

<style>
.divone {
	background-color: #F3F5F7;
	padding: 10px;
	border-radius: 10px;
}

.divonebtn {
	background-color: white;
}

.point-box {
	display: flex;
	justify-content: space-between;
}

.orderProductPcs {
	width: 60px;
}

.orderProductPrice {
	margin: 0px;
}

.orderleft {
	width: 40%;
}

.orderright {
	width: 60%
}

.orderlabel {
	margin-top: 15px;
	margin-bottom: 0px;
}
</style>
<!-- req.setAttribute("cp_list", list);	// CartProduct약자 cp
	 req.setAttribute("om", vo);	// OrderMember약자 om -->
<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">주문/결제</h1>
</div>
<!-- Single Page Header End -->


<!-- Checkout Page Start -->
<div class="container-fluid py-5">
	<div class="container py-5">
		<h1 class="mb-4">상세정보</h1>
		<form action="#">
			<div class="row g-5">
				<!--  -->
				<div class="col-md-12 col-lg-6 col-xl-7 orderleft">
					<h4>배송지</h4>
					<div class="divone">
						<div class="form-item">
							<label class="form-label orderlabel">받는이*</label> <input
								class="form-control" type="text" name="name"
								value="${om.memberName }">
						</div>
						<div class="form-item">
							<label class="form-label orderlabel">전화번호*</label> <input
								class="form-control" type="tel" name="tel"
								value="${om.memberPhone }">
						</div>
						<div class="form-item">
							<br>주소*<input type="text" id="sample5_address" placeholder="주소" value="${om.memberAddress}" class="form-control"><br>
							<input class="form-control" type="button" onclick="sample5_execDaumPostcode()" value="주소입력" ><br>
							<div class="form-control" id="map" style="width:300px;height:300px;margin-top:10px;display:none"></div>
						</div>
						<div class="form-item">
							<label class="form-label orderlabel">주문요청사항</label>
							<textarea name="text" class="form-control" spellcheck="false"
								cols="30" rows="11" placeholder="주문요청사항을 입력해주세요(비워도됩니다.)"></textarea>
						</div>
					</div>
					<hr>
					<div class="form-item">
						<h4>적립금</h4>
						<div class="divone">
							<div class="point-box">
								<span>사용가능금액</span><span class="orderpoint">${cp_list[0].point}원</span>
							</div>
							<br>
							<div> <%--form 태그를 div로 변경 --%>
								<input type="checkbox" id="usePointCheckbox"></input> 적립금을 사용하시려면 체크박스를 눌러 활성화해주세요. <span id="currentUsedPoint" style="font-weight: bold; color: green;">0원</span> <%-- 🌟 수정: id 추가, 사용금액 표시 span 추가 --%>
							</div>
							<div>
								<input class="form-control" id="pointInput" <%-- id 추가 --%>
									placeholder="사용할 금액을 입력해주세요" value="0" disabled></input> <%--value="0", disabled 추가 --%>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12 col-lg-6 col-xl-5 orderright">
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">이미지</th>
									<th scope="col">이름</th>
									<th scope="col">가격</th>
									<th scope="col">수량</th>
									<th scope="col">총 가격</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="cp" items="${cp_list}">
									<!-- 주문상품 출력 반복문 -->
									<tr class="cart">
										<th scope="row">
											<div class="d-flex align-items-center mt-2">
												<img src="${cp.productImage }"
													class="img-fluid rounded-circle"
													style="width: 90px; height: 90px;" alt="">
											</div>
										</th>
										<td class="py-5">${cp.productName }</td>
										<td class="py-5 ordertd">
											<p class="orderProductPrice"><fmt:formatNumber value="${cp.productPrice }" type="number" />원</p>
											<p class="mb-0 productSalePercent"
												style="color: red; font-size: 20px; font-weight: bold">${cp.discountRate}%</p>
											<!-- 할인율 -->
											<p class="mb-0 productSale"
												style="color: red; font-size: 20px; font-weight: bold">${cp.discountPrice}원</p>
										</td>
										<td class="py-5 orderProductPcs">${cp.productPcs }</td>
										<td class="py-5 ordertotalPrice">총 가격</td>
									</tr>
								</c:forEach>
								<tr>

									<td colspan='2' class="py-5">
										<p
											style="text-align: center; font-size: 20px; font-weight: bold;"
											class="mb-0 text-dark py-3">총 주문금액</p>
									</td>
									<td colspan='3' class="py-5">
										<div class="py-3 border-bottom border-top">
											<p
												style="text-align: center; font-size: 20px; font-weight: bold;"
												class="mb-0 text-dark totalCartPrice">총 주문금액</p>
										</div>
									</td>
								</tr>
								<tr>
									<td colspan='2' class="py-5">
										<p
											style="text-align: center; font-size: 30px; font-weight: bold;"
											class="mb-0 text-dark text-uppercase py-3">결제금액</p>
									</td>
									<td colspan='3' class="py-5">
										<div class="py-3 border-bottom border-top">
											<p
												style="text-align: center; font-size: 30px; font-weight: bold;"
												class="mb-0 text-dark totalOrderPrice">결제금액</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div id="payment-method"></div> <!-- 결제위젯 영역 렌더링 -->
					<div id="agreement"></div> <!-- 약관 영역 렌더링 -->
					<div class="row g-4 text-center align-items-center justify-content-center pt-4">
						<button type="button" class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary"
							id="payment-button">결제하기
						</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- Checkout Page End -->
<script src="js/order.js"></script> <%-- order.js는 총 상품 금액(할인 적용 후, 적립금 사용 전)을 계산합니다. --%>

<script src="https://js.tosspayments.com/v1/payment-widget"></script>
<script>
    // 결제 금액 관련 DOM 요소
    const totalOrderPriceElement = document.querySelector('.totalOrderPrice');
    
    // 적립금 관련 DOM 요소 (HTML 변경에 맞춰 ID 수정)
    const usePointCheckbox = document.getElementById('usePointCheckbox'); 
    const pointInput = document.getElementById('pointInput');             
    const currentUsedPointSpan = document.getElementById('currentUsedPoint'); 
    const availablePoint = Number("${om.point}"); 

    // 최종 결제 금액을 업데이트하고 결제 위젯에 반영하는 함수
    function updateFinalPaymentAmount() {
        // order.js의 updateTotal() 함수가 먼저 실행된 후, totalCartPrice가 업데이트된 상태에서 시작합니다.
        const currentCalculatedTotalPrice = Number(document.querySelector('.totalCartPrice').innerText.replace(/[^0-9]/g, ''));
        const originalTotalOrderPrice = currentCalculatedTotalPrice; // 적립금 사용 전 순수 총 결제 금액을 여기서 가져옵니다.

        let usedPoint = 0;
        // 🌟 디버깅 로그 추가: 함수 시작 시 주요 값들 확인
        console.log("--- updateFinalPaymentAmount() 호출 시작 ---");
        console.log("  - 현재 계산된 총 상품 금액 (currentCalculatedTotalPrice):", originalTotalOrderPrice.toLocaleString() + "원");
        console.log("  - 사용가능 적립금 (availablePoint):", availablePoint.toLocaleString() + "원");
        console.log("  - 적립금 사용 체크박스 상태 (usePointCheckbox.checked):", usePointCheckbox.checked);
        console.log("  - 적립금 입력 필드 값 (pointInput.value - 원본):", pointInput.value);

        if (usePointCheckbox.checked) {
            let inputPoint = Number(pointInput.value.replace(/[^0-9]/g, '')); 
            // 🌟 디버깅 로그 추가: 입력된 적립금 값 파싱 후 확인
            console.log("  - 적립금 입력 필드 값 (inputPoint - 파싱 후):", inputPoint.toLocaleString() + "원");

            // 1. 입력된 적립금이 사용 가능 금액을 초과하는지 체크
            if (inputPoint > availablePoint) {
                inputPoint = availablePoint; 
                pointInput.value = inputPoint; 
                alert("사용 가능한 적립금을 초과했습니다. 최대 " + availablePoint.toLocaleString() + "원까지 사용할 수 있습니다.");
                console.log("  - 🚨 적립금 초과! inputPoint 조정됨:", inputPoint.toLocaleString() + "원");
            }

            // 2. 최종 결제 금액이 0원 미만이 되는 것을 방지 (결제 금액보다 적립금이 많은 경우)
            if (originalTotalOrderPrice - inputPoint < 0) {
                inputPoint = originalTotalOrderPrice; // 결제 금액만큼만 사용
                pointInput.value = inputPoint;
                if (originalTotalOrderPrice > 0) { 
                    alert("결제 금액보다 많은 적립금을 사용할 수 없습니다. 최대 " + originalTotalOrderPrice.toLocaleString() + "원까지 사용할 수 있습니다.");
                }
                console.log("  - 🚨 결제 금액 초과! inputPoint 조정됨:", inputPoint.toLocaleString() + "원");
            }
            usedPoint = inputPoint;

        } else { // 체크박스가 해제된 경우
            usedPoint = 0;
            pointInput.value = "0"; // 🌟 다시 추가: 체크박스 해제 시 입력 필드 0으로 초기화
            console.log("  - ✅ 체크박스 해제됨: usedPoint = 0");
        }

        const finalAmount = originalTotalOrderPrice - usedPoint;
        currentUsedPointSpan.innerText = usedPoint.toLocaleString() + '원'; // 사용 금액 화면 업데이트
        
        // 화면에 표시되는 '결제금액' (totalOrderPrice) 업데이트
        totalOrderPriceElement.innerText = finalAmount.toLocaleString() + '원';
        
        // 🌟 디버깅 로그 추가: 최종 계산 결과 확인
        console.log("  - 최종 사용 적립금 (usedPoint):", usedPoint.toLocaleString() + "원");
        console.log("  - 최종 결제 금액 (finalAmount):", finalAmount.toLocaleString() + "원");
        console.log("--- updateFinalPaymentAmount() 호출 종료 ---");

        // paymentWidget이 정의되었고 updatePaymentMethods 함수가 존재하는지 확인 후 호출
        if (typeof paymentWidget !== 'undefined' && typeof paymentWidget.updatePaymentMethods === 'function') {
            paymentWidget.updatePaymentMethods({ value: finalAmount });
            console.log("  - 결제 위젯 금액 업데이트 요청됨:", finalAmount.toLocaleString() + "원");
        } else {
            console.warn("결제 위젯이 아직 초기화되지 않았거나 'updatePaymentMethods' 함수를 찾을 수 없습니다.");
        }
    }
    
    // 1. 토스페이먼츠 클라이언트 키를 입력하세요.
    const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm"; 

    // 2. 결제 위젯을 초기화합니다.
    const paymentWidget = PaymentWidget(clientKey, PaymentWidget.ANONYMOUS);
    
    // 3. 페이지 로드 시 초기 설정
    document.addEventListener('DOMContentLoaded', function() {
        console.log("--- DOMContentLoaded 이벤트 발생 ---");
        // order.js의 updateTotal() 함수가 정의되었는지 확인하고 호출 (총 주문금액 계산)
        if (typeof updateTotal === 'function') { 
            updateTotal(); 
            console.log("  - order.js의 updateTotal() 호출 완료.");
        } else {
            console.warn("order.js의 updateTotal() 함수가 정의되지 않았습니다. 총 금액 계산 로직을 확인하세요.");
        }
        
        // 초기 결제 위젯 렌더링 (totalCartPrice를 기반으로 초기 금액 설정)
        const initialAmount = Number(document.querySelector('.totalCartPrice').innerText.replace(/[^0-9]/g, ''));
        paymentWidget.renderPaymentMethods('#payment-method', { value: initialAmount }, { variantKey: "DEFAULT" });
        paymentWidget.renderAgreement('#agreement', { variantKey: "DEFAULT" });
        console.log("  - 결제 위젯 초기 렌더링 완료.");
        
        // paymentWidget 렌더링 완료 후 적립금 로직 초기 상태 설정 및 최종 금액 업데이트 호출을 지연
        setTimeout(() => {
            console.log("  - setTimeout 콜백 함수 실행 시작.");
            pointInput.value = "0"; // 🌟 추가: 초기화 시 input 값 "0"으로 강제 설정
            pointInput.disabled = !usePointCheckbox.checked; // 체크박스 상태에 따라 활성화/비활성화
            console.log("  - pointInput 초기값 및 disabled 상태 설정 완료.");
            updateFinalPaymentAmount(); // 적립금 초기 상태 반영 (0원 사용)
            console.log("  - updateFinalPaymentAmount() (초기값) 호출 완료.");
        }, 500); 
    });

    // 4. 적립금 체크박스 및 입력 필드 이벤트 리스너
    usePointCheckbox.addEventListener('change', function() {
        console.log("--- 적립금 체크박스 변경 이벤트 발생 ---");
        pointInput.disabled = !this.checked; // 체크박스 상태에 따라 활성화/비활성화
        // 🌟 수정: 체크박스 해제 시 input 값도 "0"으로 초기화
        if (!this.checked) {
            pointInput.value = "0"; 
            console.log("  - 체크박스 해제됨: pointInput.value를 0으로 초기화.");
        }
        updateFinalPaymentAmount(); // 체크박스 변경 시 최종 금액 업데이트
    });

    pointInput.addEventListener('input', function() {
        console.log("--- 적립금 입력 필드 변경 이벤트 발생 ---");
        this.value = this.value.replace(/[^0-9]/g, ''); // 숫자만 입력되도록 강제
        updateFinalPaymentAmount(); // 입력 필드 값 변경 시 최종 금액 업데이트
    });

    // 5. 결제 버튼 클릭 시 결제 요청
    document.getElementById("payment-button").addEventListener("click", function() {
        console.log("--- 결제하기 버튼 클릭 이벤트 발생 ---");
        const orderAddress = document.getElementById("sample5_address").value; 
        const orderRequest = document.querySelector('textarea[name="text"]').value;
        
        let usedPoint = 0;
        if (usePointCheckbox.checked) { 
            usedPoint = Number(pointInput.value);
        }
        
        const temporaryOrderData = {
            orderAddress: orderAddress, 
            orderRequest: orderRequest,
            usedPoint: usedPoint 
        };
        
        console.log("  - 서버로 보낼 임시 주문 데이터:", temporaryOrderData);

        fetch(window.location.origin + "/Team3MiddleProject/saveTemporaryOrderData.do", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify(temporaryOrderData),
        })
        .then(response => {
            if (!response.ok) { 
                throw new Error('Network response was not ok: ' + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            if (data.status === "success") {
                console.log("  - 임시 주문 정보 서버 저장 성공:", data.message);
                
                // 🌟 중요: '결제금액' (totalOrderPriceElement)에서 최종 금액을 가져와 Toss에 전달합니다.
                const finalAmountForToss = Number(totalOrderPriceElement.innerText.replace(/[^0-9]/g, ''));
                
                // 🌟�🌟 추가: Toss API 요청 직전, 최종 금액과 그 타입을 한번 더 로그로 확인
                console.log("  - Toss API로 전송할 최종 결제 금액 (finalAmountForToss):", finalAmountForToss);
                console.log("  - Toss API로 전송할 최종 결제 금액의 타입:", typeof finalAmountForToss);


                paymentWidget.requestPayment({
                    orderId: new Date().getTime().toString(), 
                    orderName: "상품명 외 1건", 
                    customerName: "${om.memberName}",
                    amount: finalAmountForToss, // 🌟 최종 결제 금액을 전달
                    successUrl: window.location.origin + "/Team3MiddleProject/paymentSuccess.do",
                    failUrl: window.location.origin + "/Team3MiddleProject/paymentFail.do",
                });
            } else {
                alert("주문 정보를 저장하는 데 실패했습니다: " + data.message);
                console.error("  - 임시 주문 정보 저장 실패:", data.message);
            }
        })
        .catch(error => {
            console.error("  - Error saving temporary order data:", error);
            alert("주문 처리 중 오류가 발생했습니다.");
        });
    });
</script>


<!-- Kakao Map API 스크립트 (유지) -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5c1ef6149adfa2169a2a57b60f170c60&libraries=services"></script>
<script>
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });

// 🌟 오류 수정: daum.Postcode가 로드될 때까지 기다리는 로직 강화
// setTimeout 지연 시간을 200ms에서 500ms로 늘려봅니다.
function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) {
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {

                        var result = results[0]; //첫번째 결과의 값을 활용

                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        // 마커를 결과값으로 받은 위치로 옮긴다.
                        marker.setPosition(coords)
                    }
                });
            }
        }).open();
    }
</script>


