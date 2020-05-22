<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Relay: 공지사항 등록</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<%@ include file="/pages/include/header.jsp"%>
</head>

<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="#">Relay</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">

				<li class="nav-item"><a class="nav-link" href="/board/boardList.do">게시판</a></li>

			</ul>
		</div>
	</nav>
	<div class="container">
		<div class="row" style="margin-bottom: 20px; margin-top: 20px">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;"></th>
					</tr>
				</thead>
				<tbody>
					<c:if test="${!empty result}">
						<tr>
							<td>공지사항 등록이 완료되었습니다</td>
						</tr>
						<tr>
							<td><a href="notice.html">공지사항 게시판 이동</a></td>
						</tr>
						<tr>
							<td><a href="boardList.do">전체 게시판으로 이동</a></td>
						</tr>
					</c:if>
					<c:if test="${empty result}">
						<tr>
							<td>잘못된 게시글입니다</td>
						</tr>
						<tr>
							<td><a href="javascript:history.back()">다시 입력</a></td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<a href="write.jsp" class="btn btn-primary pull right">글쓰기</a>
		</div>
	</div>
</body>

</html>