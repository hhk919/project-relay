<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<a href="/Relay/prdlistAdmin.do">|ProductList|</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="/Relay/pages/adminProduct/productMsearch.jsp">|ProductSearch|</a>
	</Nav>

	<div style="overflow: auto;">
		<Section>
			<table style="margin-left: auto; margin-right: auto;">
				<tr>
					<th width="30">No</th>
					<th width="250">Name</th>
					<th width="100">Highest Price</th>
					<th width="100">Lowest Price</th>
					<th width="100">Mall</th>
					<th width="100">Url</th>
					<th width="100">Img</th>

				</tr>
				<c:if test="${!empty list}">

					<c:forEach items="${list}" var="product">
						<tr>

							<td width="30">${product.pno}</td>
							<td width="250" style="text-align: left;">${product.pname}</td>
							<td width="100">${product.phprice}</td>
							<td width="100">${product.plprice}</td>
							<td width="100">${product.pmall}</td>
							<td width="100"><a href="${product.pmallurl}"
								target="_blank">바로가기</a></td>

							<td width="100"><img src="${product.pimg}" width="50px"
								height="50px"></td>
							<td align="left"><input type="submit" value="Edit"
								onclick="location.href='prdsearchoneAdmin.do?update_no=${product.pno}'" /></td>
							<td align="left"><input type="submit" value="Delete"
								onclick="if(confirm('삭제하시겠습니까?'))location.href='prddeleteAdmin.do?delete_no=${product.pno}'" /></td>
								
						</tr>
					</c:forEach>

				</c:if>

			</table>
			<div style="padding-bottom: 30px; padding-top: 30px;">
				<input type="submit" value="상품추가(단일)"
					onclick="location.href='/Relay/pages/adminProduct/productMadd.jsp'" />
				&nbsp; <input type="submit" value="상품추가(API)"
					onclick="location.href='/Relay/pages/adminProduct/productMaddapi.jsp'" />
			</div>

		</Section>
	</div>

	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>