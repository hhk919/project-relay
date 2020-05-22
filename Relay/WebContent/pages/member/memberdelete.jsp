<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="relay.vo.member.MemberVO" %>
<%
	String url = application.getContextPath();
%>
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
<%	
	}
	else{
%>
		<!-- <a href="/Relay/pages/login/loginout.jsp">Logout</a> -->
<%}
		%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 회원탈퇴</title>
<link rel="stylesheet" href="/Relay/css/mypage.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script>
$(document).ready(function() {
	$.validate({
		modules : 'security'
	});
});
</script>
<%@ include file="/pages/include/header_afterlogin.jsp"%>
</head>
<body>
<div class="wrapper fadeInDown">
	<br>
	<div class="row">
		<div class="col-md-3 ">
		     <div class="list-group ">
              <a href="/Relay/memberRead.do" class="list-group-item list-group-item-action">Profile</a>
              <a href="/Relay/pages/member/memberupdate.jsp?update_id=${vo1.id}" class="list-group-item list-group-item-action">Edit</a>
              <a href="/Relay/pages/member/memberdelete.jsp?delete_id=${vo1.id}" class="list-group-item list-group-item-action active">탈퇴</a>
            </div>
		</div>
		<div class="col-md-9">
		    <div class="card">
		        <div class="card-body">
		            <div class="row">
		                <div class="col-md-12">
		                    <h4>회원탈퇴</h4>
		                    <hr>
		                </div>
		            </div>
		            <div class="row">
		                <div class="col-md-12">
		                    <form action="/Relay/memberdelete.do" method="post">
                              <div class="form-group row">
                                <label for="username" class="col-4 col-form-label">아이디</label> 
                                <div class="col-8">
                                  <input id="id" name="id" value="${vo1.getId()}" placeholder="ID" class="form-control here" type="text" required="required" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="password" class="col-4 col-form-label">비밀번호</label> 
                                <div class="col-8">
                                  <input id="pw" name="pw" placeholder="Password" class="form-control here" required="required" type="password"
                                  data-validation="custom" 
                                  data-validation-regexp="^(?=.*\d{1,30})(?=.*[~`!@#$%\^&*()-+=]{1,30})(?=.*[a-zA-Z]{2,30}).{8,50}$" 
                                  data-validation-error-msg="8자 이상의 영문 대소문자, 숫자와 특수문자로 조합해주세요">
                                </div>
                              </div>
                              <div class="form-group row">
                                <div class="offset-4 col-8">
                                  <button name="submit" type="submit" class="btn btn-primary">탈퇴</button>
                                </div>
                              </div>
                            </form>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</div>
<!--================ Start footer Area  =================-->	
<%@ include file="/pages/include/footer.jsp"%>
<!--================ End footer Area  =================-->
</body>
</html>