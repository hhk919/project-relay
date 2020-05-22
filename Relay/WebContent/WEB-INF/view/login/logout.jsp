<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 로그아웃</title>
<link rel="stylesheet" href="/Relay/css/login.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var time = '<c:out value="${vo1.logonTime}"/>';
		animate(time);
	});
	
	function animate(time){
		$({ Counter: 0 }).animate({
			  Counter: time
			}, {
			  duration: 1500,
			  easing: 'swing',
			  step: function() {
			    $('#logonTime').html("<h6>로그인 유지 시간: "+(this.Counter/1000).toFixed(2)+" 초</h6>");
			  }
			});
	}
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
	  	<div class="pb-4 pt-1">
		<h4>로그아웃 성공</h4>
		<div class="pt-3" id="logonTime"></div>
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