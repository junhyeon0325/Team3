<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>




<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">식품관</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		
		<li class="breadcrumb-item active text-white"><a href="productList.do?">채소</a></li>
		<li class="breadcrumb-item"><a href="#">정육</a></li>
		<li class="breadcrumb-item active text-white">수산</li>
		<li class="breadcrumb-item"><a href="#">미정</a></li>
	</ol>
</div>
<!-- Single Page Header End -->


<!-- Fruits Shop Start-->
<div class="container-fluid fruite py-5">
	<div class="container py-5">
		<h1 class="mb-4">Fresh foods shop</h1>
		<div class="row g-4">
			<div class="col-lg-12">
				<div class="row g-4">
					<div class="col-xl-3">
						<div class="input-group w-100 mx-auto d-flex">
							<input type="search" class="form-control p-3"
								placeholder="keywords" aria-describedby="search-icon-1">
							<span id="search-icon-1" class="input-group-text p-3"><i
								class="fa fa-search"></i></span>
						</div>
					</div>
					<div class="col-6"></div>
					<div class="col-xl-3">
						<div
							class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
							<label for="fruits">정렬 기준:</label>
							<select id="fruits" name="sort" class="border-0 form-select-sm bg-light me-3" form="fruitform" onchange="this.form.submit()">
								<option value="createdDate" ${sort == 'createdDate' ? 'selected' : ''}>등록순</option>
    							<option value="price" ${sort == 'price' ? 'selected' : ''}>가격순</option>
							</select>
							
							<form id="fruitform" action="productList.do" method="get"></form>
						</div>
					</div>
				</div>
				<div class="row g-4">
					<div class="col-lg-3">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="mb-3">
									<h4>Categories</h4>
									<ul class="list-unstyled fruite-categorie">
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="#"><i class="fas fa-apple-alt me-2"></i>채소</a>
												<span>(3)</span>
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="#"><i class="fas fa-apple-alt me-2"></i>정육</a>
												<span>(5)</span>
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="#"><i class="fas fa-apple-alt me-2"></i>수산</a>
												<span>(2)</span>
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="#"><i class="fas fa-apple-alt me-2"></i>미정</a>
												<span>(8)</span>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="mb-3">
									<h4 class="mb-2">가격</h4>
									<input type="range" class="form-range w-100" id="rangeInput"
										name="rangeInput" min="0" max="100000" value="0" step="1000"
										oninput="amount.value=rangeInput.value">
									<output id="amount" name="amount"
										for="rangeInput">0</output>
								</div>
							</div>
<!--
							<div class="col-lg-12">
								<div class="mb-3">
									<h4>검색 필터</h4>
									<div class="mb-2">
										<input type="radio" class="me-2" id="Categories-1"
											name="Categories-1" value="Beverages"> <label
											for="Categories-1"> Organic</label>
									</div>
									<div class="mb-2">
										<input type="radio" class="me-2" id="Categories-2"
											name="Categories-1" value="Beverages"> <label
											for="Categories-2"> Fresh</label>
									</div>
									<div class="mb-2">
										<input type="radio" class="me-2" id="Categories-3"
											name="Categories-1" value="Beverages"> <label
											for="Categories-3"> Sales</label>
									</div>
									<div class="mb-2">
										<input type="radio" class="me-2" id="Categories-4"
											name="Categories-1" value="Beverages"> <label
											for="Categories-4"> Discount</label>
									</div>
									<div class="mb-2">
										<input type="radio" class="me-2" id="Categories-5"
											name="Categories-1" value="Beverages"> <label
											for="Categories-5"> Expired</label>
									</div>
								</div>
							</div>
