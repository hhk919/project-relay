<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>>
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
	$(document).on('click','#btnList',
					function() {location.href = "${pageContext.request.contextPath}/board/getBoardList";});
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
		<a href="/Relay/noticeListAdmin.do">NoticeList </a>
	</Nav>
	<div style="overflow: auto;">
	<form action="/Relay/noticeUpdateAdmin.do" method="post">
		<Section>
			<table
				style="margin: auto; text-align: left; width: 60%; margin-bottom: -1px;">
				<tr>
					<td>Title &nbsp;<input type="text" style="width: 100%;"
						name="ntitle" id="ntitle" value="${vo.ntitle}"></td>
				</tr>
				<tr>
					<td style="margin-top: -1px;">Writer &nbsp;
					<input type="text"
						style="width: 100%;" name="mno" id="mno" value="${vo.mno}"></td>

				</tr>

			</table>

			<table style="margin: auto; text-align: left; width: 60%; padding-bottom:5px;">
				<tr>
					<td>Content &nbsp;</td>
				</tr>
				<tr>
					<td><textarea style="width: 100%; height:150px;"name="ncontent" id="ncontent">${vo.ncontent}</textarea></td>
				</tr>

			</table>
			<input type="hidden" name="nno" value="${vo.nno}">
			<input type="submit" value="수정완료">

		</Section>
		</form>
	</div>

	<footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>