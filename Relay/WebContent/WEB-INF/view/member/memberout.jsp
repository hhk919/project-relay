<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/Relay/css/login.css">
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

    <!-- Header -->
    <div class="fadeIn first">
      <br>
    </div>

    <!-- Body -->
   	<div class="pb-4 pt-1">
	    <c:if test="${result eq 2}">
	    	<h5>이용해주셔서 감사했습니다</h5>
		</c:if>
		<c:if test="${result eq 0}">
			정확한 비밀번호를 입력해주시기 바랍니다
			<br><br>
			<a href="/Relay/pages/member/memberdelete.jsp?delete_id=${vo1.id}">다시 입력</a>
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