<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 게시글 조회</title>
<link rel="stylesheet" href="/Relay/css/view.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
	var $j = jQuery.noConflict();
	
	$j(document).ready(function(){
		replyList();
		$j("#btnReply").click(function(){
	        replyInsert();
	    });
	});
	
	function replyUpdateShow(cno){
		var replyupdatetext = "#replyupdatetext"+cno;
		$j(replyupdatetext).toggle();
	}
	
	function replyUpdate(cno){
		var c = "#replyupdatetextarea"+cno;
		var ccontent= $j(c).val();
		var bno = '<c:out value="${vo.bno}"/>';
		var creplyer = '<c:out value="${vo1.getNick()}"/>';
		$j.ajax({
			type : 'put',
			url : '/Relay/replyUpdate.do?cno=' + cno,
			dataType : 'text',
			data : JSON.stringify({
				cno : cno,
				ccontent : ccontent
			}),
			contentType : "application/json; charset=UTF-8",
			success : function(){
				$j('#replyUpdateModal').modal("show");
				replyList();
			},
		})
	}
	
	function replyDelete(cno){
		$j.ajax({
			type : 'put', 
			url : '/Relay/replyDelete.do?cno=' + cno,
			success : function(){
				$j('#replyDeleteModal').modal("show");
				replyList();
			},
		})
	}
	
	function replyList(){
		var bno = '<c:out value="${vo.bno}"/>';
		$j.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/replyList.do?bno="+bno,
			success : function(result){
				var output = "";
				if($j.isEmptyObject(result)){
					output += "<font class='text-muted'>댓글이 없습니다.</font>";
					$j("#listReply").html(output);
				}
				else{
					for(var i in result){
						output += "<li class='list-group-item' data-cno='"+result[i].cno+"'>";
						output += "  <div><div class='header'><strong>"+result[i].creplyer+"</strong>"; 
						output += "    <small class='pull-right text-muted'>"
			     	           +changeDate(result[i].cdate)+"</small></div>";
						output += ""+result[i].ccontent;
						if('<c:out value="${vo1.getNick()}"/>' == result[i].creplyer){
							output += "<div class='float-right'>";
							output += "<i class='fas fa-hammer mr-2' id='btnUpdate' onclick='replyUpdateShow("+result[i].cno+")'> 수정</i>";
							output += "<i class='fas fa-trash-alt' id='btnDelete' onclick='replyDelete("+result[i].cno+")'> 삭제</i>";
							output += "</div>";
							output += "<div class='rp mt-3' id='replyupdatetext"+result[i].cno+"'>";
							output += "<textarea rows='5' cols='80' class='form-control' id='replyupdatetextarea"+result[i].cno+"'>" + result[i].ccontent + "</textarea>";
							output += "<button type='button' class='btn btn-outline-primary btn-sm mt-2 float-right' onclick='replyUpdate("+result[i].cno+")'>수정</button>";
							output += "</div>";
						}
						output += "</div>";
						output += "</li>";
		                
					$j("#listReply").html(output);
					$j(".rp").hide();
					}
					count = $j("#listReply li").length;
					if(!$j.isEmptyObject(result) & count > 5){
						output = "";
						output += "<div id='loadMore'>";
						output += "<div id='more'>";
						output += "<a href='#'>더보기<div id='arrow'><i class='ti-angle-down'></i></div></a>";
						output += "</div>";
						output += "</div>";
						$j("#more").html(output);
					}
					loadMore();
				}
	        }
	    });
	}
	
	function replyInsert(){
		var ccontent = $j("#replytext").val();
		if (ccontent == ""){
			$j('#replyInsertEmptyModal').modal("show");
		}
		var bno = '<c:out value="${vo.bno}"/>';
		var creplyer = '<c:out value="${vo1.getNick()}"/>';
		$j.ajax({
			type : 'post',
			url : '/Relay/replyInsert.do',
			dataType: "text",
			data : JSON.stringify({
				bno : bno, 
				ccontent : ccontent,
				creplyer : creplyer
			}),
			contentType : "application/json; charset=UTF-8",
			success : function(){
				$j('#replyInsertModal').modal("show");
				replyList();
				$j("#replytext").val("");
				updateReplyCNT(bno);
			},
		})
	}
	
	function updateReplyCNT(bno){
		$j.ajax({
			type : 'put', 
			url : '/Relay/board/updateReplyCNT.do?bno=' + bno,
			success : function(){
				
			}, error : function(){
				
			}
		})
	}
	
	function changeDate(date){
		date = new Date(parseInt(date));
		year = date.getFullYear();
		month = date.getMonth();
		day = date.getDate();
		hour = date.getHours();
		minute = date.getMinutes();
		second = date.getSeconds();
		strDate = year + "." + month + "." + day + " " + hour + ":" + minute + ":" + second;
		return strDate;
	}
	
	function loadMore(){
		count = $j("#listReply li").length;
		x=5;
	    $j('#listReply li').slice(0, 5).show();
	    $j('#loadMore').on('click', function (e) {
	        e.preventDefault();
	        x = x+5;
	        $j('#listReply li').slice(0, x).show();
	        if (x >= $j('#listReply li').length) {
	            $j(this).hide();
	            $j("#more").hide();
	        }
	    });
	}

