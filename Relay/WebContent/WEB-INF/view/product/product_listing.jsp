<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 상품 리스트</title>
<link rel="stylesheet" href="/Relay/css/product_listing.css">

<!-- 부트스트랩 4.3.1 CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

<!-- jQuery 3.2.1 -->
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Popper JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>

<!-- 부트스트랩 4.3.1 JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script type="text/javascript">
	var $p = jQuery.noConflict();
	$p(document).ready(function() {
		getWishlist();
		$p(function () {
			  $p('[data-toggle="tooltip"]').tooltip()
		});
	});
	<!--선택한 상품을 wishlist에 추가-->
	function insertWishlist(pid, pname, phprice, plprice, pmall, pmallurl, pimg, brand, cat){
		var id = '<c:out value="${id}"/>';
		var member = '<c:out value="${vo1}"/>';
		if($p.isEmptyObject(id)){
			alert("로그인이 필요합니다.");
		}else{
			$p.ajax({
				type : 'post',
				url : '/Relay/wishlist/insert.do',
				dataType: "text",
				data : JSON.stringify({
					pid : pid,
					pname : pname,
					phprice : phprice,
					plprice : plprice,
					pmall : pmall,
					pmallurl : pmallurl,
					pimg : pimg,
					brand : brand,
					cat : cat,
					grade : 0
				}),
				contentType : "application/json; charset=UTF-8",
				success : function() {
					$p("#wishlistbutton"+pid).html("ADDED TO WISHLIST");
					$p("#wishlistbutton"+pid).prop('disabled', true);
					getTotal();
				}, error : function() {
					alert("잠시 후 다시 시도해주세요");
				}
			})
		}
	}
	<!--user의 wishlist 정보 가져오기-->
	function getWishlist() {
		var id = '<c:out value="${id}"/>';
		$p.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/wishlist/list.do?id=" + id,
			success : function(result) {
				for (var i in result){
					$p("#wishlistbutton"+result[i].pid).html("ADDED TO WISHLIST");
					$p("#wishlistbutton"+result[i].pid).prop('disabled', true);
				}
			}
		});
	}
	
	function redirect(mallurl){
		$p.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/redirectURL.do?url="+mallurl,
	    });
	}
	
	<!--user가 참여하고 있는 relay의 기본정보(번호, 받는이)-->
	function getInfo(pid){
		var id = '<c:out value="${id}"/>';
		if($p.isEmptyObject(id)){
			alert("로그인이 필요합니다.");
		}else{
			$p.ajax({
				type : "get",
				dataType : "json",
				url : "/Relay/relay/getInfo.do?id=" + id,
				success : function(result){
					if($p.isEmptyObject(result)){
						alert("진행중인 릴레이가 없습니다.");
					}
					else{
						output = "";
						for(var i in result){					
							output += "<option value='"+result[i].listId+"'>"+result[i].recipient+"</option>";
							$p("#getRelay").show();
						}
						$p("#getRelay"+pid).append(output);
						$p("#getRelay"+pid).show();
						$p("#add"+pid).show();
					}
				},
			});
		}
	}
	<!--user가 참여하고 있는 relay에 상품 추가(update)-->
	function updateGift(pid, pname, phprice, plprice, pmall, pmallurl, pimg, brand, cat){
		var listId = $p("#getRelay"+pid).val();
		var id = '<c:out value="${id}"/>';
		if($p.isEmptyObject(id)){
			alert("로그인이 필요합니다.");
		}else{
			$p.ajax({
				type : 'post',
				url : '/Relay/relay/updateGift.do',
				dataType: "text",
				data : JSON.stringify({
					listId : listId,
					memberId : id,
					pid : pid,
					pname : pname,
					phprice : phprice,
					plprice : plprice,
					pmall : pmall,
					pmallurl : pmallurl,
					pimg : pimg,
					brand : brand,
					cat : cat
				}),
				contentType : "application/json; charset=UTF-8",
				success : function() {
					$p("#relaybutton"+pid).html("ADDED TO RELAY");
					$p("#relaybutton"+pid).prop("disabled",true);
					$p("#add"+pid).prop('disabled', true);
					$p("#getRelay"+pid).hide();
					$p("#getRelay"+pid).prop("disabled",true);
					$p("#add"+pid).hide();
					$p("#add"+pid).prop("disabled",true);
				}, error : function() {
					alert("추가 실패");
				}
			})
		}
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
<div class="container mb-5 pb-5">

  <div class="row mt-3 pt-3">
    <div class="col-lg-8 mx-auto">

		<!-- 상품 리스트 -->
		<ul class="list-group">
		
	      	<!-- 검색 결과가 있는 경우 -->
			<c:if test="${!empty list}">
				<c:forEach items="${list}" var="list">
			        <li class="list-group-item">
			        	<div class="media align-items-lg-center flex-column flex-lg-row p-3">
			        	<div class="productimg">
			        	<img src="${list.image}" alt="Generic placeholder image" width="200" class="rounded mr-lg-5 order-1 order-lg-1">
			        	</div>
			        		<div class="media-body order-2 order-lg-2">
			            		<h5 class="mt-0 font-weight-bold mb-2"><a href="${list.link}" target="_blank" onclick="redirect('${list.link}')">${list.title}</a></h5>
			              		<c:if test="${list.hprice ne list.lprice && list.hprice ne '0'}">
				              		<div class="d-flex align-items-center justify-content-between mt-1">
				                		<h6 class="font-weight-bold my-2">최저가  <fmt:formatNumber type="currency" value="${list.lprice}" /></h6>
				              		</div>
				              		<div class="d-flex align-items-center justify-content-between mt-1">
				              			<h6 class="font-weight-bold my-2">최고가  <fmt:formatNumber type="currency" value="${list.hprice}" /></h6>
									</div>
								</c:if>
			              		<c:if test="${list.hprice eq list.lprice || list.hprice eq '0'}">
				              		<div class="d-flex align-items-center justify-content-between mt-1">
				              			<h6 class="font-weight-bold my-2">가격  <fmt:formatNumber type="currency" value="${list.lprice}" /></h6>
									</div>
								</c:if>
								<div class="d-flex align-items-center justify-content-between mt-1">
									<h6 class="font-weight-bold my-2">${list.brand}</h6>
								</div>
								<div class="d-flex align-items-center justify-content-between mt-1">
									<h6 class="font-weight-bold my-2">${list.cat}</h6>
								</div>
								<div class="float-right">
									<div class="d-flex align-items-center justify-content-between mt-3">
										<button id="wishlistbutton${list.productId}" class="btn btn-light btn-sm" onclick="insertWishlist('${list.productId}','${list.title}','${list.hprice}','${list.lprice}','${list.mallName}','${list.link}','${list.image}','${list.cat}')">
											ADD TO WISHLIST
										</button>
										<button id="relaybutton${list.productId}" class="btn btn-light btn-sm ml-2" onclick="getInfo('${list.productId}')">
											ADD TO RELAY
										</button>
										<select class="form-control form-control-sm ml-2" id="getRelay${list.productId}" style="display: none;">
										</select>
										<button class="btn btn-primary btn-sm ml-1" id="add${list.productId}" onclick="updateGift('${list.productId}','${list.title}','${list.hprice}','${list.lprice}','${list.mallName}','${list.link}','${list.image}','${list.cat}')" style="display: none;">ADD</button>
									</div>
								</div>
			            	</div>
			          </div>
			        </li>
		        </c:forEach>
			</c:if>
			
			<!-- 검색 결과가 없는 경우 -->
		    <c:if test="${empty list}">
		        <li class="list-group-item">
		          <div class="media align-items-lg-center flex-column flex-lg-row p-3">
		            <div class="media-body order-2 order-lg-1 text-center">
		              <h5 class="mt-0 font-weight-bold mb-2">해당 검색어에 대한 검색 결과가 없습니다</h5>
		          	<br>
		          	<button class="btn btn-default btn-link btn-lg" disabled="disabled"><i class="far fa-meh-rolling-eyes fa-2x"></i></button>
		          	</div>
		          </div>
		        </li>
		    </c:if>
		    
      </ul>
      
      <a href="javascript:history.back()">
      	<button class="btn btn-primary pull right mt-3">돌아가기</button>
      </a>
       <c:if test = "${start<1000}">
      <button type="submit" class="btn btn-primary float-right mt-3" onclick="location.href='apisearch.do?word=${word}&start=${start}'" value="다음검색">
      	다음검색
      </button>
      </c:if>
    </div>
  </div>
</div>
<!--================ Start footer Area  =================-->	
<%@ include file="/pages/include/footer.jsp"%>
<!--================ End footer Area  =================-->
</body>
</html>