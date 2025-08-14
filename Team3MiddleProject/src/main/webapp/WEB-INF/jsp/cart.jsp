<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
[type="checkbox"] {
    width: 30px;
    height: 30px;
    display: inline-block;
    margin-top: 25px;
}
</style>
<!-- 메인제목(장바구니) -->
<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">장바구니</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="#">Home</a></li>
		<li class="breadcrumb-item"><a href="#">Pages</a></li>
		<li class="breadcrumb-item active text-white">Cart</li>
	</ol>
</div>
<!-- Single Page Header End -->
<!-- 메인제목(장바구니) -->


<!-- 장바구니 내용 -->
<!-- Cart Page Start -->
<div class="container-fluid py-5">
	<div class="container py-5">
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th scope="col"><input type="checkbox"></th>
						<th scope="col">이미지</th>
						<th scope="col">이름</th>
						<th scope="col">가격</th>
						<th scope="col">수량</th>
						<th scope="col">총 가격</th>
						<th scope="col">취소</th>
					</tr>
				</thead>
				<tbody>
					<!-- 반복시작 -->
					<c:forEach var="cp" items="${cp_list}">
						<tr>
							<td>
								<input type="checkbox">
							</td>
							<th scope="row">
								<div class="d-flex align-items-center">
									<img src="imges/${cp.productImage}"
										class="img-fluid me-5 rounded-circle"
										style="width: 80px; height: 80px;" alt="">
								</div>
							</th>
							<td>
								<p class="mb-0 mt-4">${cp.productName}</p>
							</td>
							<td>
								<p class="mb-0 mt-4" id="productPrice">${cp.productPrice}</p>
							</td>
							<td>
								<div class="input-group quantity mt-4" style="width: 100px;">
									<div class="input-group-btn">
										<button
											class="btn btn-sm btn-minus rounded-circle bg-light border">
											<i class="fa fa-minus"></i>
										</button>
									</div>
									<input type="text" id="productPcs"
										class="form-control form-control-sm text-center border-0"
										value="${cp.productPcs }">
									<div class="input-group-btn">
										<button
											class="btn btn-sm btn-plus rounded-circle bg-light border">
											<i class="fa fa-plus"></i>
										</button>
									</div>
								</div>
							</td>
							<td>
								<p id="totalPrice" class="mb-0 mt-4"></p>
							</td>
							<td>
								<button class="btn btn-md rounded-circle bg-light border mt-4">
									<i class="fa fa-times text-danger"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
					<!-- 반복끝 -->
				</tbody>
			</table>
		</div>
		<div class="row g-4 justify-content-end">
			<div class="col-8"></div>
			<div class="col-sm-8 col-md-7 col-lg-6 col-xl-4">
				<div class="bg-light rounded">
					<div class="p-4">
						<h1 class="display-6 mb-4">결제 금액</h1>
						<div class="d-flex justify-content-between mb-4">
							<h5 class="mb-0 me-4">상품금액</h5>
							<p class="mb-0">js처리 </p>
						</div>
						<div class="d-flex justify-content-between">
							<h5 class="mb-0 me-4">적립금</h5>
							<div class="">
								<p class="mb-0">js처리</p>
							</div>
						</div>
					</div>
					<div
						class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
						<h5 class="mb-0 ps-4 me-4">결제 예정 금액</h5>
						<p class="mb-0 pe-4">js처리</p>
					</div>
					<button
						class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
						type="button">js처리원 주문하기</button>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Cart Page End -->

<script>
	const cartList = ${cp_list};
</script>
<script src="js/cart.js"></script>