-->
							<div class="col-lg-12">
								<h4 class="mb-3">인기 상품</h4>
								<div class="d-flex align-items-center justify-content-start">
									<div class="rounded me-4" style="width: 100px; height: 100px;">
										<img src="img/featur-1.jpg" class="img-fluid rounded" alt="">
									</div>
									<div>
										<h6 class="mb-2">Big Banana</h6>
										<div class="d-flex mb-2">
											<i class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
										</div>
										<div class="d-flex mb-2">
											<h5 class="fw-bold me-2">2.99 $</h5>
											<h5 class="text-danger text-decoration-line-through">4.11
												$</h5>
										</div>
									</div>
								</div>
								<div class="d-flex align-items-center justify-content-start">
									<div class="rounded me-4" style="width: 100px; height: 100px;">
										<img src="img/featur-2.jpg" class="img-fluid rounded" alt="">
									</div>
									<div>
										<h6 class="mb-2">Big Banana</h6>
										<div class="d-flex mb-2">
											<i class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
										</div>
										<div class="d-flex mb-2">
											<h5 class="fw-bold me-2">2.99 $</h5>
											<h5 class="text-danger text-decoration-line-through">4.11
												$</h5>
										</div>
									</div>
								</div>
								<div class="d-flex align-items-center justify-content-start">
									<div class="rounded me-4" style="width: 100px; height: 100px;">
										<img src="img/featur-3.jpg" class="img-fluid rounded" alt="">
									</div>
									<div>
										<h6 class="mb-2">Big Banana</h6>
										<div class="d-flex mb-2">
											<i class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i
												class="fa fa-star text-secondary"></i> <i class="fa fa-star"></i>
										</div>
										<div class="d-flex mb-2">
											<h5 class="fw-bold me-2">2.99 $</h5>
											<h5 class="text-danger text-decoration-line-through">4.11
												$</h5>
										</div>
									</div>
								</div>
								<div class="d-flex justify-content-center my-4">
									<a href="#"
										class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew
										More</a>
								</div>
							</div>
							<div class="col-lg-12">
								<div class="position-relative">
									<img src="img/banner-fruits.jpg"
										class="img-fluid w-100 rounded" alt="">
									<div class="position-absolute"
										style="top: 50%; right: 10px; transform: translateY(-50%);">
										<h3 class="text-secondary fw-bold">
											Fresh <br> Foods <br> Banner
										</h3>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-9">
						<div class="row g-4 justify-content-center">
						
						<!-- 메인 반복 -->
						<c:forEach var = "product" items = "${productList }">
							<div class="col-md-6 col-lg-6 col-xl-4">
								<div class="rounded position-relative fruite-item">
									<div class="fruite-img">
									<a href="detailPage.do?productNo=${product.productNo}">
										 <img src=${product.productImage } class="img-fluid w-100 rounded-top" style="height:200px; object-fit:cover;" alt=""></a>
									</div>
									<div
										class="text-white bg-secondary px-3 py-1 rounded position-absolute"
										style="top: 10px; left: 10px;">vegetable</div>
									<div
										class="p-4 border border-secondary border-top-0 rounded-bottom" align="center">
										<h4>${product.productName }</h4>
										<p>${product.productDesc }</p>
										<div class="d-flex justify-content-between flex-lg-wrap" align= "center">
											<p class="text-dark fs-5 fw-bold mb-0">${product.productPrice }원 / kg
											<a href="#"
												class="btn border border-secondary rounded-pill px-3 text-primary"><i
												class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a></p>
										</div>
									</div>
								</div>
							</div>
							</c:forEach>
							<!-- 메인 반복 끝 -->
							

							
							<!-- 페이징 -->
							<div class="col-12">
								<div class="pagination d-flex justify-content-center mt-5">
									<c:if test="${currentPage > 1}">
									<a href="productList.do?page=${currentPage - 1}" class="rounded">&laquo;</a>
									</c:if>
									<c:forEach begin="1" end="${totalPages}" var="i">
									<a href="productList.do?page=${i}"class="rounded ${i == currentPage ? 'active' : ''}">${i}</a>
									</c:forEach>
									<c:if test="${currentPage < totalPages}">
									<a href="productList.do?page=${currentPage + 1}" class="rounded">&raquo;</a>
									</c:if>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Fruits Shop End-->