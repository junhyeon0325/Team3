<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <head>
        <meta charset="utf-8">
        <title>Fruitables - Vegetable Website Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>

        <!-- Spinner Start 
        <div id="spinner" class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
            <div class="spinner-grow text-primary" role="status"></div>
        </div>
         Spinner End -->




        <!-- Modal Search Start -->
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="search" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1">
                            <span id="search-icon-1" class="input-group-text p-3"><i class="fa fa-search"></i></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal Search End -->


        <!-- Hero Start -->
        <div class="container-fluid py-5 mb-5 hero-header">
            <div class="container py-5">
                <div class="row g-5 align-items-center">
                    <div class="col-md-12 col-lg-7">
                        <h4 class="mb-3 text-secondary">100% Fresh Foods!</h4>
                        <h1 class="mb-5 display-3 text-primary">Fresh Vegetables & Meats & Fishes</h1>
                        <div class="position-relative mx-auto">
                            <input class="form-control border-2 border-secondary w-75 py-3 px-4 rounded-pill" type="number" placeholder="Search">
                            <button type="submit" class="btn btn-primary border-2 border-secondary py-3 px-4 position-absolute rounded-pill text-white h-100" style="top: 0; right: 25%;">Submit Now</button>
                        </div>
                    </div>
                    <div class="col-md-12 col-lg-5">
                        <div id="carouselId" class="carousel slide position-relative" data-bs-ride="carousel">
                            <div class="carousel-inner" role="listbox">
                                <div class="carousel-item active rounded" style="width:362px; height:242px;">
                                    <img src="product-IMG/냉동과일.jpg" class="img-fluid w-100 h-100 bg-secondary rounded" alt="First slide">
                                    <a href="frozenProductList.do?maincategory=냉동볶음밥" class="btn px-4 py-2 text-white rounded">Frozen</a>
                                </div>
                                <div class="carousel-item rounded" style="width:362px; height:242px;">
                                    <img src="img/hero-img-2.jpg" class="img-fluid w-100 h-100 rounded" alt="Second slide">
                                    <a href="productList.do?maincategory=채소" class="btn px-4 py-2 text-white rounded">Vesitables</a>
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button" data-bs-target="#carouselId" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button" data-bs-target="#carouselId" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Hero End -->


        <!-- Featurs Section Start -->
        <div class="container-fluid featurs py-5" >
            <div class="container py-5">
                <div class="row g-3">
                    <div class="col-md-6 col-lg-4">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto" >
                                <i class="fas fa-car-side fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center" >
                                <h5>무료배송 안내</h5>
                                <h6>Free Shipping</h6>
                                <p class="mb-0">12,000원 이상 구매 시 무료배송!</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fas fa-user-shield fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center">
                            	<h5>결제 보안 시스템</h5>
                                <h6>Security Payment</h6>
                                <p class="mb-0">결제 100% 보안!</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-4">
                        <div class="featurs-item text-center rounded bg-light p-4">
                            <div class="featurs-icon btn-square rounded-circle bg-secondary mb-5 mx-auto">
                                <i class="fa fa-phone-alt fa-3x text-white"></i>
                            </div>
                            <div class="featurs-content text-center">
                                <h5>24시 문의 가능!</h5>
                                <h6>24/7 Support</h6>
                                <p class="mb-0">365일 24시간 문의 가능!</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Featurs Section End -->


        <!-- Fruits Shop Start-->
                    




        <!-- All Shop Start-->
        <div class="container-fluid vesitable py-5">
            <div class="container py-5">
                <h1 class="mb-0">View All Foods</h1>
                <div class="owl-carousel vegetable-carousel justify-content-center">
                
	                 <c:forEach var="prd" items="${productList }">
	                    <div class="border border-primary rounded position-relative vesitable-item">
	                        <div class="vesitable-img">
	                        <a href="detailPage.do?productNo=${prd.productNo}">
	                            <img src="${prd.productImage }" class="img-fluid w-100 rounded-top" style="height:200px; object-fit:cover;" alt="">
	                        </a>
	                        </div>
	                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">All</div>
	                        <div class="p-4 rounded-bottom">
	                            <a href="detailPage.do?productNo=${prd.productNo }" class="h4">${prd.productName }</a>
	                            <p>${prd.productAbout }</p>
	            <!-- 평점 -->			
						<div class="d-flex justify-content-center mb-4 align-items-center" style="font-size: 20px; gap: 1px;">
						    <c:set var="fullStars" value="${prd.productScore - (prd.productScore % 1)}" /> <!-- 정수 부분 -->
						    <c:set var="hasHalfStar" value="${prd.productScore % 1 >= 0.5}" /> <!-- 0.5 이상이면 반쪽 별 -->
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
	                                <p class="text-dark fs-5 fw-bold mb-0">${prd.productPrice }원</p>
	                                <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
	                            </div>
	                        </div>
	                    </div>
	                 </c:forEach>
                </div>
            </div>
        </div>
        <!-- All Shop End -->
        
        <!-- Frozen Shop Start-->
        <div class="container-fluid vesitable py-5">
            <div class="container py-5">
                <h1 class="mb-0">Frozen Foods</h1>
                <div class="owl-carousel vegetable-carousel justify-content-center">
                
	                 <c:forEach var="prd" items="${frozenList }">
	                    <div class="border border-primary rounded position-relative vesitable-item">
	                        <div class="vesitable-img">
	                        <a href="detailPage.do?productNo=${prd.productNo}">
	                            <img src="${prd.productImage }" class="img-fluid w-100 rounded-top" style="height:200px; object-fit:cover;" alt="">
	                        </a>
	                        </div>
	                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Frozen</div>
	                        <div class="p-4 rounded-bottom">
	                            <a href="detailPage.do?productNo=${prd.productNo }" class="h4">${prd.productName }</a>
	                            <p>${prd.productAbout }</p>
	            <!-- 평점 -->			
						<div class="d-flex justify-content-center mb-4 align-items-center" style="font-size: 20px; gap: 1px;">
						    <c:set var="fullStars" value="${prd.productScore - (prd.productScore % 1)}" /> <!-- 정수 부분 -->
						    <c:set var="hasHalfStar" value="${prd.productScore % 1 >= 0.5}" /> <!-- 0.5 이상이면 반쪽 별 -->
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
	                                <p class="text-dark fs-5 fw-bold mb-0">${prd.productPrice }원</p>
	                                <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
	                            </div>
	                        </div>
	                    </div>
	                 </c:forEach>
                </div>
            </div>
        </div>
        <!-- Frozen Shop End -->
        
        
        <!-- Fresh Shop Start-->
        <div class="container-fluid vesitable py-5">
            <div class="container py-5">
                <h1 class="mb-0">Fresh Foods</h1>
                <div class="owl-carousel vegetable-carousel justify-content-center">
                
	                 <c:forEach var="prd" items="${freshList }">
	                    <div class="border border-primary rounded position-relative vesitable-item">
	                        <div class="vesitable-img">
	                        <a href="detailPage.do?productNo=${prd.productNo}">
	                            <img src="${prd.productImage }" class="img-fluid w-100 rounded-top" style="height:200px; object-fit:cover;" alt="">
	                        </a>
	                        </div>
	                        <div class="text-white bg-primary px-3 py-1 rounded position-absolute" style="top: 10px; right: 10px;">Fresh</div>
	                        <div class="p-4 rounded-bottom">
	                            <a href="detailPage.do?productNo=${prd.productNo }" class="h4">${prd.productName }</a>
	                            <p>${prd.productAbout }</p>
	            <!-- 평점 -->			
						<div class="d-flex justify-content-center mb-4 align-items-center" style="font-size: 20px; gap: 1px;">
						    <c:set var="fullStars" value="${prd.productScore - (prd.productScore % 1)}" /> <!-- 정수 부분 -->
						    <c:set var="hasHalfStar" value="${prd.productScore % 1 >= 0.5}" /> <!-- 0.5 이상이면 반쪽 별 -->
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
	                                <p class="text-dark fs-5 fw-bold mb-0">${prd.productPrice }원</p>
	                                <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
	                            </div>
	                        </div>
	                    </div>
	                 </c:forEach>
                </div>
            </div>
        </div>
        <!-- Fresh Shop End -->
        
        
		<!-- HighPrice Products Shop -->
                <div class="text-center mx-auto mb-5" style="max-width: 700px;">
                    <h1 class="display-4">High Price Products</h1>
                    <p>비싸면. 맛있습니다.</p>
                </div>
			<div class="container-fluid py-5">
            <div class="container py-5">
                <div class="row g-4">
                <c:forEach var="high" items="${highList }">
                    <div class="col-lg-6 col-xl-4">
                        <div class="p-4 rounded bg-light">
                            <div class="row align-items-center">
                                <div class="col-6">
                                <a href="detailPage.do?productNo=${high.productNo}">
                                    <img src="${high.productImage }" class="img-fluid rounded-circle w-100 " style="height:150px; object-fit:cover;" alt="">
                                </a>
                                </div>
                                <div class="col-6">
                                    <a href="detailPage.do?productNo=${high.productNo }" class="h5">${high.productName }</a>
                                    <div class="d-flex my-3">
                <!-- 평점 -->			
						<div class="d-flex justify-content-center mb-4 align-items-center" style="font-size: 20px; gap: 1px;">
						    <c:set var="fullStars" value="${high.productScore - (high.productScore % 1)}" /> <!-- 정수 부분 -->
						    <c:set var="hasHalfStar" value="${high.productScore % 1 >= 0.5}" /> <!-- 0.5 이상이면 반쪽 별 -->
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
                                    </div>
                                    <h4 class="mb-3">${high.productPrice }원</h4>
                                    <a href="#" class="btn border border-secondary rounded-pill px-3 text-primary">
                                    <i class="fa fa-shopping-bag me-2 text-primary"></i>장바구니 담기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                 </c:forEach>
                 </div>
              </div>
              </div>
        <!-- HighPrice Product End -->


    </body>
