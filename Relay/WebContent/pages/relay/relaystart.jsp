<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay Start</title>
<link href="https://fonts.googleapis.com/css?family=Roboto+Condensed" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css">
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="/Relay/css/message.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#idsearchbynick").keyup(function(event){
			if (event.which==13) {
				getMemberID();
			}
		});
	});
	
	function getMemberID(){
		var memberNick = $("#idsearchbynick").val()
		$.ajax({
			type : "post",
			dataType : "json",
			data : {memberNick : memberNick},
			url : "/Relay/member/getMemberNick.do",
			success : function(result){
				var op = new Option(result.id,result.nick);
				op.setAttribute("data-no",result.mno)
				$("#memberNick").append(op);
	        },
	        error : function(error) {
	        	alert("해당 닉네임의 회원이 없습니다 ㅠㅠ")
	        }
	    });
	}
	function addSender(){
		nick = document.getElementById("idsearchbynick").value ;
		
		if (nick != '' && document.getElementById(nick) == null) {
			var tr = document.createElement("tr");
			var memberid = $("option[value='"+nick+"']").text() ;
			var mno = $("option[value='"+nick+"']").attr("data-no");
			tr.innerHTML = '<td colspan="3">'+nick+'</td>\n'+'<td colspan="1"><button onclick="delSender(this)">빼기</button></td>'
			tr.setAttribute("name",nick);
			tr.setAttribute("id",memberid);
			tr.setAttribute("data-no",mno);
			tr.setAttribute("class","senders");
			tr.setAttribute("style","text-align:center");
			document.querySelector("#selected").before(tr);
			
		}
	};
	
	function delSender(obj) {
		obj.parentNode.parentNode.remove();
	};
	
	function startRelay() {
		var mno = '<c:out value="${vo1.mno}"/>';
		var id = '<c:out value="${vo1.id}"/>';
		var nick = '<c:out value="${vo1.nick}"/>';
		var listId = "";
		var name = $("#name").val();
		var age = $("#age").val();
		var gender = $("#gender").val();
		var hobby = $("#hobby").val();
		var sendersvo = []
		var senders = $(".senders");
		var maker = new Object();
		maker.mno = mno;
		maker.memberId = id;
		maker.memberNick = nick;
		sendersvo.push(maker);
		senders.each(function(){
			var sender = new Object();
			sender.mno = $(this).attr("data-no")
			console.log("mno",sender.mno)
			sender.memberId = $(this).attr("id");
			sender.memberNick = $(this).attr("name")
			sendersvo.push(sender);
		});
		
		$.ajax({
			type : "post",
			contentType : "application/json; charset=UTF-8",
			data : JSON.stringify({
				id : id,
				name : name,
				age : age,
				gender : gender,
				hobby : hobby,
				senders : sendersvo
			}),
			url : "/Relay/relay/create.do",
			success : function(result) {
				if (result) {
					alert("완료");	
				}
			},
			error : function(error) {
				alert("오류가 발생했습니다. 다시 한번 시도해주세요");
			}
			
		})
		
	};
	
	
</script>
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
<%	
	}
%>
<style>
th {
	border: 1px solid black;
}
td {
	text-align:center;
}
</style>
</head>
<body>
	<table align="center">
		<tr>
		<td>
	    	<div class="col-10 col-sm-11">
	    		<input type="text" id="idsearchbynick" list="memberNick" placeholder="닉네임을 입력 후 엔터">
	    	<!--  <input type="text" class="form-control" id="nick" list="memberNicks" placeholder="아이디" autocomplete="off">-->
				<datalist id="memberNick"></datalist>
			</div>
		</td>
		<td>
			<button class='btn btn-primary' onclick="addSender()">추가하기</button>
		</td>
		</tr>
	</table>
	<p/>
	<table id="relayvo" align="center" style="border:1px solid; border-spacing:5px; border-collapse: separate;">
		<tr><td width="25%"/><td width="25%"/><td width="25%"/><td width="25%"/></tr>
		<tr><th colspan="4" style="text-align:center">보내는 사람</th></tr>
		<tr id="selected"></tr>
		<tr>
			<th colspan="4" style="text-align:center">선물 받는 친구</th>
		<tr>
		<tr>
			<td colspan="2">이름/별칭  :</td>
			<td colspan="2"><input id="name" placeholder="이름/별칭"/></td>
		</tr>
		<tr>
			<td colspan="2">나이  :</td>
			<td colspan="2"><input id="age" placeholder="나이" type="number"/></td>
		</tr>
		<tr>
			<td colspan="2">성별  :</td>
			<td colspan="2"><select style="width:100%" id="gender"><option value="남">남</option><option value="여">여</option></select></td>
		</tr>
		<tr>
			<td colspan="2">취미  :</td>
			<td colspan="2"><input id="hobby" placeholder="취미"/></td>
		</tr>
		<tr><td/><td/><td/><td/></tr>
		<tr/>
		<tr>
			<td colspan="4"> <button class='btn btn-primary' onclick="startRelay()">릴레이 시작</button>
		</tr>
	</table>
	
	
</body>
</html>