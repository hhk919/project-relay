<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
		<a href="/Relay/adminMemberList.do">MemberList </a>
	</Nav>
	<div style="overflow: auto;">
		<Section>
			<table style="margin-left: auto; margin-right: auto">
				<tr>
					<th width="30">No</th>
					<th width="100">Id</th>
					<th width="100">Pw</th>
					<th width="100">Name</th>
					<th width="150">Nick</th>
					<th width="150">Age Group</th>
					<th width="100">gender</th>
					<th width="130">Addr</th>
					<th width="100">Job</th>
					<th width="100">Hobby</th>
					<th width="100">Join Date</th>
					<th width="100">Out Date</th>
				</tr>
				<c:forEach items="${list}" var="member">
					<tr>
						<td width="30" align="center">${member.mno}</td>
						<td width="100" align="center">${member.id}</td>
						<td width="100" align="center">******</td>
						<td width="100" align="center">${member.name}</td>
						<td width="150" align="center">${member.nick}</td>
						<td width="150" align="center">${member.age}</td>
						<td width="100" align="center">${member.gender}</td>
						<td width="130" align="center">${member.addr}</td>
						<td width="100" align="center">${member.job}</td>
						<td width="100" align="center">${member.hobby}</td>
						<td width="100" align="center"><p style="font-size: 12px;">
								<fmt:formatDate pattern="yyyy-MM-dd"
									value="${member.joindate}" />
						<td width="100" align="center"><p style="font-size: 12px;">
								<fmt:formatDate pattern="yyyy-MM-dd"
									value="${member.outdate}" />
								
						
						<%-- <td width="100" align="center"><a
							href="/Relay/memberMinfo.do?mno=${member.mno}">상세 조회</a></td> --%>

						<td width="30" align="center"><input type="button"
							value="회원탈퇴"
							onClick="if(confirm('정말 삭제하시겠습니까?')) location.href='/Relay/memberMdeleteAdmin.do?mno=${member.mno}'"></td>
							
							<td width="30" align="center"><input type="button"
							value="완전삭제"
							onClick="if(confirm('정말 삭제하시겠습니까?')) location.href='/Relay/memberMdelete2Admin.do?mno=${member.mno}'"></td>
					</tr>
				</c:forEach>
			</table>

			<p style="text-align: center">
				<a href=""></a>
			</p>


		</Section>
	</div>


	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>