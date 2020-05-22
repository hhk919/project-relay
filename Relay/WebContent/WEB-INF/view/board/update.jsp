<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri = "http://java.sun.com/jsp/jstl/functions"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<!-- Bootstrap FileStyle -->
<script type="text/javascript" src="js/bootstrap-filestyle.min.js"></script>
<title>Relay: 게시글 수정</title>
<script>
$(document).ready(function() {
	
	$('#clear').click(function(e) {
		e.preventDefault();
		$("#file").val("");
		$("#preview-div").hide();
	});
	
	$(document).on('change', '.btn-file :file', function() {
		var input = $(this),
			label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
		input.trigger('fileselect', [label]);
		});

		$('.btn-file :file').on('fileselect', function(event, label) {
		    
		    var input = $(this).parents('.input-group').find(':text'),
		        log = label;
		    
		    if( input.length ) {
		        input.val(log);
		    } else {
		        if( log ) alert(log);
		    }
	    
		});
	
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        
	        reader.onload = function (e) {
	            $('#preview').attr('src', e.target.result);
	        }
	        
	        reader.readAsDataURL(input.files[0]);
	    }
	}

	$("#file").change(function(){
	    jQuery("#preview-div").show();
	    
	    readURL(this);
	});
	
});
function onError(img){
	jQuery("#preview-div").hide();
	
}
</script>
<link rel="stylesheet" href="/Relay/css/update.css">
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
			<form name="form" id="form" method="post"
				action="boardUpdate.do" enctype="multipart/form-data">
				<div class="mb-3">
					<label for="tag">말머리</label>
					<select class="form-control" name="btag" id="btag" style="width: 200px;">
					 <c:if test="${vo.btag == '자랑해요'}">
					  <option selected="${vo.btag}">${vo.btag}</option>
					  <option value="건의해요">건의해요</option>
					  <option value="후기">후기</option>
					  <option value="질문해요">질문해요</option>
					 </c:if>
					 <c:if test="${vo.btag == '건의해요'}">
					  <option selected="${vo.btag}">${vo.btag}</option>
					  <option value="자랑해요">자랑해요</option>
					  <option value="후기">후기</option>
					  <option value="질문해요">질문해요</option>
					 </c:if>
					 <c:if test="${vo.btag == '후기'}">
					  <option selected="${vo.btag}">${vo.btag}</option>
					  <option value="자랑해요">자랑해요</option>
					  <option value="건의해요">건의해요</option>
					  <option value="질문해요">질문해요</option>
					 </c:if>
					 <c:if test="${vo.btag == '질문해요'}">
					  <option selected="${vo.btag}">${vo.btag}</option>
					  <option value="자랑해요">자랑해요</option>
					  <option value="건의해요">건의해요</option>
					  <option value="후기">후기</option>
					 </c:if>
					</select>
				</div>
				<div class="mb-3">
					<label for="title">제목</label> <input type="text"
						class="form-control" name="btitle" id="btitle" value="${vo.btitle}"
						placeholder="제목을 입력해 주세요">
				</div>
				<div class="mb-3">
					<label for="reg_id">작성자</label> <input type="text"
						class="form-control" name="mno" id="mno" value="${vo.nick}"
						placeholder="이름을 입력해 주세요" readonly="readonly">
				</div>
				<div class="mb-3">
					<label for="content">내용</label>
					<c:set var="bcontent" value="${vo.bcontent}"/>
					<textarea class="form-control" rows="5" name="bcontent" id="bcontent">${fn:trim(bcontent)}</textarea>
				</div>
				<div class="mb-3">
					<div class="input-group">
						<div class="card mr-2" id="preview-div">
							<img id="preview" src="image/${vo.bimg}" alt="your image preview" onerror="onError(this)"/>
							<button id="clear" class="btn btn-outline-primary">
						    	<!-- <i class="fa fa-ban"></i> -->
						    	미리보기 닫기
						    </button>
						</div>
						<div class="custom-file">
						    <input class="filestyle" type="file" id="file" name="file" data-btnClass="btn-primary" data-text="파일 선택">
						    <!-- <label class="custom-file-label" for="file">이미지 파일 선택</label> -->
						</div>
					</div>
				</div>
				<div align="right">
				<input type="hidden" name="bno" value="${vo.bno}">
				<input type="submit" class="btn btn-primary" value="수정">
				<a href="boardList.do" class="btn btn-primary">목록</a>
				</div>
			</form>
			<div>
			</div>
		</div>
	</article>
	<div class="footer">
	<%@ include file="/pages/include/footer.jsp"%>
	</div>
</body>
</html>
