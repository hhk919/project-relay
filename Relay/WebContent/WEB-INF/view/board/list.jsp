<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 게시판</title>

<link rel="stylesheet" href="/Relay/css/all.css">
<link rel="stylesheet" href="/Relay/css/list.css">

<!-- 부트스트랩 4.3.1 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- jQuery 3.2.1 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

<!-- 부트스트랩 4.3.1 JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<script type="text/javascript">
	var $c = jQuery.noConflict();
	
	$c(document).ready(function() {
		getTotal();
		
		$c(function () {
			  $c('[data-toggle="popover"]').popover({
			  })
			});
		
		$c('.popover-dismiss').popover({
			  trigger: 'focus'
			});
			
		var actionForm = $c("#actionForm");
		$c(".page-item a").on("click", function(e) {
			e.preventDefault();
			actionForm.find("input[name='pageNum']").val($c(this).attr("href"));
			actionForm.submit();
		});
		
		var searchForm = $c("#searchForm");
		$c("#searchForm button").on("click",function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택하세요");
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 입력하세요");
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
	});
	
	function getPost(bno){
		var mno = '<c:out value="${vo1.mno}"/>';
		if($c.isEmptyObject(mno)){
			location.href="/Relay/pages/login/login.jsp";
		}else{
			location.href="boardRead.do?bno="+bno;			
		}
	}
	
	function getTotal(){
		var mno = '<c:out value="${vo1.mno}"/>';
		$c.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/wishlist/cnt.do?mno="+mno,
			success : function(result){
				$c("#wishlistcnt").html(result);
	        }
	    });
	}
	
	function popupWindow(url, title, win, w, h) {
	    const y = win.top.outerHeight/2 + win.top.screenY - (h/2);
	    const x = win.top.outerWidth/2 + win.top.screenX - (w/2);
	    return win.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+y+', left='+x);
	}
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
		<div class="container" id="board">
			<div class="table-responsive">
				<table class="table table-hover table-sm">
					<colgroup>
						<col style="width: 5%;" />
						<col style="width: 10%;" />
						<col style="width: auto;" />
						<col style="width: 15%;" />
						<col style="width: 10%;" />
						<col style="width: 10%;" />
					</colgroup>
					<thead align="center">
						<tr style="font-size: 14px">
							<th>NO</th>
							<th>말머리</th>
							<th>제목</th>
							<th>작성자</th>
							<th>조회수</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody class="body">
						<c:forEach items="${list_notice}" var="notice">
							<tr style="background-color: #F9F9F8;">
								<td align="center">${notice.nno}</td>
								<td align="center" style="color: #6D7072">공지사항</td>
								<td><a href="noticeRead.do?nno=${notice.nno}" style="color: #ff6f59; font-weight: bold;">${notice.ntitle}</a></td>
								<td align="center">${notice.nick}</td>
								<td align="center" style="font-weight: normal;">${notice.ncnt}</td>
								<td align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${notice.ndate}" /></td>
							</tr>
						</c:forEach>
						<c:forEach items="${list}" var="board">
							<tr>
								<td align="center">${board.bno}</td>
								<td align="center">
								<a tabindex="0" role="button" 
									data-toggle="popover" 
									data-trigger="focus" 
									data-content="<a href='/Relay/boardListForTag.do?btag=${board.btag}'>말머리 검색</a>"
									data-html="true"
									style="color: black">
									${board.btag}</a>
								</td>
								<td>
								<a href="#" onclick="getPost(${board.bno})">${board.btitle}</a><c:if test="${board.breplycnt ne 0}"><span class="" style="color: #ff6f59; font-size: 14px;"><strong> [${board.breplycnt}]</strong></span></c:if></td>
								<td align="center">
								<c:if test="${vo1.mno eq null}">
								<a id="poplink" tabindex="0" role="button" 
									data-toggle="popover" 
									data-trigger="focus" 
									data-content="<a href='/Relay/boardListForMember.do?nick=${board.nick}'>작성글 검색</a>"
									data-html="true"
									style="color: black">
									${board.nick}</a>
								</c:if>
								<c:if test="${vo1.mno ne null}">
									<a id="poplink" tabindex="0" role="button" 
									data-toggle="popover" 
									data-trigger="focus" 
									data-content="<ul><li><a href='/Relay/boardListForMember.do?nick=${board.nick}'>작성글 검색</a></li>
									<%-- <li><a href='/Relay/pages/message/compose.jsp?nick=${board.nick}'>쪽지 보내기</a></li> --%></ul>"
									data-html="true"
									style="color: black">
									${board.nick}</a>
								</c:if>
								</td>
								<td align="center">${board.bcnt}</td>
								<td align="center"><fmt:formatDate pattern="yyyy-MM-dd" value="${board.bdate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			<table class="container">
				<tr><th colspan="3"></th></tr>
				<tr>
					<td style="padding-top: 1px" colspan="2" align="center">
						<nav aria-label="Page navigation example">
							<ul class="pagination justify-content-center">
								<c:if test="${pageMaker.prev}">
									<li class="page-item"><a class="page-link" href="${pageMaker.startPage-1}"><i class="fas fa-angle-double-left"></i></a></li>
								</c:if>
								<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
									<li class="page-item ${pageMaker.cri.pageNum == num ? "active":""} "><a class="page-link" href="${num}">${num}</a></li>
								</c:forEach>
								<c:if test="${pageMaker.next}">
									<li class="page-item"><a class="page-link" href="${pageMaker.endPage+1}"><i class="fas fa-angle-double-right"></i></a></li>
								</c:if>
							</ul>
							<form id="actionForm" action="boardList.do" method="get">
								<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
								<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
								<input type="hidden" name="type" value="<c:out value="${ pageMaker.cri.type }"/>">
								<input type="hidden" name="keyword" value="<c:out value="${ pageMaker.cri.keyword }"/>">
								<!--  <input type='hidden' name='offset' value="<c:out value="${ (pageMaker.cri.pageNum-1)*pageMaker.cri.amount }"/>">-->
							</form>
						</nav>
					</td>
				</tr>
				<tr>
					<td align="right">
						<a href="boardWrite.do" class="btn btn-primary pull right">글쓰기</a>
						<a href="boardList.do" class="btn btn-primary">목록</a>
					</td>
				</tr>
			</table>
				<div class="form-inline justify-content-center">
					<form action="boardList.do" method="get" id="searchForm">
						<select name="type" class="custom-select" style="width: auto;">
							<option value="" <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option>
							<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
							<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
							<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>>작성자</option>
							<option value="H" <c:out value="${pageMaker.cri.type eq 'H'?'selected':''}"/>>말머리</option>
							<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목 or 내용</option>
							<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>>제목 or 작성자</option>
							<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':''}"/>>제목 or 내용 or 작성자</option>
						</select>
						<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword}"/>' style="padding-bottom: 6px; width: 226px" class="form-control"/>
						<input type='hidden' name='pageNum' value='<c:out value="${pageMaker.cri.pageNum}"/>' />
						<input type='hidden' name='amount' value='<c:out value="${pageMaker.cri.amount}"/>' />
						<!-- <input type='hidden' name='offset' value='<c:out value="${ (pageMaker.cri.pageNum-1)*pageMaker.cri.amount }"/>' /> -->
						<button class="btn btn-primary pull right">검색</button>
					</form>
				</div>
			</div>
		</div>
	</article>
	<div class="footer">
	<%@ include file="/pages/include/footer.jsp"%>
	</div>
</body>
</html>