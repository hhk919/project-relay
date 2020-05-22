<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
	integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
	crossorigin="anonymous"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<style type="text/css">
body {
	background-color: #f7f8f9;
}

.card {
	background-color: #ffffff;
	border: 1px solid rgba(0, 34, 51, 0.1);
	box-shadow: 2px 4px 10px 0 rgba(0, 34, 51, 0.05), 2px 4px 10px 0
		rgba(0, 34, 51, 0.05);
	border-radius: 0.15rem;
	width: 300px;
}

/* Tabs Card */
.tab-card {
	border: 1px solid #eee;
}

.tab-card-header {
	background: none;
}
/* Default mode */
.tab-card-header>.nav-tabs {
	border: none;
	margin: 0px;
}

.tab-card-header>.nav-tabs>li {
	margin-right: 2px;
}

.tab-card-header>.nav-tabs>li>a {
	border: 0;
	border-bottom: 2px solid transparent;
	margin-right: 0;
	color: #737373;
	padding: 2px 15px;
}

.tab-card-header>.nav-tabs>li>a.show {
	border-bottom: 2px solid #007bff;
	color: #007bff;
}

.tab-card-header>.nav-tabs>li>a:hover {
	color: #007bff;
}

.tab-card-header>.tab-content {
	padding-bottom: 0;
}

a {
	text-decoration: none;
}

a:hover {
	color: #343A40;
	text-decoration: none;
	cursor: pointer;
}

i {
	cursor: pointer;
}
</style>
<script type="text/javascript">
	$(function() {
		$("#notice_close").click(function() {
			$("#brandnewNotice").hide();
		});
	});
</script>
</head>
<body>
	<c:forEach items="${list}" var="notice">
		<div class="container mt-5 mr-5" id="brandnewNotice">
			<div class="row">
				<div class="col-6">
					<div class="card card-outline-danger">
						<span class="pull-right clickable close-icon p-2" data-effect="fadeOut">
							공지사항 <i id="notice_close" class="float-right fas fa-times-circle p-1"></i>
						</span>
						<div class="card-block mt-2 px-4">
							<blockquote class="card-blockquote">
								<h5 class="card-title">
									<a href="noticeRead.do?nno=${notice.nno}">${notice.ntitle}</a>
								</h5>
								<p class="card-text">${notice.ncontent}</p>

								<footer>
									<p class="card-text text-right mr-3">
										<fmt:formatDate pattern="yyyy.MM.dd" value="${notice.ndate}" />
									</p>
								</footer>
							</blockquote>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>
</body>
</html>