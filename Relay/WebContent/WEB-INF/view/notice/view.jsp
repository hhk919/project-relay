<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 공지사항 조회</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/Relay/css/view.css">
<script>
	var $j = jQuery.noConflict();
	$j(document).ready(function(){
	});
	$j(document).on('click','#btnList',
			function() {
				location.href = "${pageContext.request.contextPath}/board/getBoardList";
			});
	$j('#myModal').on('shown.bs.modal', function () {
		  $j('#myInput').trigger('focus')
		});
</script>
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<%@ include file="/pages/include/header.jsp"%>
<%	
	}
	else{
%>
		<%@ include file="/pages/include/header_afterlogin.jsp"%>
<%}
		%>
</head>
<body>
	<article>
		<div class="container" role="main" id="main">
			<div class="bg-white rounded border">
				<div class="board_title pt-3">
					${vo.ntitle}
				</div>
				<div class="board_info_box">
					<span class="board_author">
						<strong><c:out value="${vo.nick}" /></strong>
					</span>
					|&nbsp;&nbsp;
					<span class="board_author">
						<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${vo.ndate}" />
					</span>
					<c:if test="${!empty vo.nupdate }">
					|&nbsp;
						<span class="board_author">
						최근 수정일: <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${vo.nupdate}" />
						</span>
					</c:if>
					|&nbsp;&nbsp;&nbsp;
					<span class="board_author">
						<c:out value="${vo.ncnt+1}"/>
					</span>
				</div>
				<div class="board_content py-3">${vo.ncontent}</div>
			</div>
			<div style="margin-top: 20px" align="right">
				<a href="boardList.do" class="btn btn-primary">목록</a>
				<%-- <a href="noticeGetForUpdate.do?nno=${vo.nno}" class="btn btn-primary">수정</a>
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
  					삭제
  				</button> --%>
			</div>
		</div>
	</article>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">게시글 삭제</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        	정말로 삭제하시겠습니까?
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="location.href='noticeDelete.do?nno=${vo.nno}'">삭제</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->
</body>
</html>