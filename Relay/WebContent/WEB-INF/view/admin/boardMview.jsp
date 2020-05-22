<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
@import url("/Relay/css/admin.css");

table {
	border: hidden;
}
</style>
<script>
	$(document)
			.on(
					'click',
					'#btnList',
					function() {
						location.href = "${pageContext.request.contextPath}/board/getBoardList";
					});
	
	$('#myModal').on('shown.bs.modal', function () {
		  $('#myInput').trigger('focus')
		})
	});
</script>
<%
	if (((MemberVO)session.getAttribute("vo1")).getMno() != 1)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
<%	
	}
	else{
%>
		
<%}
		%>
</head>
<body>
	<Header>
		<h1 align="left"><a href="/Relay/index.jsp">Relay</a> Admin</h1>
		<p style="text-align: center">
			<a href="/Relay/pages/adminMember/memberM.jsp">Member</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminProduct/productM.jsp">Products</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminBoard/boardM.jsp">Board</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminNotice/noticeM.jsp">Notice</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/login/loginout.jsp">Logout</a>
			&nbsp;&nbsp;
		</p>

	</Header>

	<Nav>
		<a href="/Relay/boardListAdmin.do">BoardList </a>
	</Nav>
	<div style="overflow: auto;">
		<Section>

			<table
				style="margin: auto; text-align: left; width: 60%; margin-bottom: -1px;">
				<tr>
					<td><strong style="font-size: 1.4em;">${vo.btitle}</strong>
				</tr>
				<tr>
					<td style="margin-top: -1px;">|&nbsp; ${vo.nick} &nbsp;|&nbsp;<fmt:formatDate
							pattern="yyyy.MM.dd HH:mm:ss" value="${vo.bdate}" /> &nbsp;| <c:if
							test="${!empty vo.bupdate }">
							<strong>ModifiedDate</strong>
						&nbsp;<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss"
								value="${vo.bupdate}" /> |
								
					</c:if>

					</td>
				</tr>

			</table>

			<table style="margin: auto; text-align: left; width: 60%;">
				<tr>
					<td>${vo.bcontent}</td>
				</tr>
			</table>
			<c:if test="${!empty vo.bimg}">
				<div class="board_img p-3">
					<a > <img
						src="image/${vo.bimg}" height="auto" width="500px">
					</a>
				</div>
			</c:if>
			<div style="margin-bottom: 30px;">
				
			<input type="button" value="Delete"
					onClick="if(confirm('정말로 삭제하시겠습니까?'))location.href='boardDeleteAdmin.do?bno=${board.bno}'" />

			</div>
		</Section>
	</div>

	<footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>