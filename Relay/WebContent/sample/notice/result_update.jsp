<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Relay: 공지사항 수정</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/Relay/css/result_update.css">
<%@ include file="/pages/include/header.jsp"%>
</head>

<body>
	<div class="container">
		<div class="row" style="margin-bottom: 20px; margin-top: 20px">
			<table class="table table-hover table-sm"
				style="text-align: center; border: 1px solid #dddddd;">
				<tbody>
					<c:if test="${result eq 1}">
						<tr>
							<td>공지사항 수정이 완료되었습니다</td>
						</tr>
						<tr>
							<td><a href="noticeList.do">공지사항 게시판으로 이동</a></td>
						</tr>
						<tr>
							<td><a href="boardList.do">전체 게시판으로 이동</a></td>
						</tr>
					</c:if>
					<c:if test="${result eq 0}">
						<tr>
							<td>잘못된 게시글입니다</td>
						</tr>
						<tr>
							<td><a href="javascript:history.back()">다시 입력</a></td>
						</tr>
					</c:if>
				</tbody>
			</table>
			<a href="noticeWrite.do" class="btn btn-primary pull right">공지사항 쓰기</a>
		</div>
	</div>
</body>

</html>