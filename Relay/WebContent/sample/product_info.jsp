<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 상품정보</title>
<!-- jQuery 3.3.1 -->
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

<!-- 부트스트랩 4.3.1 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- 부트스트랩 4.3.1 JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

<link rel="stylesheet" href="/Relay/css/join.css">
<link rel="stylesheet" href="/Relay/css/product_info.css">
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
	<div class="wrapper fadeInDown mt-4">
		<div class="card bg-light">
			<main class="mt-1 pt-1">
				<div class="container dark-grey-text mt-3">
					<h4>상품 상세정보</h4>
					<hr>
					<!--Grid row-->
					<div class="row wow fadeIn">
					
				        <!--Grid column-->
				        <div class="col-md-6 mb-4">
	          				<img src="/Relay/image/sample1.jpg" class="img-thumbnail" alt="">
	        			</div>
	        			<!--Grid column-->
	
	        			<!--Grid column-->
	        			<div class="col-md-6 mb-4">
	
							<!--Content-->
							<div class="p-1">
								<div class="mb-3">
					              <!-- <a href="">
					                <span class="badge purple mr-1">Category 2</span>
					              </a>
					              <a href="">
					                <span class="badge blue mr-1">New</span>
					              </a>
					              <a href="">
					                <span class="badge red mr-1">Bestseller</span>
					              </a> -->
								</div>
								<p class="lead font-weight-bold" style="font-size: 32px; color: #343A40"><a href="#">롱패딩</a></p>
								<div style="font-size: 22px;">
									<span class="badge purple mr-1">
										최저가  &#8361;99,000
									</span>
		            				<br>
		           					<span class="badge purple mr-1">
		           						최고가  &#8361;129,000
		           					</span>
		           				</div>
		            			<hr>
		            			<div class="single-product-wishlist">
			            			<a class="add-to-cart action-wishlist wishlist" href="#" title="Wishlist"><i class="fa fa-heart"></i></a>
			        			</div>
	          				</div>
	          				<!--Content-->
				        </div>
	        			<!--Grid column-->
					</div>
					<!--Grid row-->
				</div>
			</main>
			<!--Main layout-->
		</div>
	</div>
</body>
</html>