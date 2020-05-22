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
<title>Relay: 회원정보 수정</title>
<script>
	$('#myModal').on('shown.bs.modal', function () {
		$('#myInput').trigger('focus')
	});
</script>
<link rel="stylesheet" href="/Relay/css/mypage.css">
<link rel="stylesheet" href="/Relay/css/all.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery-form-validator/2.3.26/jquery.form-validator.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script>
$(document).ready(function(){
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
              <a href="/Relay/pages/member/memberupdate.jsp?update_id=${vo1.id}" class="list-group-item list-group-item-action active">Edit</a>
              <a href="/Relay/pages/member/memberdelete.jsp?delete_id=${vo1.id}" class="list-group-item list-group-item-action">탈퇴</a>
            </div>
		</div>
		<div class="col-md-9">
		    <div class="card">
		        <div class="card-body">
		            <div class="row">
		                <div class="col-md-12">
		                    <h4>회원정보 수정</h4>
		                    <hr>
		                </div>
		            </div>
		            <div class="row" style="font-size: 14px">
		                <div class="col-md-12">
		                    <form action="/Relay/memberupdate.do" method="post" autocomplete="off">
                              <div class="form-group row">
                                <label for="username" class="col-4 col-form-label">아이디</label> 
                                <div class="col-8">
                                  <input id="id" name="id" value="${vo1.getId()}" placeholder="ID" class="form-control here" type="text" required="required" readonly="readonly">
                                </div>
                              </div>
                              
                              <div style="font-size: 12px; color: red" id="pw-error-dialog"></div>
                              <div class="form-group row">
                                <label for="password" class="col-4 col-form-label">비밀번호</label> 
                                <div class="col-8">
                                  <input id="pw" name="pw" value="${vo1.getPw()}" placeholder="Password" class="form-control here" required="required" type="password"
                                  data-validation="custom"
	                   			data-validation-regexp="^(?=.*\d{1,30})(?=.*[~`!@#$%\^&*()-+=]{1,30})(?=.*[a-zA-Z]{2,30}).{8,50}$"
	                    		data-validation-error-msg="8자 이상의 영문 대소문자, 숫자와 특수문자로 조합해주세요"
			                    data-validation-error-msg-container="#pw-error-dialog">
                                </div>
                              </div>
                              
                              <div style="font-size: 12px; color: red" id="rpw-error-dialog"></div>
                              <div class="form-group row">
                                <label for="rpw" class="col-4 col-form-label">비밀번호 확인</label> 
                                <div class="col-8">
                                  <input id="rpw" value="${vo1.getPw()}" placeholder="Password Confirmation" class="form-control here" required="required" type="password"
                                  data-validation="confirmation" 
                                  data-validation-confirm="pw"
                                  data-validation-error-msg="정확한 비밀번호를 입력해주세요"
                                  data-validation-error-msg-container="#rpw-error-dialog">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="name" class="col-4 col-form-label">이름</label> 
                                <div class="col-8">
                                  <input id="name" name="name" value="${vo1.getName()}" placeholder="Name" class="form-control here" required="required" type="text" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="nick" class="col-4 col-form-label">닉네임</label> 
                                <div class="col-8">
                                  <input id="nick" name="nick" value="${vo1.getNick()}" placeholder="Nick Name" class="form-control here" required="required" type="text">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="addr" class="col-4 col-form-label">주소</label> 
                                <div class="col-8">
                                  <input id="addr" name="addr" value="${vo1.getAddr()}" placeholder="Address" class="form-control here" required="required" type="text">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="birth" class="col-4 col-form-label">생년월일</label> 
                                <div class="col-8">
                                  <input id="birth" name="birth" value="${vo1.getBirth()}" placeholder="Birthdate" class="form-control here" required="required" type="text" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="gender" class="col-4 col-form-label">성별</label> 
                                <div class="col-8">
                                  <input id="gender" name="gender" value="${vo1.getGender()}" placeholder="Gender" class="form-control here" required="required" type="text" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="job" class="col-4 col-form-label">직업</label> 
                                <div class="col-8">
                                  <input id="job" name="job" value="${vo1.getJob()}" placeholder="Job" class="form-control here" type="text">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="hobby" class="col-4 col-form-label">취미</label> 
                                <div class="col-8">
                                  <input id="hobby" name="hobby" value="${vo1.getHobby()}" placeholder="Hobby" class="form-control here" type="text">
                                </div>
                              </div>
                              <div class="form-group row">
                                <div class="offset-4 col-8">
                                  <button name="submit" type="submit" class="btn btn-primary">회원정보 수정</button>
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