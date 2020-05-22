<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 로그인</title>
<link rel="stylesheet" href="/Relay/css/login.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Header -->
    <div class="fadeIn first">
      <br>
    </div>

    <!-- Body -->
   	<div class="pb-4 pt-1">
	    <c:if test="${!empty vo1}">
	    	<h6>안녕하세요</h6>
	   		<strong style="color: blue">${vo1.getId()}</strong> 님
		</c:if>
		<c:if test="${empty vo1}">
			아이디와 비밀번호를 확인해주세요
			<br><br>
			<a href="/Relay/pages/login/login.jsp">다시 입력</a>
		</c:if>
	</div>
	
    <!-- Footer -->
    <div id="formFooter">
      RELAY.DO
    </div>

  </div>
</div>
<!--================ Start footer Area  =================-->	
<%@ include file="/pages/include/footer.jsp"%>
<!--================ End footer Area  =================-->
</body>
</html>