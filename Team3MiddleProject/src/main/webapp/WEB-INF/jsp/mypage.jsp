
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


0
<!-- 검색 -->
<div class="center">
	<form action="mypage.do">
		<div class="row">
			<div class="col-sm-4">
				<select name="searchCondition" class="form-control">
					<option value="">선택하세요</option>
					<option value="T" ${searchCondition == 'T' ? 'selected' : '' }>제목</option>
					<option value="W" ${searchCondition == 'W' ? 'selected' : '' }>작성자</option>
					<option value="TW" ${searchCondition == 'TW' ? 'selected' : '' }>제목 & 작성자</option>
				</select>
			</div>
			<div class="col-sm-5">
				<input type="text" name="keyword" class="form-control">
			</div>
			<div class="col-sm-3">
				<input type="submit" value="조회" class="btn btn-success">
			</div>
		</div>
	</form>
</div>
<h3>게시글 목록</h3>
<table class='table table-striped'>
	<thead>
		<tr>
			<th>글번호</th>
			<th>제 목</th>
			<th>작성자</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="board" items="${board_list }">
			<tr>
				<td><c:out value="${board.boardNo }" /></td>
				<td><a href='board.do?bno=${board.boardNo }&page=${paging.currPage}'>${board.title }</a></td>
				<td><c:out value="${board.writer }" /></td>
				<td><c:out value="${board.viewCnt }" /></td>
			</tr>
		</c:forEach>
	</tbody>


</table>
<!--  paging -->
<nav aria-label="Page navigation example">
	<ul class="pagination justify-content-center">

		<!--  이전페이지 여부 -->
		<c:choose>
			<c:when test="${paging.previous }">
    	<li class="page-item">
    	<a class="page-link" href="boardList.do?searchCondition=${searchCondition }&keyword=${keyword }&page=${paging.start - 1 }">Previous</a></li>
	  </c:when>
  		<c:otherwise>	
		<li class="page-item disabled"><a class="page-link">Previous</a></li>
		</c:otherwise>
	</c:choose>

		<!--  paging정보를 받아서 링크생성 -->
		<c:forEach var="p" begin="${paging.start }" end="${paging.end }">
		   <c:choose>
		   <c:when test="${paging.currPage eq p }">
		<li class="page-item active" aria-current="page">
		<span class="page-link">${p }</span></li>
		</c:when>
		<c:otherwise>
		<li class="page-item"><a class="page-link" href="boardList.do?searchCondition=${searchCondition }&keyword=${keyword }&page=${p }">${p }</a></li>
		</c:otherwise>
	   </c:choose>
	</c:forEach>

		<!-- 이후 페이지-->
	<c:choose>
	  <c:when test ="${paging.next }">
		<li class="page-item">
		<a class="page-link" href='boardList.do?searchCondition=${searchCondition }&keyword=${keyword }&page=${paging.end +1 }'>Next</a></li>
		</c:when>
	    <c:otherwise>
		<li class="page-item disabled"><a class="page-link">Next</a></li>
	    </c:otherwise>
	</c:choose>
	</ul>
</nav>

