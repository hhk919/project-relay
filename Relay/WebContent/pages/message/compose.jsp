<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: Compose</title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="/Relay/css/message.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#mnosearchbynick").keyup(function(event){
			if (event.which==13) {
				getMemberID();
			}
		});
		
		getUnreadCount();
		
		$("#btnMessage").click(function(){
			insertMessage();
	    });
		

	});
	
	
	function getMemberID(){
		var memberNick = $("#mnosearchbynick").val();
		console.log("memberNick",memberNick);
		$.ajax({
			type : "post",
			dataType : "json",
			data : {memberNick : memberNick},
			url : "/Relay/member/getMemberNick.do",
			success : function(result){
				// var output="";
				// output += '<option value="'+result[i].nick+'" />';
				var op = new Option(result.id, result.nick);
				op.setAttribute("data-no",result.mno);
				$("#memberNicks").append(op);
				console.log("receiver",$("option[value='"+memberNick+"']").attr("data-no"));
				console.log("rnick",memberNick);
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
	
	function insertMessage(){
		var scontent = $("#scontent").val();
		var stitle = $("#stitle").val();
		var sender = '<c:out value="${vo1.mno}"/>';
		var snick = '<c:out value="${vo1.nick}"/>';
		var rnick = $("#mnosearchbynick").val();
		var receiver = $("option[value='"+rnick+"']").attr("data-no");
		console.log("receiver",receiver);
		console.log("rnick",rnick);
		if(stitle == ""){
			alert("제목을 입력해주시기 바랍니다.");
		}
		if(scontent == ""){
			alert("내용을 입력해주시기 바랍니다.");
		}
		if(stitle != "" && scontent != ""){
			$.ajax({
				type : 'post',
				url : '/Relay/message/insert.do',
				dataType: "text",
				data : JSON.stringify({
					sender : sender,
					snick : snick,
					receiver : receiver,
					rnick : rnick, 
					stitle : stitle,
					scontent : scontent,
				}),
				contentType : "application/json; charset=UTF-8",
				success : function(){
					alert("메시지를 보냈습니다.");
					$("#scontent").val("");
					$("#stitle").val("");
					$("#mnosearchbynick").val("");
					$("#memberNicks option").remove();
					getUnreadCount();
				},
				error : function(){
					alert("보내기 실패... 받는 사람을 다시 확인해주세요!");
				}
			})
		}
	}
	
	
	function discard(){
		$("#scontent").val("");
		$("#stitle").val("");
		$("#mnosearchbynick").val("");
		$("#memberNicks option").remove();
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
	    	<div class="form-row mb-3">
	    		<div class="col-10 col-sm-11">
	    			<input type="text" class="form-control" id="mnosearchbynick" list="memberNicks" placeholder="닉네임을 입력후 엔터" autocomplete="off">
					<datalist id="memberNicks"></datalist>
				</div>
			</div>
			<div class="form-row mb-3">
				<div class="col-10 col-sm-11">
					<input type="text" class="form-control" id="stitle" placeholder="제목">
				</div>
			</div>
			<div class="form-row mb-1">
				<div class="col-10 col-sm-11">
					<div class="input-group">
					</div>
                </div>
			</div>
			<div class="form-row mb-3">
				<div class="col-sm-11">
					<div class="form-group mt-2">
						<textarea class="form-control" id="scontent" rows="12" placeholder="내용"></textarea>
					</div>
					<div class="form-group">
						<button type="button" id="btnMessage" class="btn btn-success">Send</button>
						<button type="reset" class="btn btn-danger" onclick="discard()">Discard</button>
					</div>
				</div>
	        </div>
		</main>
	</div>
</body>
</html>