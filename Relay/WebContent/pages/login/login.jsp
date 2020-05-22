<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 로그인</title>
<link rel="stylesheet" href="/Relay/css/login.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#id").focus();
	});
</script>
<%@ include file="/pages/include/header.jsp"%>
</head>
<body>
<div class="wrapper fadeInDown">
  <div id="formContent">
  
	  <!-- Header -->
	  <div class="fadeIn first">
	    <br>
	  </div>
	
	  <!-- Body -->
	  <form action="/Relay/memberlogin.do" method="POST" autocomplete="off">
	    <input type="text" id="id" name="id" class="fadeIn second" placeholder="id">
	    <input type="password" name="pw" class="fadeIn third" placeholder="password">
	    <input type="submit" class="fadeIn fourth mt-3" value="Log In">
	  </form>
	
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