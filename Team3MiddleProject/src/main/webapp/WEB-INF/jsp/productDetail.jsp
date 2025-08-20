<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">Shop Detail</h1>
	<ol class="breadcrumb justify-content-center mb-0">
		<li class="breadcrumb-item"><a href="#">Home</a></li>
		<li class="breadcrumb-item"><a href="#">Pages</a></li>
		<li class="breadcrumb-item active text-white">상품 상세 설명</li>
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
						<p class="mb-3">${product.maincategory}</p>
						<h5 class="fw-bold mb-3">
							<fmt:formatNumber value="${product.productPrice}" type="number"
								groupingUsed="true" />
							원
						</h5>
						<div class="d-flex mb-4 align-items-center" style="gap: 4px;">
							<div class="d-flex mb-4 align-items-center"
								style="font-size: 20px; gap: 1px;">
								<c:set var="fullStars"
									value="${product.productScore - (product.productScore % 1)}" />
								<!-- 정수 부분 -->
								<c:set var="hasHalfStar"
									value="${product.productScore % 1 >= 0.5}" />
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
									${product.productScore}점</p>
							</div>
						</div>
						<p class="mb-8">${product.productAbout}</p>
						<div class="input-group quantity mb-5" style="width: 100px;">
							<div class="input-group-btn">
								<button
									class="btn btn-sm btn-minus rounded-circle bg-light border">
									<i class="fa fa-minus"></i>
								</button>
							</div>
							<input type="text"
								class="form-control form-control-sm text-center border-0"
								value="1">
							<div class="input-group-btn">
								<button
									class="btn btn-sm btn-plus rounded-circle bg-light border">
									<i class="fa fa-plus"></i>
								</button>
							</div>
						</div>
						<a href="#"
							class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i
							class="fa fa-shopping-bag me-2 text-primary"></i> 장바구니 담기</a>
					</div>
					<div class="col-lg-12">
						<nav>
							<div class="nav nav-tabs mb-3">
								<button class="nav-link border-white border-bottom-0"
									type="button" role="tab" id="nav-mission-tab"
									data-bs-toggle="tab" data-bs-target="#nav-mission"
									aria-controls="nav-mission" aria-selected="false">Reviews</button>
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
								<input type="text" id="member_name"
									value="김영희<%-- ${sessionScope.member_name} --%>"
									class="form-control border-0 me-4" readonly
									style="width: 150px;" />

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
							<input type="hidden" id="productNo" name="productNo" value=${product.productNo } />
						</form>
					</div>
				</div>
			</div>
			<div class="col-lg-4 col-xl-3">
				<div class="row g-4 fruite">
					<div class="col-lg-12">
						<div class="input-group w-100 mx-auto d-flex mb-4">
							<input type="search" class="form-control p-3"
								placeholder="keywords" aria-describedby="search-icon-1">
							<span id="search-icon-1" class="input-group-text p-3"><i
								class="fa fa-search"></i></span>
						</div>
						<ul class="list-unstyled fruite-categorie">
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="productList.do?maincategory=채소" class="${currentCategory eq '채소' ? 'active text-white bg-secondary rounded px-2' : ''}">
													<i class="fas fa-apple-alt me-2"></i>Vegetable</a>
												<!-- <span>(${vegetableCnt })</span> -->
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="productList.do?maincategory=정육" class="${currentCategory eq '정육' ? 'active text-white bg-secondary rounded px-2' : ''}">
													<i class="fas fa-apple-alt me-2"></i>Meat</a>
												<!-- <span>(${meatCnt })</span> -->
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="productList.do?maincategory=수산" class="${currentCategory eq '수산' ? 'active text-white bg-secondary rounded px-2' : ''}">
													<i class="fas fa-apple-alt me-2"></i>Fish</a>
												<!-- <span>(${fishCnt })</span> -->
											</div>
										</li>
									</ul>
					</div>
					
					
					<div class="col-lg-12">
						<h4 class="mb-4">Featured products</h4>
						<div class="d-flex align-items-center justify-content-start">
							<div class="rounded" style="width: 100px; height: 100px;">
								<img src="./img/featur-1.jpg" class="img-fluid rounded"
									alt="Image">
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
							<div class="rounded" style="width: 100px; height: 100px;">
								<img src="./img/featur-2.jpg" class="img-fluid rounded" alt="">
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
							<div class="rounded" style="width: 100px; height: 100px;">
								<img src="./img/featur-3.jpg" class="img-fluid rounded" alt="">
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
								<img src="./img/vegetable-item-4.jpg" class="img-fluid rounded"
									alt="">
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
								<img src="./img/vegetable-item-5.jpg" class="img-fluid rounded"
									alt="">
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
								<img src="./img/vegetable-item-6.jpg" class="img-fluid rounded"
									alt="">
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
		<h1 class="fw-bold mb-0">Related products</h1>
		<div class="vesitable">
			<div class="owl-carousel vegetable-carousel justify-content-center">
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-6.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Parsely</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-1.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Parsely</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$4.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-3.png"
							class="img-fluid w-100 rounded-top bg-light" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Banana</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-4.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Bell Papper</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-5.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Potatoes</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-6.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Parsely</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-5.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Potatoes</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
				<div
					class="border border-primary rounded position-relative vesitable-item">
					<div class="vesitable-img">
						<img src="./img/vegetable-item-6.jpg"
							class="img-fluid w-100 rounded-top" alt="">
					</div>
					<div
						class="text-white bg-primary px-3 py-1 rounded position-absolute"
						style="top: 10px; right: 10px;">Vegetable</div>
					<div class="p-4 pb-0 rounded-bottom">
						<h4>Parsely</h4>
						<p>Lorem ipsum dolor sit amet consectetur adipisicing elit sed
							do eiusmod te incididunt</p>
						<div class="d-flex justify-content-between flex-lg-wrap">
							<p class="text-dark fs-5 fw-bold">$7.99 / kg</p>
							<a href="#"
								class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i
								class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Single Product End -->