<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: Inbox</title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
<link rel="stylesheet" href="/Relay/vendors/themify-icons/themify-icons.css">
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
		getList();
		getUnreadCount();
	});
	
	function getMessage(sno, restate){
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
				if(restate != 5){
					$("#"+sno).removeClass("btn-warning").addClass("btn-light");					
				}
				getUnreadCount();
			},
			error : function(){
				alert("읽기 실패");
			}
		})
	}
	
	function updateRestate(sno, rno, restate){
		var mno = '<c:out value="${vo1.mno}"/>';
		$.ajax({
			type : 'put',
			url : '/Relay/message/updateRestate.do?sno='+sno+'&mno2='+mno+'&rno='+rno+'&restate='+restate,
			dataType : 'text',
			data : JSON.stringify({
				sno : sno,
				mno : mno,
				rno : rno,
				restate : restate
			}),
			contentType : "application/json; charset=UTF-8",
			success : function(){
				$("#"+sno).removeClass("btn-warning").addClass("btn-light");
				$("#invitation").hide();
				$("#accept").prop("disabled",true);
				$("#refuse").prop("disabled",true);
				$("#accept").hide();
				$("#refuse").hide();
				getUnreadCount();
				alert("답변이 반영되었습니다.");
			},
			error : function(){
				alert("답변 반영 실패");
			},
		})
	}
	
	function getList(){
		var mno = '<c:out value="${vo1.mno}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/message/list.do?mno="+mno,
			success : function(result){
				var output = "";
				if($.isEmptyObject(result)){
					output += "<ul class='list-group list-group-flush'>";
					output += "<li class='list-group-item text-muted'>";
					output += "받은 메시지가 없습니다.";
					output += "</li>";
					output += "</ul>";
					$("#messagelist").html(output);
				}else{
					for(var i in result){
						output += "<ul class='list-group list-group-flush' id='inboxlist'>";
						output += "<li class='list-group-item'>";
						if(result[i].sstate == 1){
							output += "<button class='btn btn-warning btn-sm' id='"+result[i].sno+"' type='button' onclick='getMessage("+result[i].sno+","+result[i].restate+")' data-toggle='collapse' data-target='#collapseExample"+result[i].sno+"' aria-expanded='false' aria-controls='collapseExample'>";
						}else if(result[i].restate == 3){
							output += "<button class='btn btn-light btn-sm' id='"+result[i].sno+"' type='button' onclick='getMessage("+result[i].sno+","+result[i].restate+")' data-toggle='collapse' data-target='#collapseExample"+result[i].sno+"' aria-expanded='false' aria-controls='collapseExample'>";
						}else if(result[i].restate == 4){
							output += "<button class='btn btn-light btn-sm' id='"+result[i].sno+"' type='button' onclick='getMessage("+result[i].sno+","+result[i].restate+")' data-toggle='collapse' data-target='#collapseExample"+result[i].sno+"' aria-expanded='false' aria-controls='collapseExample'>";
						}else if(result[i].restate == 5){
							output += "<button class='btn btn-warning btn-sm' id='"+result[i].sno+"' type='button' onclick='getMessage("+result[i].sno+","+result[i].restate+")' data-toggle='collapse' data-target='#collapseExample"+result[i].sno+"' aria-expanded='false' aria-controls='collapseExample'>";
						}else{
							output += "<button class='btn btn-light btn-sm' id='"+result[i].sno+"' type='button' onclick='getMessage("+result[i].sno+","+result[i].restate+")' data-toggle='collapse' data-target='#collapseExample"+result[i].sno+"' aria-expanded='false' aria-controls='collapseExample'>";						
						}
						output += result[i].stitle;
						output += "</button>";
						output += "<div class='float-right text-muted' style='font-size:0.875em'>"+result[i].nick+" | "+changeDate(result[i].sdate)+"</div>";
						output += "<div class='collapse mt-2' id='collapseExample"+result[i].sno+"'>";
						output += "<div class='card card-body'>";
						output += result[i].scontent;
						output += "</div>";
						if(result[i].restate == 5){
							output += "<button class='btn btn-success btn-sm mt-1' id='accept' onclick='updateRestate("+result[i].sno+","+result[i].rno+",3)'>릴레이 수락</button>";					
							output += "<button class='btn btn-danger btn-sm mt-1 ml-1' id='refuse' onclick='updateRestate("+result[i].sno+","+result[i].rno+",4)'>릴레이 거절</button>";					
						}
						output += "<div class='float-right'>";
						output += "<button class='btn btn-info btn-sm mt-1' id='btnDelete' onclick='deleteMessage("+result[i].sno+")'>삭제</button>";
						output += "</div>";
						output += "<div id='invitation'>";
						if(result[i].restate == 5){
							output += "<p class='text-muted mt-1' style='font-size:0.85em'>상대방으로부터 릴레이 초대가 있습니다.</p>";
							output += "<ul class='list-unstyled' style='font-size:0.85em' id='rinfo"+result[i].rno+"'>";
							output += "<li class='mt-1'>abc</li>";
							output += "</ul>";
						}
						output += "</div>";
						output += "</div>";
						output += "</li>";
						output += "</ul>";
						$("#messagelist").html(output);
						getRelayInfo(result[i].rno);
					}
					count = $("#inboxlist li").length;
					if(!$.isEmptyObject(result) & count > 5){
						output = "";
						output += "<div id='loadMore'>";
						output += "<div id='more'>";
						output += "<a href='#'>더보기<div id='arrow'><i class='ti-angle-down'></i></div></a>";
						output += "</div>";
						output += "</div>";
						$("#more").html(output);
					}
					loadMore();
				}
	        },
	    });
	}
	
	function getRelayInfo(rno){
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/relay/list.do?rno="+rno,
			success : function(result){
				for(var i in result){
					output = "";
					output += "<li style='display: list-item;'>받는 사람 이름: "+result[i].rname+"</li>";
					output += "<li style='display: list-item;'>나이: "+result[i].rage+"</li>";
					output += "<li style='display: list-item;'>성별: "+result[i].rgender+"</li>";
					output += "<li style='display: list-item;'>직업: "+result[i].rjob+"</li>";
					output += "<li style='display: list-item;'>취미: "+result[i].rhobby+"</li>";
					$("#rinfo"+rno).html(output);
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
	
	function deleteMessage(sno){
		$.ajax({
			type : 'put', 
			url : '/Relay/message/delete.do?sno=' + sno,
			success : function(){
				alert("삭제되었습니다.");
				getList();
			},
		})
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
	            $("#more").hide();
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
					<a class="nav-link" href="/Relay/pages/message/sent.jsp"><i class="fa fa-rocket"></i> Sent</a>
				</li>
			</ul>
		</nav>
		<main>
			<div id="messagelist">	
			</div>
			<div id="more" class="text-center mt-3">
			</div>
		</main>
	</div>
</body>
</html>