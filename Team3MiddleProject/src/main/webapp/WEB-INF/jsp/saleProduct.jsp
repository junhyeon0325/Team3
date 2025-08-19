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
                <h1 class="mb-4">Fresh fruits shop</h1>
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
                                    <label for="fruits">정렬 기준:</label>
                                    <select id="fruits" name="fruitlist" class="border-0 form-select-sm bg-light me-3" form="fruitform">
                                        <option value="volvo">Nothing</option>
                                        <option value="saab">Popularity</option>
                                        <option value="opel">Organic</option>
                                        <option value="audi">Fantastic</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                 <!-- 가격필터 -->       
                        <div class="row g-4">
                            <div class="col-lg-3">
                                <div class="row g-4">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <h4 class="mb-2">Price</h4>
                                            <input type="range" class="form-range w-100" id="rangeInput" name="rangeInput" min="0" max="500" value="0" oninput="amount.value=rangeInput.value">
                                            <output id="amount" name="amount" min-value="0" max-value="500" for="rangeInput">0</output>
                                        </div>
                                    </div>
                                    <div class="col-lg-12">
                                        <div class="position-relative">
                                            <img src="img/banner-fruits.jpg" class="img-fluid w-100 rounded" alt="">
                                            <div class="position-absolute" style="top: 50%; right: 10px; transform: translateY(-50%);">
                                                <h2 class="text-secondary fw-bold">Food <br> Big <br> Sale</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                   <!-- 가격필터 end -->         
                            
                            <div class="col-lg-9">
                                <div class="row g-4 justify-content-center">
                                	<c:forEach var="sale" items="${saleList }">
	                                    <div class="col-md-6 col-lg-6 col-xl-4">
	                                        <div class="rounded position-relative fruite-item">
	                                            <div class="fruite-img">
	                                                <img src="${sale.productImage }" class="img-fluid w-100 rounded-top" style="height:300px; object-fit:cover;" alt="">
	                                            </div>
	                                            <div class="text-white bg-secondary px-3 py-1 rounded position-absolute" style="top: 10px; left: 10px;">!!임박특가!!</div>
	                                            <div class="p-4 border border-secondary border-top-0 rounded-bottom">
	                                                <h4>${sale.productName }</h4>
	                                                <p>${sale.productAbout }</p>
	                                                <div class="d-flex justify-content-between flex-lg-wrap">
	                                                    <p class="text-dark fs-5 fw-bold mb-0">${sale.productPrice }원</p>
	                                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary">
	                                                    <i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div>
                                    </c:forEach>
                       <!-- 페이징 -->             
                                    <div class="col-12">
                                        <div class="pagination d-flex justify-content-center mt-5">
                                          <c:if test="${currentPage > 1 }">
                                            <a href="saleProduct.do?page=${currentPage -1 }" class="rounded">&laquo;</a>
                                          </c:if>
                                          <c:forEach begin="1" end="${totalSalePage }" var="i">
                                            <a href="saleProduct.do?page=${i }" class="rounded ${i == currentPage ? 'active' : ''}">${i }</a>
                                          </c:forEach>
                                          <c:if test="${currentPage < totalSalePage }">  
                                            <a href="saleProduct.do?page=${currentPage +1 }" class="rounded">&raquo;</a>
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