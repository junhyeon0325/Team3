<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Navbar start -->
<div class="container-fluid fixed-top">
	<div class="container topbar bg-primary d-none d-lg-block">
		<div class="d-flex justify-content-between">
			<div class="top-info ps-2">
				<small class="me-3"><i
					class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="#"
					class="text-white">중앙대로403 5층</a></small> <small class="me-3"><i
					class="fas fa-envelope me-2 text-secondary"></i><a href="#"
					class="text-white">Email@Example.com</a></small>
			</div>
			<div class="top-link pe-2">
				<c:choose>
    <!-- 로그인 상태 -->
    <c:when test="${not empty sessionScope.loginMember}">
        <a href="logout.do" class="text-white">
            <small class="text-white mx-2">로그아웃</small>
        </a>
    </c:when>

    <!-- 로그아웃 상태 -->
    <c:otherwise>
        <a href="#" onclick="document.getElementById('id01').style.display='block'"
           class="text-white">
           <small class="text-white mx-2">로그인</small>
        </a>
        <%@ include file="/WEB-INF/jsp/login_form.jsp" %>
        <a href="signForm.do" class="text-white">
            <small class="text-white mx-2">회원가입</small>
        </a>
    </c:otherwise>
</c:choose>
			</div>
		</div>
	</div>
	<div class="container px-0">
		<nav class="navbar navbar-light bg-white navbar-expand-xl">
			<a href="main.do" class="navbar-brand"><h1 class="text-primary display-6">Fruitables</h1></a>
			<button class="navbar-toggler py-2 px-3" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
				<span class="fa fa-bars text-primary"></span>
			</button>
			
			
			<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
				<div class="navbar-nav mx-auto">
					<a href="productList.do?maincategory=채소" class="nav-item nav-link ${param.maincategory == '채소' || '정육' || '수산' ? 'active' : ''}">식품관</a>
    				<a href="frozenProductList.do?maincategory=냉동볶음밥"  class="nav-item nav-link ${param.maincategory == '냉동볶음밥' ? 'active' : ''}">냉동식품관</a>
					<a href="saleProduct.do" class="nav-item nav-link">임박상품특가</a>
				</div>
				<div class="d-flex m-3 me-0">
					<button
						class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4"
						data-bs-toggle="modal" data-bs-target="#searchModal">
						<i class="fas fa-search text-primary"></i>
					</button>
					<a href="cartlistform.do" class="position-relative me-4 my-auto"> <i
						class="fa fa-shopping-bag fa-2x"></i> <span
						class="CartListCount position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
						style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
					</a> <a href="mypage.do" class="my-auto"> <i class="fas fa-user fa-2x"></i>
					</a>
				</div>
			</div>
		</nav>
	</div>
</div>
<!-- Navbar End -->

<!-- Modal Search Start -->
<div class="modal fade" id="searchModal" tabindex="-1"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-fullscreen">
		<div class="modal-content rounded-0">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body d-flex align-items-center">
				<div class="input-group w-75 mx-auto d-flex">
					<form id="myFrom" action="search.do" method="get">
						<input type="text" id="inputValue" class="form-control p-3"
							placeholder="keywords" aria-describedby="search-icon-1" value=""> 
							<button type="button" onclick="submitForm()">검색</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal Search End -->
<div class="modal fade" id="searchModal" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">상품 검색</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <input type="text" id="searchInput" class="form-control" placeholder="검색어 입력">
      </div>
      <div class="modal-footer">
        <button type="button" id="searchBtn" class="btn btn-primary">검색</button>
      </div>
    </div>
  </div>
</div>
<script>
function submitForm() {
	  const inputValue = document.getElementById("inputValue").value;
	  window.location.href = "search.do?value=" + inputValue;
}
document.addEventListener('DOMContentLoaded', function() {
    cartListCount();
});
function cartListCount(){
    const logId = "${logId}"; 

	fetch('cartListCount.do?logId=' + logId)
	.then(resolve => resolve.json())
	.then(result => {
		countElement = document.querySelector('.CartListCount');
		if(countElement) {
			countElement.innerHTML = result.count;
		}
	})
	.catch(err => console.error(err));
}
cartListCount();
</script>