<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">상세 페이지</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="main.do">홈</a></li>
		<li class="breadcrumb-item"><a
			href="productList.do?maincategory=${product.maincategory}">${product.maincategory}</a></li>
		<li class="breadcrumb-item active text-white">${product.productName}</li>
	</ol>
</div>
<!-- Single Page Header End -->

<!-- Single Product Start -->
<div class="container-fluid py-5 mt-5">
	<div class="container py-5">
		<div class="row g-4 mb-5">
			<div class="col-lg-8 col-xl-9">
				<div class="row g-4">
					<div class="col-lg-6">
						<div class="border rounded">
							<a href="#"><img src=${product.productImage }
								class="img-fluid rounded" alt="Image"></a>
						</div>
					</div>
					<div class="col-lg-6">
						<h4 class="fw-bold mb-3">${product.productName}</h4>

						<c:choose>
							<c:when
								test="${empty product.discountPrice or product.discountPrice == 0}">
								<h5 class="fw-bold mb-3">
									<fmt:formatNumber value="${product.productPrice}" type="number"
										groupingUsed="true" />
									원
								</h5>
							</c:when>

							<c:otherwise>
								<div style="display: flex; align-items: center; gap: 10px;">
									<h2 class="mb-0">${product.discountRate }%</h2>
									<p class="text-decoration-line-through mb-0"
										style="font-size: 1.2rem;">
										<fmt:formatNumber value="${product.productPrice}"
											type="number" groupingUsed="true" />
										원
									</p>
								</div>

								<p class="text-danger fs-1 fw-bold mb-0">
									<fmt:formatNumber value="${product.discountPrice}"
										type="number" groupingUsed="true" />
									원
								</p>
							</c:otherwise>
						</c:choose>

						<div id="productScoreBox" class="mb-4">
							<div class="d-flex justify-content-start"
								style="font-size: 20px; gap: 1px;">
								<c:set var="fullStars"
									value="${product.productScore - (product.productScore % 1)}" />
								<c:set var="hasHalfStar"
									value="${product.productScore % 1 >= 0.5}" />
								<c:set var="emptyStars"
									value="${5 - fullStars - (hasHalfStar ? 1 : 0)}" />

								<!-- 꽉 찬 별 -->
								<c:forEach begin="1" end="${fullStars}">
									<i class="fa-solid fa-star text-warning"></i>
								</c:forEach>

								<!-- 반쪽 별 -->
								<c:if test="${hasHalfStar}">
									<i class="fa-solid fa-star-half-stroke text-warning"></i>
								</c:if>

								<!-- 빈 별 -->
								<c:forEach begin="1" end="${emptyStars}">
									<i class="fa-regular fa-star text-warning"></i>
								</c:forEach>
							</div>

							<!-- 별 아래 점수 출력 (왼쪽 정렬) -->
							<p class="mb-0 mt-2" style="font-size: 16px; text-align: left;">
								${product.productScore}점</p>
						</div>
						<p class="mb-2">${product.productAbout}</p>
						<div class="input-group quantity mb-3 cart" style="width: 100px;">
							<div class="input-group-btn">
								<button
									class="btn btn-sm btn-minus rounded-circle bg-light border">
									➖
									<!-- 수량감소버튼 -->
								</button>
							</div>
							<input type="text"
								class="ProductPcs form-control form-control-sm text-center border-0"
								value="1">
							<div class="input-group-btn">
								<button
									class="btn btn-sm btn-plus rounded-circle bg-light border">
									➕
									<!-- 수량증가버튼 -->
								</button>
							</div>
						</div>
						<a href="#" onclick="addToCart(${product.productNo });"
							class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i
							class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
					</div>
					<div class="col-lg-12">
						<nav>
							<div class="nav nav-tabs mb-3">
								<button class="nav-link border-white border-bottom-0"
									type="button" role="tab" id="nav-mission-tab"
									data-bs-toggle="tab" data-bs-target="#nav-mission"
									aria-controls="nav-mission" aria-selected="false">리뷰목록</button>
							</div>
						</nav>
						<div id="reviewList" class="mb-5"></div>
						<div id="pagination" class="text-center mb-5"></div>
					</div>

					<div class="review-box">
						<h4 class="mb-4 fw-bold">리뷰 남기기</h4>
						<form id="reviewForm" enctype="multipart/form-data" method="post"
							action="#">
							<!-- 작성자 + 별점 -->
							<div
								class="d-flex justify-content-between align-items-center mb-3">
								<!-- 작성자 -->
								<c:choose>
									<c:when test="${not empty sessionScope.logName}">
										<input type="text" id="member_name"
											value="${sessionScope.logName}"
											class="form-control border-0 me-4" readonly
											style="width: 150px;" />
									</c:when>
									<c:otherwise>
										<!-- 인풋 없을 때도 자리 차지하는 빈 div -->
										<div style="width: 150px;" class="me-4"></div>
									</c:otherwise>
								</c:choose>

								<!-- 별점 -->
								<div class="rating text-end" style="font-size: 15px; gap: 1px;">
									<i class="fa-regular fa-star text-muted"></i> <i
										class="fa-regular fa-star text-muted"></i> <i
										class="fa-regular fa-star text-muted"></i> <i
										class="fa-regular fa-star text-muted"></i> <i
										class="fa-regular fa-star text-muted"></i>
								</div>
							</div>

							<!-- 리뷰 작성 -->
							<div class="col-lg-12 mb-3">
								<textarea name="reviewContent" id="reviewContent"
									class="form-control border-0" cols="30" rows="6"
									placeholder="리뷰를 등록하세요." spellcheck="false"
									style="border: 1px solid #90EE90; border-radius: 6px;"></textarea>
							</div>

							<!-- 사진 첨부 + 등록 버튼 -->
							<div
								class="col-lg-12 d-flex justify-content-between align-items-center mb-3">
								<div>
									<label for="image" class="btn btn-green btn-icon"> <i
										class="fa-solid fa-camera"></i>
									</label> <input type="file" id="image" name="reviewImage"
										class="d-none">
								</div>

								<button type="submit" class="btn btn-green px-4 py-2">등록</button>
							</div>
							<input type="hidden" id="productNo" name="productNo"
								value=${product.productNo } />
						</form>
					</div>
				</div>
			</div>
			<div class="col-lg-4 col-xl-3">
				<div class="row g-4 fruite">
					<div class="col-lg-12">
						<ul class="list-unstyled fruite-categorie">
							<li>
								<div class="d-flex justify-content-between fruite-name">
									<a href="productList.do?maincategory=채소"
										class="${currentCategory eq '채소' ? 'active text-white bg-secondary rounded px-2' : ''}">
										<i class="fas fa-apple-alt me-2"></i>채소
									</a>
									<!-- <span>(${vegetableCnt })</span> -->
								</div>
							</li>
							<li>
								<div class="d-flex justify-content-between fruite-name">
									<a href="productList.do?maincategory=정육"
										class="${currentCategory eq '정육' ? 'active text-white bg-secondary rounded px-2' : ''}">
										<i class="fas fa-apple-alt me-2"></i>정육
									</a>
									<!-- <span>(${meatCnt })</span> -->
								</div>
							</li>
							<li>
								<div class="d-flex justify-content-between fruite-name">
									<a href="productList.do?maincategory=수산"
										class="${currentCategory eq '수산' ? 'active text-white bg-secondary rounded px-2' : ''}">
										<i class="fas fa-apple-alt me-2"></i>수산
									</a>
									<!-- <span>(${fishCnt })</span> -->
								</div>
							</li>
						</ul>
					</div>


					<div class="col-lg-12">
						<div class="position-relative">
							<img src="./img/banner-fruits.jpg"
								class="img-fluid w-100 rounded" alt="">
							<div class="position-absolute"
								style="top: 50%; right: 10px; transform: translateY(-50%);">
								<h3 class="text-secondary fw-bold">
									Fresh <br> Fruits <br> Banner
								</h3>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<h1 class="fw-bold mb-0">관련 상품</h1>
		<div class="vesitable">
			<div class="owl-carousel vegetable-carousel justify-content-center">
				<c:forEach var="item" items="${related}">
					<div
						class="border border-primary rounded position-relative vesitable-item">
						<div class="vesitable-img">
							<a href="detailPage.do?productNo=${item.productNo}"><img
								src="${item.productImage}" class="img-fluid w-100 rounded-top"
								style="height: 200px; object-fit: cover;" alt=""></a>
						</div>
						<div
							class="text-white bg-primary px-3 py-1 rounded position-absolute"
							style="top: 10px; right: 10px;">${item.maincategory}</div>
						<div class="p-4 pb-0 rounded-bottom">
							<h4>${item.productName}</h4>
							<div class="d-flex mb-4" style="font-size: 20px; gap: 1px;">
								<c:set var="fullStars"
									value="${item.productScore - (item.productScore % 1)}" />
								<!-- 정수 부분 -->
								<c:set var="hasHalfStar" value="${item.productScore % 1 >= 0.5}" />
								<!-- 0.5 이상이면 반쪽 별 -->
								<c:set var="emptyStars"
									value="${5 - fullStars - (hasHalfStar ? 1 : 0)}" />
								<!-- 빈 별 개수 -->
								<!-- 꽉 찬 별 -->
								<c:forEach begin="1" end="${fullStars}">
									<i class="fa-solid fa-star text-warning"></i>
								</c:forEach>
								<!-- 반쪽 별 -->
								<c:if test="${hasHalfStar}">
									<i class="fa-solid fa-star-half-stroke text-warning"></i>
								</c:if>
								<!-- 빈 별 -->
								<c:forEach begin="1" end="${emptyStars}">
									<i class="fa-regular fa-star text-warning"></i>
								</c:forEach>
								<p class="mb-0 ms-2"
									style="margin-left: 6px; position: relative;">
									<!-- ${product.productScore} -->
								</p>
							</div>
							<p>${item.productAbout}</p>
							<div class="d-flex justify-content-between flex-lg-wrap">
								<p class="text-dark fs-5 fw-bold">${item.productPrice}원</p>
								<a onclick="addToCart2(${item.productNo})"
									class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary">
									<i class="fa fa-shopping-bag me-2 text-primary"></i> 장바구니 담기
								</a>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</div>
