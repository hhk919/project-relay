<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 공지사항</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		var actionForm = $("#actionForm");
		$(".page-item a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click",function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
	});
</script>
<style>
body {
	padding-top: 90px;
	padding-bottom: 30px;
}
.board_title {
	font-weight : 700;
	font-size : 22pt;
	margin : 10pt;
}
.board_info_box {
	color : #6B6B6B;
	margin : 10pt;
}
.board_author {
	font-size : 10pt;
	margin-right : 10pt;
}
.board_date {
	font-size : 10pt;
}
.board_content {
	color : #444343;
	font-size : 12pt;
	margin : 10pt;
}
.board_tag {
	font-size : 11pt;
	margin : 10pt;
	padding-bottom : 10pt;
}
table a {
     text-decoration: none!important;
}
table a:hover {
    color:#343A40!important;
    text-decoration:none!important;
    cursor:pointer!important;
}
</style>
<%@ include file="/pages/include/header.jsp"%>
</head>
<body>
	<article>
		<div class="container">
			<div class="table-responsive">
				<table class="table table-hover table-sm">
					<colgroup>
						<col style="width: 5%;" />
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead>
						<tr>
							<th>NO</th>
							<th>말머리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="notice">
							<tr>
								<td>${notice.nno}</td>
								<td>공지사항</td>
								<td><a href="noticeRead.do?nno=${notice.nno}">${notice.ntitle}</a></td>
								<td>${notice.nick}</td>
								<td>..</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.ndate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<table class="container">
				<tr>
					<th colspan="3"></th>
				</tr>
				<tr>
					<td style="padding-top: 1px" colspan="2" align="center">
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<c:if test="${pageMaker.prev}">
									<li class="page-item"><a class="page-link" href="${pageMaker.startPage-1}"><i class="fas fa-angle-double-left"></i></a></li>
								</c:if>
								<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
									<li class="page-item ${pageMaker.cri.pageNum == num ? "active":""} "><a class="page-link" href="${num}">${num}</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next}">
									<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}"><i class="fas fa-angle-double-right"></i></a></li>
								</c:if>
							</ul>
							<form id="actionForm" action="noticeList.do" method="get">
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
								<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
								<input type="hidden" name="type" value="<c:out value="${ pageMaker.cri.type }"/>">
								<input type="hidden" name="keyword" value="<c:out value="${ pageMaker.cri.keyword }"/>">
							</form>
						</nav>
					</td>
				</tr>
				<tr>
					<td align="right"><a href="noticeWrite.do" class="btn btn-primary pull right">글쓰기</a>
					<a href="noticeList.do" class="btn btn-primary">목록</a></td>
				</tr>
			</table>
				<div class="form-inline justify-content-center">
					<form action="noticeList.do" method="get" id="searchForm">
						<select name="type" class="form-control" style="width: auto;">
							<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
							<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
							<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
							<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
							<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
							<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
							<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':''}"/>>제목 or 내용 or 작성자</option>
						</select>
							<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' style="padding-bottom: 6px; width: 226px" class="form-control"/>
							<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
							<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
						<button class="btn btn-primary pull right">검색</button>
					</form>
				</div>
			</div>
		</div>
	</article>
</body>
</html>