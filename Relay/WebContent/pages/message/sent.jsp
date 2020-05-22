<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: Sent</title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- 부트스트랩 4.3.1 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<!-- jQuery 3.2.1 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<!-- 부트스트랩 4.3.1 JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="/Relay/css/message.css">
<script type="text/javascript">
	$(document).ready(function(){
		getSentList();
		getUnreadCount();
	});
	
	function getMessage(sno){
		var mno = '<c:out value="${vo1.mno}"/>';
		$.ajax({
			type : 'put',
			url : '/Relay/message/getMessage.do?sno='+sno+'&mno2='+mno,
			dataType : 'text',
			data : JSON.stringify({
				sno : sno,
				mno : mno,
			}),
			contentType : "application/json; charset=UTF-8",
			success : function(){
				$("#"+sno).removeClass("btn-warning").addClass("btn-light");
			},
			error : function(){
				alert("읽기 실패");
			}
		})
	}
	
	function getSentList(){
		var mno = '<c:out value="${vo1.mno}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/message/sent.do?mno="+mno,
			success : function(result){
				var output = "";
				if($.isEmptyObject(result)){
					output += "<ul class='list-group list-group-flush'>";
					output += "<li class='list-group-item text-muted'>";
					output += "보낸 메시지가 없습니다.";
					output += "</li>";
					output += "</ul>";
					$("#messagelist").html(output);
				}else{
					for(var i in result){
						output += "<ul class='list-group list-group-flush' id='inboxlist'>";
						output += "<li class='list-group-item'>";
						output += "<button class='btn btn-light btn-sm' id='"+result[i].sno+"' type='button' data-toggle='collapse' data-target='#collapseExample"+result[i].sno+"' aria-expanded='false' aria-controls='collapseExample'>";
						output += result[i].stitle;
						output += "</button>";
						if(result[i].sstate == 1){
							output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+" | <span>읽지않음</span></div>";
						}else if(result[i].sstate == 2){
							if(result[i].restate == 0){
								output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+" | <span>읽음</span></div>";							
							}
							else if(result[i].restate == 3){
								output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+" | <span style='color:blue'>릴레이 수락</span></div>"
							}else if(result[i].restate == 4){
								output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+" | <span style='color:red'>릴레이 거절</span></div>";
							}else if(result[i].restate == 5){
								output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+" | <span style='color:green'>릴레이 수락 대기중</span></div>";
							}
						}else{
							output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+" | -</div>";						
						}
						output += "<div class='collapse mt-2' id='collapseExample"+result[i].sno+"'>";
						output += "<div class='card card-body'>";
						output += result[i].scontent;
						output += "</div>";
						output += "</div>";
						output += "</li>";
						output += "</ul>";
						$("#messagelist").html(output);
					}
					count = $("#inboxlist li").length;
					if(!$.isEmptyObject(result) & count > 5){
						$("#more").html("<a id='loadMore' href='#'>더 보기 (More)</a>");
					}
					loadMore();
				}
	        },
	    });
	}
	
	function getUnreadCount(){
		var mno = '<c:out value="${vo1.mno}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/message/getUnreadCount.do?mno="+mno,
			success : function(result){
				if(result == 0){
					$("#unread").html("");
				}else{
					$("#unread").html(result);
				}
	        },
	    });
	}
	
	function changeDate(date){
		date = new Date(parseInt(date));
		year = date.getFullYear();
		month = date.getMonth();
		day = date.getDate();
		hour = date.getHours();
		minute = date.getMinutes();
		second = date.getSeconds();
		strDate = year + "." + month + "." + day + " " + hour + ":" + minute;
		return strDate;
	}
	
	function loadMore(){
		count = $("#inboxlist li").length;
		x=5;
	    $('#inboxlist li').slice(0, 5).show();
	    $('#loadMore').on('click', function (e) {
	        e.preventDefault();
	        x = x+5;
	        $('#inboxlist li').slice(0, x).show();
	        if (x >= $('#inboxlist li').length) {
	            $(this).hide();
	        }
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
%>
</head>
<body>
	<br>
	<br>
	<div class="email-app">
		<nav>
			<a href="/Relay/pages/message/compose.jsp" class="btn btn-danger btn-block">New Message</a>
			<ul class="nav">
				<li class="nav-item">
					<a class="nav-link" href="/Relay/pages/message/inbox.jsp"><i class="fa fa-inbox"></i> Inbox <span class="badge badge-danger" id="unread"></span></a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="#"><i class="fa fa-rocket"></i> Sent</a>
				</li>
	            <!-- <li class="nav-item">
	                <a class="nav-link" href="#"><i class="fa fa-trash-o"></i> Trash</a>
	            </li> -->
			</ul>
		</nav>
		<main>
			<div id="messagelist">	
			</div>
			<div id="more" class="text-center mt-2">
			</div>
		</main>
	</div>
</body>
</html>