<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 회원정보</title>
<link rel="stylesheet" href="/Relay/css/mypage.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
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
	<div class="row">
		<div class="col-md-3">
		     <div class="list-group ">
              <a href="/Relay/memberRead.do" class="list-group-item list-group-item-action active">Profile</a>
              <a href="/Relay/pages/member/memberupdate.jsp?update_id=${vo1.id}" class="list-group-item list-group-item-action">Edit</a>
              <a href="/Relay/pages/member/memberdelete.jsp?delete_id=${vo1.id}" class="list-group-item list-group-item-action">탈퇴</a>
            </div>
		</div>
		
		<div class="col-md-9">
		    <div class="card">
		        <div class="card-body">
		            <div class="row">
		                <div class="col-md-12">
		                    <h4>회원정보</h4>
		                    <hr>
		                </div>
		            </div>
		            <div class="row">
		                <div class="col-md-12">
		                    <form action="memberupdate.do" method="post">
                              <div class="form-group row">
                                <label for="username" class="col-4 col-form-label">아이디</label> 
                                <div class="col-8">
                                  <input id="id" name="id" value="${vo1.getId()}" placeholder="ID" class="form-control here" type="text" required="required" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="password" class="col-4 col-form-label">비밀번호</label> 
                                <div class="col-8">
                                  <input id="pw" name="pw" value="${vo1.getPw()}" placeholder="Password" class="form-control here" required="required" type="password" readonly="readonly">
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
                                  <input id="nick" name="nick" value="${vo1.getNick()}" placeholder="Nick Name" class="form-control here" required="required" type="text" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="addr" class="col-4 col-form-label">주소</label> 
                                <div class="col-8">
                                  <input id="addr" name="addr" value="${vo1.getAddr()}" placeholder="Address" class="form-control here" required="required" type="text" readonly="readonly">
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
                                  <input id="job" name="job" value="${vo1.getJob()}" placeholder="Job" class="form-control here" required="required" type="text" readonly="readonly">
                                </div>
                              </div>
                              <div class="form-group row">
                                <label for="hobby" class="col-4 col-form-label">취미</label> 
                                <div class="col-8">
                                  <input id="hobby" name="hobby" value="${vo1.getHobby()}" placeholder="Hobby" class="form-control here" required="required" type="text" readonly="readonly">
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