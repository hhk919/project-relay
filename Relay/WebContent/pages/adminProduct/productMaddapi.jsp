<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
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
	function onlyNumber(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
				|| keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
			return;
		else
			return false;
	}
	function removeChar(event) {
		event = event || window.event;
		var keyID = (event.which) ? event.which : event.keyCode;
		if (keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39)
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
		<form action="/Relay/prdinsertAdmin.do" method="post">
			<table style="margin-left: auto; margin-right: auto;">

				<tr>
					<td align="center"> Category & Keyword </td>
					<td align="left"><input type="text" name="word"
						placeholder="필수입력"></td>
				</tr>
				<tr>
					<td align="center"> Number of Items </td>
					<td align="left"><input type="text"
						onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'
						style='ime-mode: disabled;' name="display" placeholder="숫자 1-100" max="100" maxlength="3"></td>
				</tr>
				<tr>
					<td align="center"> Starting Point </td>
					<td align="left"><input type="text"
						onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'
						style='ime-mode: disabled;' name="start" placeholder="숫자 1-1000" max="1000" maxlength="4"></td>
				</tr>
				<tr>
					<td align="center">  Sort </td><td><select class="form-control" name="sort">
							<option value="sim">Best Match</option>
							<option value="date">Newly Listed</option>
							<option value="asc">Highest Price</option>
							<option value="dsc">Lowest Price</option>
					</select>
					</td>
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