<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<title>Relay: 공지사항 작성</title>
<link rel="stylesheet" href="/Relay/css/write.css">
<%@ include file="/pages/include/header.jsp"%>
</head>
<body>
	<article>
		<div class="container" role="main">
			<form name="form" id="form" method="post"
				action="noticeInsert.do" autocomplete="off">
				
				<div class="mb-3">
					<label for="title">공지사항 제목</label> 
					<input type="text" class="form-control" 
						name="ntitle" id="ntitle" 
						placeholder="제목을 입력해 주세요">
				</div>
				
				<div class="mb-3">
					<label for="reg_id">작성자</label>
					<input type="text" class="form-control" 
						name="mno" id="mno" 
						placeholder="이름을 입력해 주세요" readonly="readonly">
				</div>
				
				<div class="mb-3">
					<label for="content">내용</label>
					<textarea class="form-control" rows="5" 
						name="ncontent" id="ncontent"
						placeholder="내용을 입력해 주세요">
					</textarea>
				</div>
				
				<div align="right">
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
				<a href="noticeList.do" class="btn btn-primary">목록</a>
				</div>
				
			</form>
			<div>
			</div>
		</div>
	</article>
</body>
</html>
