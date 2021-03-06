<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 회원정보 수정</title>
<link rel="stylesheet" href="/Relay/css/login.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<%

	if (session.getAttribute("memberresult") == null)
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

    <!-- Header -->
    <div class="fadeIn first">
      <br>
    </div>

    <!-- Body -->
   	<div class="pb-4 pt-1">
	    <c:if test="${!empty memberresult}">
	    	<h5>환영합니다</h5>
	   		<strong style="color: blue">${memberresult}</strong> 님
		</c:if>
		<c:if test="${empty memberresult}">
			이미 존재하거나 잘 못 입력하셨습니다
			<br><br>
			<a href="/Relay/pages/member/memberinsert.jsp">다시 입력</a>
		</c:if>
	</div>
	
    <!-- Footer -->
    <div id="formFooter">
      RELAY.DO
    </div>

  </div>
</div>
</body>
</html>