<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">임박상품 특가코너!</h1>
        </div>
        <!-- Single Page Header End -->


<!-- Fruits Shop Start-->
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <h1 class="mb-4">임박상품 <br> 특가코너!</h1>
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="row g-4">
                            <div class="col-xl-3">
                                <div class="input-group w-100 mx-auto d-flex">
                                    <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                                    <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                                </div>
                            </div>
                            
                            
                            <div class="col-6"></div>
                            <div class="col-xl-3">
                                <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                    <form id="fruitform" action="saleProduct.do" method="get">
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
                        
                 <!-- 가격필터 -->       
                            <div class="col-lg-3">
                                <div class="row g-4">
                 		<form action="saleProduct.do" method="get" id="filterForm">
								<input type="hidden" name="maincategory" value="${currentCategory}">
							    <input type="hidden" name="page" value="1">
							    <input type="hidden" name="sort" value="${sort}">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h4 class="mb-2">가격 범위</h4>
                                            <div class="mb-3" align="right">
												<input type="range" class="form-range w-100" id="maxPrice" name="maxPrice" min="0" max="50000" 
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
                                    </div>
                        </form>            
                                    <div class="col-lg-12">
                                        <div class="position-relative">
                                            <img src="img/banner-fruits.jpg" class="img-fluid w-100 rounded" alt="">
                                            <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                <h2 class="text-secondary fw-bold">Big <br> Sale <br> Festival</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                   <!-- 가격필터 end -->         
                   <!-- 상품 리스트 start -->
                            <div class="col-lg-9">
                                <div class="row g-4 justify-content-center">
                                	<c:forEach var="sale" items="${saleList }">
	                                    <div class="col-md-6 col-lg-6 col-xl-4">
	                                        <div class="rounded position-relative fruite-item">
	                                            <div class="fruite-img">
	                                                <img src="${sale.productImage }" class="img-fluid w-100 rounded-top" style="height:300px; object-fit:cover;" alt="">
	                                            </div>
	                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">!!임박특가!!</div>
	                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">${sale.discountRate }%</div>
	                                            <div class="p-4 border border-secondary border-top-0 rounded-bottom">
	                                                <h4>${sale.productName }</h4>
	                                                <p>${sale.productAbout }</p>
	           <!-- 평점 -->			
						<div class="d-flex justify-content-center mb-4 align-items-center" style="font-size: 20px; gap: 1px;">
						    <c:set var="fullStars" value="${sale.productScore - (sale.productScore % 1)}" /> <!-- 정수 부분 -->
						    <c:set var="hasHalfStar" value="${sale.productScore % 1 >= 0.5}" /> <!-- 0.5 이상이면 반쪽 별 -->
						    <c:set var="emptyStars" value="${5 - fullStars - (hasHalfStar ? 1 : 0)}" /> <!-- 빈 별 개수 -->
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
						    <p class="mb-0 ms-2" style="margin-left:6px; position: relative;">
						        <!-- ${product.productScore} -->
						    </p>
						</div>
				<!-- 평점end -->
	                                                <div class="d-flex justify-content-between flex-lg-wrap">
	                                                    <p class="text-decoration-line-through">${sale.productPrice }원</p>
	                                                    <p class="text-danger fs-1 fw-bold mb-0">${sale.discountPrice }원</p>
	                                                  <div class="w-100 mt-3 d-flex justify-content-center">
	                                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary">
	                                                    <i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
	                                                  </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
                                    </c:forEach>
                        <!-- 상품 리스트 end -->
                       <!-- 페이징 -->             
                                    <div class="col-12">
                                        <div class="pagination d-flex justify-content-center mt-5">
                                        
                                        
                                          <c:if test="${startPage > 1 }">
                                            <a href="saleProduct.do?page=${startPage -1 }" class="rounded">&laquo;</a>
                                          </c:if>
                                          <c:forEach begin="${startPage }" end="${endPage }" var="i">
                                            <a href="saleProduct.do?page=${i }" class="rounded ${i == currentPage ? 'active' : ''}">${i }</a>
                                          </c:forEach>
                                          <c:if test="${endPage < totalSalePage }">  
                                            <a href="saleProduct.do?page=${endPage +1 }" class="rounded">&raquo;</a>
                                          </c:if>
                                        </div>
                                    </div>
                       <!-- 페이징 end -->             
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Fruits Shop End-->