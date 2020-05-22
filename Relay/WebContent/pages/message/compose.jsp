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
		getMemberID();
		getUnreadCount();
		$("#btnMessage").click(function(){
			insertMessage();
	    });
		$("#invite").change(function(){
			if($(this).prop("checked")){
				getRname();
			}else{
				$("#relay").attr("type","hidden");
				$("#relay").val("");
				$("#getRelay").children().remove();
				$("#getRelay").hide();
				$("#rname").attr("type","hidden");
				$("#rname").val("");
				$("#rage").attr("type","hidden");
				$("#rage").val("");
				$("#rgender").attr("type","hidden");
				$("#rgender").val("");
				$("#rhobby").attr("type","hidden");
				$("#rhobby").val("");
				$("#rjob").attr("type","hidden");
				$("#rjob").val("");
			}
		});
		$("#nick").on("input",function(){
			var rno = $("#getRelay").val();
			relayCheck(rno);
		});
	});
	
	function getRname(){
		var mno = '<c:out value="${vo1.mno}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/relay/getRname.do?mno=" + mno,
			success : function(result){
					output = "";
					output += "<option value=''>초대를 원하는 릴레이를 선택해주세요.</option>";
					output += "<option value='0'>새로운 대상 입력</option>";
					$("#getRelay").append(output);
				for(var i in result){
					outputs = "";
					outputs += "<option value='"+result[i].rno+"'>"+result[i].rname+"</option>";
					$("#getRelay").append(outputs);
				}
				$("#getRelay").show();
			},
		});
	}
	
	function getMemberID(){
		$.ajax({
			type : "post",
			dataType : "json",
			url : "/Relay/member/getMemberNick.do",
			success : function(result){
				var output="";
				for(var i in result){
					output += '<option value="'+result[i].nick+'" />';
					$("#memberNicks").append(new Option(result[i].nick, result[i].nick))
				}
				$("#memberNicks option[value='admin']").remove();
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
		var rno = $("#getRelay").val();
		var scontent = $("#scontent").val();
		var stitle = $("#stitle").val();
		var nick = $("#nick").val();
		var rname = $("#rname").val();
		var rage = $("#rage").val();
		var rgender = $("#rgender").val();
		var rhobby = $("#rhobby").val();
		var rjob = $("#rjob").val();
		var mno1 = '<c:out value="${vo1.mno}"/>';
		if($("#invite").prop('checked') == true){
			var invite = true;
		}
		if($("#invite").prop('checked') == false){
			var invite = false;
		}
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
					rno : rno,
					mno1 : mno1, 
					nick : nick, 
					stitle : stitle,
					scontent : scontent,
					invite : invite,
					rname : rname,
					rage : rage,
					rgender : rgender,
					rhobby : rhobby,
					rjob : rjob
				}),
				contentType : "application/json; charset=UTF-8",
				success : function(){
					alert("메시지를 보냈습니다.");
					$("#scontent").val("");
					$("#stitle").val("");
					$("#nick").val("");
					$("#invite").prop('checked',false);
					$("#relay").attr("type","hidden");
					$("#relay").val("");
					$("#getRelay").children().remove();
					$("#getRelay").hide();
					$("#rname").attr("type","hidden");
					$("#rname").val("");
					$("#rage").attr("type","hidden");
					$("#rage").val("");
					$("#rgender").attr("type","hidden");
					$("#rgender").val("");
					$("#rhobby").attr("type","hidden");
					$("#rhobby").val("");
					$("#rjob").attr("type","hidden");
					$("#rjob").val("");
					getUnreadCount();
				},
			})
		}
	}
	
	function relayCheck(that){
		if(that.value == "0"){
			$("#rname").attr("type","text");
			$("#rage").attr("type","text");
			$("#rgender").attr("type","text");
			$("#rhobby").attr("type","text");
			$("#rjob").attr("type","text");
		}else{
			var rno = $("#getRelay").val();
			var nick = $("#nick").val();
			$.ajax({
				type : 'get',
				url : '/Relay/relay.do?rno=' + rno,
				dataType: "json",
				success : function(result){
					for (var i in result){
						if(nick == result[i].nick){
							$("#btnMessage").prop("disabled",true);
							alert("이미 동일한 릴레이에 참여중인 회원입니다.");
						}else{
							$("#btnMessage").prop("disabled",false);
						}
					}
		        },
		    });
			
			$("#rname").attr("type","hidden");
			$("#rname").val("");
			$("#rage").attr("type","hidden");
			$("#rage").val("");
			$("#rgender").attr("type","hidden");
			$("#rgender").val("");
			$("#rhobby").attr("type","hidden");
			$("#rhobby").val("");
			$("#rjob").attr("type","hidden");
			$("#rjob").val("");
		}
	}
	
	function discard(){
		$("#scontent").val("");
		$("#stitle").val("");
		$("#nick").val("");
		$("#invite").prop("checked",false);
		$("#rname").attr("type","hidden");
		$("#rname").val("");
		$("#rage").attr("type","hidden");
		$("#rage").val("");
		$("#rgender").attr("type","hidden");
		$("#rgender").val("");
		$("#rhobby").attr("type","hidden");
		$("#rhobby").val("");
		$("#rjob").attr("type","hidden");
		$("#rjob").val("");
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
	    			<input type="text" class="form-control" id="nick" list="memberNicks" placeholder="아이디" autocomplete="off">
					<datalist id="memberNicks">
					</datalist>
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
					<div class="input-group-prepend">
						<div class="input-group-text">
  							<label class="checkbox-inline"><input id="invite" type="checkbox" value=""> 릴레이 초대</label>
						</div>
					</div>
					<select id="getRelay" class="form-control ml-4" onchange="relayCheck(this)">
					</select>
					</div>
					<input type="hidden" id="rname" class="form-control mt-2" placeholder="받는 사람 이름 / 릴레이 이름" autocomplete="off">
					<input type="hidden" id="rgender" class="form-control mt-2" placeholder="성별" autocomplete="off">
					<input type="hidden" id="rage" class="form-control mt-2" placeholder="나이" autocomplete="off">
					<input type="hidden" id="rhobby" class="form-control mt-2" placeholder="취미" autocomplete="off">
					<input type="hidden" id="rjob" class="form-control mt-2" placeholder="직업" autocomplete="off">
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