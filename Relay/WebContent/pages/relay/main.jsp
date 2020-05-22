<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: RELAY</title>
<link rel="stylesheet" href="/Relay/css/relay_main.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://wowjs.uk/css/libs/animate.css">
<script src="https://wowjs.uk/dist/wow.min.js"></script>
<script>
	new WOW().init();
</script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getInfo();
		relaystart();
	});
	
	function getInfo(){
		var id = '<c:out value="${vo1.id}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/relay/getInfo.do?id=" + id,
			success : function(result){
				output = "";
				if($.isEmptyObject(result)){
					output += "<ul>";
					output += "<li class='text-center'><h4>진행 중인 릴레이가 없습니다</h4></li>";
					output += "</ul>";
					$("#main").html(output);
				}else{
					outer = "";
					outer += "<div class='input-group'>";
					outer += "<select class='form-control' id='getRelay'>";
					outer += "</select>";
					outer += "<button class='btn btn-primary' id='enter'>ENTER</button>";
					outer += "</div>";
					$("#main").html(outer);
					enter();
					for(var i in result){
						output += "<option value='"+result[i].listId+"'>"+result[i].recipient+"</option>";
						$("#getRelay").show();
					}
					$("#getRelay").append(output);
				}
			},
		});
	}
	
	function enter(){
		$("#enter").click(function(){
			var listId = $("#getRelay").val();
			window.location = "/Relay/relay/getDetail.do?listId="+listId;
		});
	}
	
	function relaystart(){
		$("#relaystart").click(function(){
			window.open("/Relay/pages/relay/relaystart.jsp", "Start Relay","width=760,height=630");
		});
	}
	
	
</script>
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
	<div class="container" id="content">
		<div class="text-center mt-4 pt-4">
			<ul>
				<li><h1>RELAY</h1></li>
			</ul>
		</div>
		<div class="row mt-5">
			<div class="col-2"></div>
			<div class="col-8 wow zoomIn" data-wow-duration="1s" data-wow-delay="0.5s">
				<p>선물을 주고 싶은 대상을 위해 다수의 인원들이 중복되지 않게 각자 선물하고 싶은 상품을 공유하는 서비스입니다.</p>
				<p>먼저 참여를 원하는 멤버를 초대를 해주시기 바랍니다.
				<br>상품 검색을 이용하여 원하시는 선물을 찾아 릴레이 방에 담아주시면 참여한 모든 인원들에게 공유됩니다.</p>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row mt-4 pt-4">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div style="text-align:center"><button class='btn btn-primary' id="relaystart">새로운 RELAY START!</button></div>
			</div>
			<div class="col-sm-4"></div>
		</div>
		<div class="row mt-4 pt-4">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				<div id="main">
				</div>
			</div>
			<div class="col-sm-4"></div>
		</div>
	</div>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->
</body>
</html>