</script>

<script>
	$j('#myModal').on('shown.bs.modal', function () {
		$j('#myInput').trigger('focus')
	});
</script>
<%
	if (session.getAttribute("vo1") == null)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
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
				<div class="board_tag pt-3">
					<h6>${vo.btag}</h6>
				</div>
				<div class="board_title">
					<c:out value="${vo.btitle}" />
				</div>
				<div class="board_info_box">
					<span class="board_author">
						<strong><c:out value="${vo.nick}" /></strong>
					</span>
					|&nbsp;&nbsp;
					<span class="board_author">
						<fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${vo.bdate}" />
					</span>
					<c:if test="${!empty vo.bupdate }">
						|&nbsp;
						<span class="board_author">
						최근 수정일: <fmt:formatDate pattern="yyyy.MM.dd HH:mm:ss" value="${vo.bupdate}" />
						</span>
					</c:if>
					|&nbsp;&nbsp;&nbsp;
					<span class="board_author">
						<c:out value="${vo.bcnt+1}"/>
					</span>
				</div>
				<div class="board_content py-3">${vo.bcontent}</div>
				<c:if test="${!empty vo.bimg}">
					<div class="board_img p-3">
						<a href="download.do?filename=${vo.bimg}">
							<img src= "img/${vo.bimg}">
						</a>
					</div>
				</c:if>
			</div>
			<div style="margin-top: 20px" align="right">
				<c:if test="${vo1.getMno() eq vo.mno}">
					<a href="boardGetForUpdate.do?bno=${vo.bno}" class="btn btn-primary">수정</a>
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
	  					삭제
	  				</button>
				</c:if>
				<a href="javascript:history.back()" class="btn btn-primary">목록</a>
				<br>
			</div>
			<div style="width:650px; text-align: center;">
        <br>
	    </div>
	    <!-- 댓글 목록 -->
	    <div class='row'>
			<div class="col-lg-12">

			    <div class="card">
			      <div class="card-header">
			        <i class="fa fa-comments fa-fw"></i> 댓글
			      </div>    
			        
      			<div class="card-body">
        			<!-- 댓글 시작 -->
        			<ul class="list-group list-group-flush" id="listReply">
       			 	</ul>
       			 	<div id="more" class="text-center mt-4">
					</div>
			        <!-- ./ end ul -->
		      	</div>
		      	<!-- /.panel .chat-panel -->
			
				<div class="card-footer">
				<c:if test="${vo1.getId() != null}">    
			        <textarea rows="5" cols="80" id="replytext" class="form-control" placeholder="댓글을 작성해주세요"></textarea>
			        <button type="button" id="btnReply" class="btn btn-primary btn-sm mt-2">댓글 작성</button>
        		</c:if>
				</div>
			
				</div>
			  </div>
			  <!-- ./ end row -->
			</div>
		</div>
	</article>
	
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
	  <div class="modal-dialog modal-dialog-centered">
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
	        <button type="button" class="btn btn-danger" data-dismiss="modal" onclick="location.href='/Relay/boardDelete.do?bno=${vo.bno}'">삭제</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- The Modal -->
	<div class="modal fade" id="replyDeleteModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">댓글 삭제</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        	댓글이 삭제되었습니다
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- The Modal -->
	<div class="modal fade" id="replyInsertModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">댓글 등록</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        	댓글이 등록되었습니다
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- The Modal -->
	<div class="modal fade" id="replyInsertEmptyModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">댓글 등록</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        	내용을 입력해주시기 바랍니다
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	
	<!-- The Modal -->
	<div class="modal fade" id="replyUpdateModal">
	  <div class="modal-dialog modal-dialog-centered">
	    <div class="modal-content">
	
	      <!-- Modal Header -->
	      <div class="modal-header">
	        <h4 class="modal-title">댓글 수정</h4>
	        <button type="button" class="close" data-dismiss="modal">&times;</button>
	      </div>
	
	      <!-- Modal body -->
	      <div class="modal-body">
	        	댓글이 수정되었습니다
	      </div>
	
	      <!-- Modal footer -->
	      <div class="modal-footer">
	        <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
	      </div>
	
	    </div>
	  </div>
	</div>
	<div class="footer">
	<%@ include file="/pages/include/footer.jsp"%>
	</div>
</body>
</html>