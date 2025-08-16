<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
</style>

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">주문/결제</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="#">Home</a></li>
		<li class="breadcrumb-item"><a href="#">Pages</a></li>
		<li class="breadcrumb-item active text-white">Checkout</li>
	</ol>
</div>
<!-- Single Page Header End -->


<!-- Checkout Page Start -->
<div class="container-fluid py-5">
	<div class="container py-5">
		<h1 class="mb-4">상세정보</h1>
		<form action="#">
			<div class="row g-5">
				<div class="col-md-12 col-lg-6 col-xl-7">
					<h4>배송지</h4>
					<div class="divone">
						<div class="form-item">
							<label class="form-label my-3">받는이</label> <input
								class="form-control" type="text" name="name" value="장준현">
						</div>
						<div class="form-item">
							<label class="form-label my-3">전화번호</label> <input
								class="form-control" type="tel" name="tel" value="01026104902">
						</div>
						<div class="form-item">
							<br> <input
								class="divonebtn btn border-secondary py-3 px-4 text-uppercase w-100 text-primary"
								type="button" onclick="sample3_execDaumPostcode()"
								value="우편번호 찾기"><br> <br>우편번호<br> <input
								class="form-control" type="text" id="sample3_postcode"
								placeholder="우편번호"><br>주소<br> <input
								class="form-control" type="text" id="sample3_address"
								placeholder="주소"><br>상세주소 <input
								class="form-control" type="text" id="sample3_detailAddress"
								placeholder="상세주소"><br>참고항목 <input
								class="form-control" type="text" id="sample3_extraAddress"
								placeholder="참고항목"><br>
							<div id="wrap"
								style="display: none; border: 1px solid; width: 500px; height: 300px; margin: 5px 0; position: relative">
								<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
									id="btnFoldWrap"
									style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1"
									onclick="foldDaumPostcode()" alt="접기 버튼">
							</div>
						</div>
						<div class="form-item">
							<label class="form-label my-3">주문요청사항</label>
							<textarea name="text" class="form-control" spellcheck="false"
								cols="30" rows="11" placeholder="주문요청사항을 입력해주세요(비워도됩니다.)"></textarea>
						</div>
					</div>
					<hr>
					<div class="form-item">
						<h4>적립금</h4>
						<div class="divone">
							<div class="point-box">
								<span>사용가능금액</span><span>100원</span>
							</div>
							<br>
							<div>
								<input class="form-control" placeholder="사용할금액을 입력해주세요"></input>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-item">
						<h4>결제수단</h4>
						<div class="divone">
							<label class="form-label my-3">결제수단</label> <input type="text"
								class="form-control">
						</div>
					</div>
				</div>
				<div class="col-md-12 col-lg-6 col-xl-5">
					<div class="table-responsive">
						<table class="table">
							<thead>
								<tr>
									<th scope="col">Products</th>
									<th scope="col">Name</th>
									<th scope="col">Price</th>
									<th scope="col">Quantity</th>
									<th scope="col">Total</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<th scope="row">
										<div class="d-flex align-items-center mt-2">
											<img src="img/vegetable-item-2.jpg"
												class="img-fluid rounded-circle"
												style="width: 90px; height: 90px;" alt="">
										</div>
									</th>
									<td class="py-5">Awesome Brocoli</td>
									<td class="py-5">$69.00</td>
									<td class="py-5">2</td>
									<td class="py-5">$138.00</td>
								</tr>
								<tr>
									<th scope="row">
										<div class="d-flex align-items-center mt-2">
											<img src="img/vegetable-item-5.jpg"
												class="img-fluid rounded-circle"
												style="width: 90px; height: 90px;" alt="">
										</div>
									</th>
									<td class="py-5">Potatoes</td>
									<td class="py-5">$69.00</td>
									<td class="py-5">2</td>
									<td class="py-5">$138.00</td>
								</tr>
								<tr>
									<th scope="row">
										<div class="d-flex align-items-center mt-2">
											<img src="img/vegetable-item-3.png"
												class="img-fluid rounded-circle"
												style="width: 90px; height: 90px;" alt="">
										</div>
									</th>
									<td class="py-5">Big Banana</td>
									<td class="py-5">$69.00</td>
									<td class="py-5">2</td>
									<td class="py-5">$138.00</td>
								</tr>
								<tr>
									<th scope="row"></th>
									<td class="py-5"></td>
									<td class="py-5"></td>
									<td class="py-5">
										<p class="mb-0 text-dark py-3">총 주문금액</p>
									</td>
									<td class="py-5">
										<div class="py-3 border-bottom border-top">
											<p class="mb-0 text-dark">$414.00</p>
										</div>
									</td>
								</tr>
								<tr>
									<th scope="row"></th>
									<td class="py-5">
										<p class="mb-0 text-dark text-uppercase py-3">결제금액</p>
									</td>
									<td class="py-5"></td>
									<td class="py-5"></td>
									<td class="py-5">
										<div class="py-3 border-bottom border-top">
											<p class="mb-0 text-dark">$135.00</p>
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div
						class="row g-4 text-center align-items-center justify-content-center pt-4">
						<button type="button"
							class="btn border-secondary py-3 px-4 text-uppercase w-100 text-primary">결제하기</button>
					</div>
				</div>
			</div>
		</form>
	</div>
</div>
<!-- Checkout Page End -->


<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	// 우편번호 찾기 찾기 화면을 넣을 element
	var element_wrap = document.getElementById('wrap');

	function foldDaumPostcode() {
		// iframe을 넣은 element를 안보이게 한다.
		element_wrap.style.display = 'none';
	}

	function sample3_execDaumPostcode() {
		// 현재 scroll 위치를 저장해놓는다.
		var currentScroll = Math.max(document.body.scrollTop,
				document.documentElement.scrollTop);
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample3_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample3_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample3_postcode').value = data.zonecode;
						document.getElementById("sample3_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample3_detailAddress")
								.focus();

						// iframe을 넣은 element를 안보이게 한다.
						// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
						element_wrap.style.display = 'none';

						// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
						document.body.scrollTop = currentScroll;
					},
					// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
					onresize : function(size) {
						element_wrap.style.height = size.height + 'px';
					},
					width : '100%',
					height : '100%'
				}).embed(element_wrap);

		// iframe을 넣은 element를 보이게 한다.
		element_wrap.style.display = 'block';
	}
</script>