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
	if (((MemberVO)session.getAttribute("vo1")).getMno() > 6)
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
		<Section>
			<table style="margin-left: auto; margin-right: auto">
				<tr>
					<th width="70">Status</th>
					<th width="30">Nno</th>
					<th width="250">Title</th>
					<th width="100">Writer</th>
					<th width="150">ReportingDate</th>
					<th width="150">ModifiedDate</th>

					<c:forEach items="${adminlist}" var="notice">
						<tr>

							<c:if test="${notice.nvis == 0}">
								<td width="70">Deleted</td>
							</c:if>
							<c:if test="${notice.nvis == 1}">
								<td width="50"></td>
							</c:if>
							<td width="30">${notice.nno}</td>
							<td width="250">${notice.ntitle}</td>
						
							<c:if test="${notice.mno == 1}">
							<td width="100">관리자</td>
							</c:if>
							<c:if test="${notice.mno == 2}">
							<td width="100">관리자</td>
							</c:if>
							<c:if test="${notice.mno == 3}">
							<td width="100">관리자</td>
							</c:if>
							<c:if test="${notice.mno == 4}">
							<td width="100">관리자</td>
							</c:if>
							<c:if test="${notice.mno == 5}">
							<td width="100">관리자</td>
							</c:if>
							<c:if test="${notice.mno == 6}">
							<td width="100">관리자</td>
							</c:if>
							
							<td width="100"><fmt:formatDate pattern="yyyy-MM-dd HH:MM:SS"
									value="${notice.ndate}" /></td>
							<td width="100"><fmt:formatDate pattern="yyyy-MM-dd HH:MM:SS"
									value="${notice.nupdate}" /></td>
							<td width="100"><a href="noticeReadAdmin.do?nno=${notice.nno}" >공지글 조회</a></td>
							<td align="left"><input type="button" value="Edit"
								onClick="location.href='noticeGetForUpdateAdmin.do?nno=${notice.nno}'" /></td>
							<td align="left"><input type="button" value="Delete"
								onClick="if(confirm('삭제하시겠습니까?')) location.href='noticeDeleteAdmin.do?nno=${notice.nno}'" /></td>
						</tr>
					</c:forEach>
			</table>
			<br> <input type="submit" value="공지글작성"
				onclick="location.href='/Relay/pages/adminNotice/noticeMwrite.jsp'" /> <br>






		</Section>
	</div>


	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>