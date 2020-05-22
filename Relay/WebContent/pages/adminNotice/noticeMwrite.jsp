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
<script src='http://code.jquery.com/jquery-2.2.3.min.js'></script>
<script type="text/javascript">

//글자수 제한 체크 

$(function() {
      $('#content').keyup(function (e){
          var content = $(this).val();
          $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
          $('#counter').html(content.length + '/2000');
      });
      $('#content').keyup();
      
      if (content.length>2000){
    	  alert("최대 2000자까지 입력 가능합니다");
      }
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
			<a href="/Relay/pages/adminMember/memberM.jsp">Member&nbsp;|</a>
			&nbsp;&nbsp;<a href="/Relay/pages/adminProduct/productM.jsp">Products&nbsp;|</a>
			&nbsp;&nbsp;<a href="/Relay/pages/adminBoard/boardM.jsp">Board</a>
			|&nbsp;&nbsp;<a href="/Relay/pages/adminNotice/noticeM.jsp">Notice</a>&nbsp;&nbsp;
			|&nbsp;&nbsp;<a href="/Relay/pages/login/loginout.jsp">Logout</a>&nbsp;&nbsp;
		</p>

	</Header>

	<Nav>
		<a href="/Relay/noticeListAdmin.do">NoticeList </a>
	</Nav>
	<div style="overflow: auto;">
		<form action="/Relay/noticeInsertAdmin.do" method="post" id="insertFrm" name="insertFrm">
			<Section>
				<table
					style="margin: auto; text-align: left; width: 60%; margin-bottom: -1px;">
					<tr>
						<td>Title &nbsp;<input type="text" style="width: 100%;"
							name="ntitle" id="ntitle"></td>
					</tr>
					<tr>
						<td style="margin-top: -1px;">Writer &nbsp; <input
							type="text" style="width: 100%;" value="관리자" readonly="readonly">
							<input
							type="hidden" style="width: 100%;" name="mno" id="mno" value="1" readonly="readonly"></td>

					</tr>

				</table>

				<table
					style="margin: auto; text-align: left; width: 60%; padding-bottom: 5px;">
					<tr>
						<td>Content &nbsp;</td>
					</tr>
					
					<tr>
						<td><div class="wrap"><textarea style="width: 100%; height: 350px;"
								name="ncontent" id="content" placeholder="2000자 이내 작성" ></textarea><div style="text-align:right;" id="counter"></div></div></td>
					</tr>
					


				</table>
			
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">

			</Section>
		</form>
	</div>

	<footer>
		<a href="/Relay/pages/admin/adminindex.jsp"
			style="text-decoration: none">Home</a>
	</Footer>

</body>
</html>