<!-- Single Product End -->
<script>
  const logId = "${sessionScope.logId}";
</script>
<script>
let pcs = 1;

document.addEventListener('click', (e) => {
	// +버튼
	if (e.target.classList.contains('btn-plus')) {
		let cart = e.target.closest('.cart');
		let input = cart.querySelector('.ProductPcs');
		input.value = Number(input.value);	// 수량

		pcs = input.value;	// productPcs
		console.log('+버튼 눌렀을때' + pcs);
	}	// end if

	// -버튼
	if (e.target.classList.contains('btn-minus')) {
		let cart = e.target.closest('.cart');
		//console.log(cart);
		let input = cart.querySelector('.ProductPcs');
		if (Number(input.value) > 0) {
			input.value = Number(input.value);
		} else {
			return
		} // end if

		pcs = input.value;	// productPcs
		console.log('-버튼 눌렀을때' + pcs);
	}	// end if
})

document.addEventListener('input', (e) => {
	if (e.target.classList.contains('ProductPcs')) {
		let cart = e.target.closest('.cart');
		let input = cart.querySelector('.ProductPcs')
		if (Number(input.value) < 0) {
			input.value = 0;
		}
	}
})
console.log(document.querySelector('.ProductPcs').value);
pcs = document.querySelector('.ProductPcs').value;
function addToCart(productNo) {
	fetch('cartListAdd.do?productNo=' + productNo + '&productPcs=' + pcs)
	.then(resolve => resolve.json())
	.then(result => {
		if( result.retCode == 'loginNo') {
			alert('로그인을 해주세요.');
		} else if( result.retCode == 'OK' ) {
			cartListCount();
			alert('장바구니에 상품을 담았습니다.');
		} else if( result.retCode == 'NG' ) {
			alert('처리중 예외 발생')
		} else {
			alert('알수 없는 코드')
		}
	})
	.catch(err => console.error(err));	
}

function addToCart2(productNo) {
	fetch('cartListAdd.do?productNo=' + productNo + '&productPcs=1')
	.then(resolve => resolve.json())
	.then(result => {
		if( result.retCode == 'loginNo') {
			alert('로그인을 해주세요.');
		} else if( result.retCode == 'OK' ) {
			cartListCount();
			alert('장바구니에 상품을 담았습니다.');
		} else if( result.retCode == 'NG' ) {
			alert('처리중 예외 발생')
		} else {
			alert('알수 없는 코드')
		}
	})
	.catch(err => console.error(err));	
}
</script>
