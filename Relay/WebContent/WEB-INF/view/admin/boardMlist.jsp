<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">
@import url("/Relay/css/admin.css");
</style>
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
			<table style="margin-left: auto; margin-right: auto">
				<tr>
					<th width="70">Status</th>
					<th width="30">BNo</th>
					<th width="100">Label</th>
					<th width="250">BName</th>
					<th width="150">Writer</th>
					<th width="100">ReportingDate</th>

					<c:forEach items="${adminlist}" var="board">
						<tr>

							<c:if test="${board.bvis == 0}">
								<td width="70">Deleted</td>
							</c:if>
							<c:if test="${board.bvis == 1}">
								<td width="50"></td>
							</c:if>
							<td width="30">${board.bno}</td>
							<td width="250">${board.btag}</td>
							<td width="100">${board.btitle}</td>
							<td width="150">${board.nick}</td>
							<td width="100"><fmt:formatDate pattern="yyyy-MM-dd"
									value="${board.bdate}" /></td>
							<td width="100"><a href="boardReadAdmin.do?bno=${board.bno}">게시글
									조회</a></td>
							<td align="left"><input type="button" value="Delete"
								onClick="if(confirm('삭제하시겠습니까?'))location.href='boardDeleteAdmin.do?bno=${board.bno}'" /></td>
						</tr>
					</c:forEach>
			</table>
			<br>
			<!-- <input type="submit" value="게시글작성" onclick="location.href='boardMwrite.jsp'" /> -->





		</Section>
	</div>


	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>