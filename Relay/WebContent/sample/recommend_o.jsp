<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 상품 추천</title>
<link rel="stylesheet" href="/Relay/css/recommend.css">
<link rel="stylesheet" href="/Relay/css/all.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<%@ include file="/pages/include/header.jsp"%>
<%	
	}
	else{
%>
		<%@ include file="/pages/include/header_afterlogin.jsp"%>
<%}
		%>
</head>
<body>
	<div class="wrapper fadeInDown">
		<br>
		<div class="card bg-light">
			<h4 class="card-title mt-4 text-center" style="color: #343A40">상품 추천 검색   <i class="fa fa-gifts"></i></h4>
			<p class="divider-text"></p>
			<form class="form-inline mt-3 mb-2 mx-3" action="/Relay/recommsearch.do" method="post">
				<!-- <label class="sr-only" for="inlineFormInputName2">연령대</label> 
				<input type="text" class="form-control mb-2 mr-sm-2"
					id="inlineFormInputName2" placeholder="Jane Doe"> -->
				<select name="age" class="custom-select custom-select-lg mb-2 mr-sm-2" style="width: 200px;">
				  <option selected value="">연령대</option>
				  <option value="10대">10대</option>
				  <option value="20대">20대</option>
				  <option value="30대">30대</option>
				  <option value="40대">40대</option>
				  <option value="50대">50대</option>
				  <option value="60대">60대 이상</option>
				</select>
				<select name="gender" class="custom-select custom-select-lg mb-2 mr-sm-2" style="width: 200px;">
				  <option selected value="">성별</option>
				  <option value="남성">남성</option>
				  <option value="여성">여성</option>
				</select>
				<select name="hobby" class="custom-select custom-select-lg mb-2 mr-sm-2" style="width: 200px;">
				  <option selected value="">취미</option>
				  <option value="운동">운동</option>
				  <option value="요리">요리</option>
				  <option value="패션">패션</option>
				  <option value="영화감상">영화감상</option>
				  <option value="등산">등산</option>
				  <option value="여행">여행</option>
				</select>
				<!-- 검색결과수 -->
				<input type="hidden" name="display" value = 10>
				<!-- 시작위치수 -->
				<input type="hidden" name="start" value = 1>
				<!-- 정렬기준 -->
				<input type="hidden" name="sort" value = "sim">

				<button type="submit" class="btn btn-primary mb-2">검색</button>
			</form>
		</div>
		<!-- card.// -->

	</div>
	<!--container end.//-->
	<br>
	<br>
</body>
</html>