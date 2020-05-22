<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 상품 검색</title>
<link rel="stylesheet" href="/Relay/css/all.css">
<link rel="stylesheet" href="/Relay/css/product_search.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script>
    $(document).on("keyup", function (event) {
        if (event.which == 13) {
            $("#search").trigger('click');
        }
    });
    function submit(){
    	$("#searchform").submit();
    };
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
    <div class="container h-100">
    <form id="searchform" action="/Relay/apisearch.do" method="post" autocomplete="off">
      <div class="d-flex justify-content-center h-100">
        <div class="searchbar">
       		<input class="search_input" type="text" name="word" placeholder="Search...">
       		<!-- 검색결과수 -->
       		<input type="hidden" name="display" value = 10>
			<!-- 시작위치수 -->
			<input type="hidden" name="start" value = 1>
			<!-- 정렬기준 -->
			<input type="hidden" name="sort" value = "sim">
          	<a href="#" class="search_icon" id="search" onclick='submit();'><i class="fas fa-search"></i></a>
        </div>
      </div>
     </form>
    </div>
    <div class="footer">
	<%@ include file="/pages/include/footer.jsp"%>
	</div>
 </body>
</html>