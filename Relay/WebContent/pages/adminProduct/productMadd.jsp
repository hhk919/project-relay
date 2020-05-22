<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>>
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
<script>
		function onlyNumber(event){
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				return false;
		}
		function removeChar(event) {
			event = event || window.event;
			var keyID = (event.which) ? event.which : event.keyCode;
			if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
				return;
			else
				event.target.value = event.target.value.replace(/[^0-9]/g, "");
		}
	</script>
<body>
	<Header>
		<h1 align="left"><a href="/Relay/index.jsp">Relay</a> Admin</h1>
		<p style="text-align: center">
			<a href="/Relay/pages/adminMember/memberM.jsp">Member&nbsp;|</a>
			&nbsp;&nbsp;<a href="/Relay/pages/adminProduct/productM.jsp">Products&nbsp;|</a>
			&nbsp;&nbsp;<a href="/Relay/pages/adminBoard/boardM.jsp">Board</a>
			|&nbsp;&nbsp;<a href="/Relay/pages/adminNotice/noticeM.jsp">Notice</a>&nbsp;&nbsp;
			|&nbsp;&nbsp;<a href="/Relay/pages/login/loginout.jsp">Logout</a>&nbsp;&nbsp;
		</p>
	</Header>

	<Nav>
		<a href="/Relay/prdlistAdmin.do">|ProductList|</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
			href="/Relay/pages/adminProduct/productMsearch.jsp">|ProductSearch|</a>
	</Nav>

	<Section>
		상품 추가
		<form action="/Relay/prdinsertoneAdmin.do" method="post">
			<table style="margin-left: auto; margin-right: auto">

				<tr>
					<td align="left">Product Name</td>
					<td align="left"><input type="text" name="pname" placeholder="필수입력"></td>
				</tr>
				<tr>
					<td align="left">Product ID</td>
					<td align="left"><input type="text" name="pid" placeholder="필수입력"></td>
				</tr>
				<tr>
					<td align="left">Highest Price</td>
					<td align="left"><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' name="phprice" placeholder="숫자필수입력"></td>
				</tr>
				<tr>
					<td align="left">Lowest Price</td>
					<td align="left"><input type="text" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' name="plprice"placeholder="숫자필수입력"></td>
				</tr>
				<tr>
					<td align="left">Mall</td>
					<td align="left"><input type="text" name="pmall" placeholder="필수입력"
						></td>

				</tr>
				<tr>
					<td align="left">URL</td>
					<td align="left"><input type="text" name="pmallurl" 
						value="https://"></td>

				</tr>
				<tr>
					<td align="left">IMG</td>
					<td align="left"><input type="text" name="pimg" value="https://"></td>

				</tr>

			</table>


			<br> <input type="submit" value="상품등록" />

		</form>
	</Section>


	<Footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>