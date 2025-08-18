<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>




<!-- Single Page Header start -->
<div class="container-fluid page-header py-5">
	<h1 class="text-center text-white display-6">식품관</h1>
	<ol class="breadcrumb justify-content-center mb-0">
	                                                                           <!-- 버튼 이벤트 li가 아니라 a태그에 적용해야 되는거였음 -->   
		<li class="breadcrumb-item">
		  <a href="productList.do?maincategory=채소" class="${currentCategory eq '채소' ? 'active text-white bg-secondary rounded px-2' : ''}">채소</a>
		</li>
		<li class="breadcrumb-item">
		  <a href="productList.do?maincategory=정육" class="${currentCategory eq '정육' ? 'active text-white bg-secondary rounded px-2' : ''}">정육</a>
		</li>
		<li class="breadcrumb-item">
		  <a href="productList.do?maincategory=수산" class="${currentCategory eq '수산' ? 'active text-white bg-secondary rounded px-2' : ''}">수산</a>
		</li>
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
						<div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
							<form id="fruitform" action="productList.do" method="get">
								<input type="hidden" name="maincategory" value="${currentCategory}">
    							<input type="hidden" name="page" value="${currentPage}">
									<label for="fruits">정렬 기준:</label>
									<select id="fruits" name="sort" class="border-0 form-select-sm bg-light me-3" form="fruitform" onchange="this.form.submit()">
										<option value="createdDate" <c:if test="${sort eq 'createdDate'}">selected</c:if>>등록순</option>
										<option value="price" <c:if test="${sort eq 'price'}">selected</c:if>>가격순</option>
									</select>
							</form>
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
												<a href="productList.do?maincategory=채소" class="${currentCategory eq '채소' ? 'active text-white bg-secondary rounded px-2' : ''}">
													<i class="fas fa-apple-alt me-2"></i>Vegetable</a>
												<span>(${vegetableCnt })</span>
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="productList.do?maincategory=정육" class="${currentCategory eq '정육' ? 'active text-white bg-secondary rounded px-2' : ''}">
													<i class="fas fa-apple-alt me-2"></i>Meat</a>
												<span>(${meatCnt })</span>
											</div>
										</li>
										<li>
											<div class="d-flex justify-content-between fruite-name">
												<a href="productList.do?maincategory=수산" class="${currentCategory eq '수산' ? 'active text-white bg-secondary rounded px-2' : ''}">
													<i class="fas fa-apple-alt me-2"></i>Fish</a>
												<span>(${fishCnt })</span>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<form action="productList.do" method="get" id="filterForm">
								<input type="hidden" name="maincategory" value="${currentCategory}">
							    <input type="hidden" name="page" value="1">
							    <input type="hidden" name="sort" value="${sort}">
							    
									<div class="col-lg-12">
											<h4 class="mb-2">가격</h4>
										<div class="mb-3" align="right">
											<input type="range" class="form-range w-100" id="maxPrice" name="maxPrice" min="0" max="100000" 
												value="${param.maxPrice != null ? param.maxPrice : 0}" step="1000"
												oninput="amount.value=this.value">
											<output id="amount" name="amount" for="maxPrice">
												<c:out value="${empty param.maxPrice ? 0 : param.maxPrice}"/>
											</output>원
										</div>
										<div align="right">
											<button type="submit" class="btn btn-primary btn-sm">적용</button>
										</div>
									</div>
							</form>		
							
							<div class="col-lg-12">
								<h4 class="mb-3">최저가 상품</h4>
										<c:forEach var="lowest" items="${lowestProduct }">
											<div class="d-flex align-items-center justify-content-start">
												<div class="rounded me-4" style="width: 110px; height: 110px; padding=5px;">
													<img src="${lowest.productImage }" class="img-fluid rounded" style="width: 100px; height: 100px; padding=5px;" alt="">
												</div>
												<div>
														<h6 class="mb-2">${lowest.productName }</h6>
														<div class="d-flex mb-2">
															<i class="fa fa-star text-secondary"></i>
															<i class="fa fa-star text-secondary"></i>
															<i class="fa fa-star text-secondary"></i>
															<i class="fa fa-star text-secondary"></i>
															<i class="fa fa-star"></i>
														</div>
														<div class="d-flex mb-2">
															<h5 class="fw-bold me-2">${lowest.productPrice }원</h5>
														</div>
												</div>
											</div>
										</c:forEach>
											<div class="d-flex justify-content-center my-4">
												<a href="productList.do" class="btn border border-secondary px-4 py-3 rounded-pill text-primary w-100">Vew More</a>
											</div>
							</div>
															<!-- <h5 class="text-danger text-decoration-line-through">4.11원</h5> -->
							
							
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
									<div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">
										Fresh
									</div>
									<div class="p-4 border border-secondary border-top-0 rounded-bottom" align="center">
										<h4>${product.productName }</h4>
										<p>${product.productAbout }</p>
										<div class="d-block justify-content-between flex-lg-wrap" >
											<p class="text-dark fs-5 fw-bold mb-0" align="center">${product.productPrice }원</p>
											<a href="#" class="btn border border-secondary rounded-pill px-3 text-primary">
												<i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
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
									<a href="productList.do?maincategory=${currentCategory }&page=${currentPage - 1}&sort=${sort}" class="rounded">&laquo;</a>
									</c:if>
									<c:forEach begin="1" end="${totalPages}" var="i">
									<a href="productList.do?maincategory=${currentCategory }&page=${i}&sort=${sort}" class="rounded ${i == currentPage ? 'active' : ''}">${i}</a>
									</c:forEach>
									<c:if test="${currentPage < totalPages}">
									<a href="productList.do?maincategory=${currentCategory }&page=${currentPage + 1}&sort=${sort}" class="rounded">&raquo;</a>
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