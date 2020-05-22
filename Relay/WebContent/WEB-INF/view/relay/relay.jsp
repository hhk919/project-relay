<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: RELAY</title>
<!-- 부트스트랩 4.3.1 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="https://wowjs.uk/css/libs/animate.css">
<script src="https://wowjs.uk/dist/wow.min.js"></script>
<script>
	new WOW().init();
</script>
<!-- jQuery 3.2.1 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

<!-- 부트스트랩 4.3.1 JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

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
<link rel="stylesheet" href="/Relay/css/relay.css">
<script type="text/javascript">
	$(document).ready(function(){
		getList();
	});
	
	function getList(){
		var id = '<c:out value="${vo1.id}"/>';
		var listId = '<c:out value="${listId}"/>';
		$.ajax({
			type : 'get',
			url : '/Relay/relay/detail.do?listId=' + listId,
			dataType: "json",
			success : function(result) {
				var cnt = 0;
				var total = 0;
				var output = "";
				var senders = result.senders;
				for(var i in senders){
					output += "<div class='col-md-3 col-sm-6'>";
					output += "<div class='team'>";
					output += "<div class='team-image'>";
					output += "<div class='wow bounceIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
					if(senders[i].gift.pimg == null){
						output += "<img src='/Relay/img/relay/coming-soon.png' class='img-responsive' alt='product image'>";					
					}
					if(senders[i].gift.pimg != null){
						output += "<a href='"+senders[i].gift.pmallurl+"' target='_blank' title='상품페이지로 이동'>";
						output += "<img src='"+senders[i].gift.pimg+"' class='img-responsive' alt='상품을 추가해주세요~' style='max-height:300px'>";
						output += "</a>";
					}
					output += "</div>";
					output += "</div>";
					if(id == senders[i].memberId){
						output += "<button class='btn btn-danger btn-sm float-right mt-2' onclick='out(\""+listId+"\",\""+senders[i].memberId+"\")' data-toggle='tooltip' data-placement='right' title='릴레이에서 탈퇴'>OUT</button>";
					}
					output += "<h3>"+senders[i].memberNick+"</h3>";
					if(senders[i].gift.pname != null){
						output += "<p>"+senders[i].gift.pname+"</p>";
					}
					output += "</div>";
					output += "</div>";
					$("#relay").html(output);
					total++;
					if(senders[i].gift.pname != null){
						cnt++;					
					}
				}
				var progress = Math.round((cnt / total)*100);
				$("#progress").css("width", progress+"%");
				$("#progress").html(progress+"%");
				if($("#progress").text() == "100%"){
					$("#progress").attr("class","progress-bar bg-success");
				}
				output = "";
				
				if($("#takerinfo").children().length == 0){
					output += "<ul class='list-inline'>";
					if(result.recipient.name != null){
						output += "<li class='list-inline-item'>받는 사람 이름 / 릴레이 이름: "+result.recipient.name+"</li>";
					}
					if(result.recipient.age != 0){
						output += "<li class='list-inline-item'>&nbsp;나이: "+result.recipient.age+"</li>";
					}
					if(result.recipient.gender != null){
						output += "<li class='list-inline-item'>&nbsp;성별: "+result.recipient.gender+"</li>";
					}
					if(result.recipient.job != null){
						output += "<li class='list-inline-item'>&nbsp;직업: "+result.recipient.job+"</li>";
					}
					if(result.recipient.hobby != null){
						output += "<li class='list-inline-item mb-3'>&nbsp;취미: "+result.recipient.hobby+"</li>";
					}
					output += "</ul>";
					$("#takerinfo").html(output);
				
				}
			},
		})
	}
	
	function out(listId, id){
		$.ajax({
			type : 'put',
			url : '/Relay/relay/delete.do?listId=' + listId + '&id=' + id,
			success : function() {
				alert("릴레이에서 탈퇴하였습니다");
				window.location = "/Relay/pages/relay/main.jsp";
			}, error : function() {
				alert("탈퇴 오류 발생");
			}
		})
	}
</script>
</head>
<body>
	<div class="container">
	
		<div class="col-md-12 mt-3">
		  <h2 class="title title-center mb-4">RELAY</h2>
		  <div id="takerinfo">
		  </div>
		  <div class="progress" style="height: 25px;">
		  	<div class="progress-bar progress-bar-striped progress-bar-animated" id="progress" style="width:0%; color: white;"></div>
		  </div>
		</div>
         
       <div class="row" id="relay"></div>
       
	</div>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->
</body>
</html>