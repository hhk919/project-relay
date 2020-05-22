<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="relay.vo.member.MemberVO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: WISHLIST</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css"
	integrity="sha384-GJzZqFGwb1QTTN6wy59ffF1BuGJpLSa9DkKMp0DgiMDm4iYMj70gZWKYbI706tWS"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
<link rel="stylesheet" href="/Relay/css/wishlist_list.css">
<link rel="stylesheet" href="https://wowjs.uk/css/libs/animate.css">
<script src="https://wowjs.uk/dist/wow.min.js"></script>
<script>
	new WOW().init();
</script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		getWishlist();
	});
	
	function getRating(result){
		for(var i in result){
			var pid = result[i].pid;
			var grade = result[i].grade;
			for (i = 1; i <= grade; ++i) {
				$("#rating-ability-wrapper"+pid+ " #rating-star-"+i).toggleClass('btn-warning');
				$("#rating-ability-wrapper"+pid+ " #rating-star-"+i).toggleClass('btn-default');
			}
		}
	}
	
	function rating(npid){
		var pid = npid.toString().substring(2);
		var previous_value = $("#selected_rating"+pid).val();
		
		var selected_value = $(".btnrating"+npid).attr("data-attr");
		$("#selected_rating"+pid).val(selected_value);
		
		$(".selected-rating"+pid).empty();
		$(".selected-rating"+pid).html(selected_value);
		
		for (i = 1; i <= selected_value; ++i) {
			$("#rating-ability-wrapper"+pid+ " #rating-star-"+i).toggleClass('btn-warning');
			$("#rating-ability-wrapper"+pid+ " #rating-star-"+i).toggleClass('btn-default');
		}
		
		for (ix = 1; ix <= previous_value; ++ix) {
			$("#rating-ability-wrapper"+pid+ " #rating-star-"+ix).toggleClass('btn-warning');
			$("#rating-ability-wrapper"+pid+ " #rating-star-"+ix).toggleClass('btn-default');
		}
		
		updateGrade(pid, selected_value);
	}
	
	function updateGrade(pid, selected_value){
		var id = '<c:out value="${id}"/>';
		$.ajax({
			type : 'put',
			url : '/Relay/wishlist/updateGrade.do?pid=' + pid + '&id=' + id + '&grade=' + selected_value,
			contentType : "application/json; charset=UTF-8",
			success : function(){
				
			},
		})
		
	}

	function deleteWishlist(pid) {
		var id = '<c:out value="${id}"/>';
		$.ajax({
			type : 'put',
			url : '/Relay/wishlist/delete.do?pid=' + pid + '&id=' + id,
			success : function() {
				getWishlist();
				getTotal();
			},
		})
	}

	function getWishlist() {
		var id = '<c:out value="${id}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/wishlist/list.do?id=" + id,
			success : function(result) {
				var output = "";
				if ($.isEmptyObject(result)) {
					output += "<h4>위시리스트가 비어 있습니다.</h4>";
					$("#empty").html(output);
					$("#wishlist").html("");
				} else {
					for (var i in result) {
						output += "<div class='col-sm-6 col-md-3 wow zoomIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
						output += "<div class='card mb-3'>";
						output += "<a href='"+result[i].pmallurl+"' target='_blank' title='상품페이지로 이동'><img class='card-img-top img-fluid' src='"+result[i].pimg+"' alt='product image'></a>";
						output += "<div class='card-body'>";
						output += "<p class='card-text font-weight-bold' style='font-size:0.9rem'>"
								+ result[i].pname + "</p>";
						output += "<div class='form-group' id='rating-ability-wrapper"+result[i].pid+"' title='별점'>";
						output += "<label class='control-label' for='rating'>";
						output += "<input type='hidden' id='selected_rating"+result[i].pid+"' name='selected_rating' value='"+result[i].grade+"' required='required'>";
						output += "</label>";
						//output += "<h2 class='bold rating-header' style=''>";
						//output += "<span class='selected-rating"+result[i].pid+"'>"+result[i].grade+"</span><small> / 5</small>";
						//output += "</h2>";
						output += "<button type='button' class='btnrating11"+result[i].pid+" btn btn-default btn-sm' data-attr='1' id='rating-star-1' onclick='rating(11"+result[i].pid+")'>";
						output += "<i class='fa fa-star' aria-hidden='true'></i>";
						output += "</button>";
						output += "<button type='button' class='btnrating22"+result[i].pid+" btn btn-default btn-sm' data-attr='2' id='rating-star-2' onclick='rating(22"+result[i].pid+")'>";
						output += "<i class='fa fa-star' aria-hidden='true'></i>";
						output += "</button>";
						output += "<button type='button' class='btnrating33"+result[i].pid+" btn btn-default btn-sm' data-attr='3' id='rating-star-3' onclick='rating(33"+result[i].pid+")'>";
						output += "<i class='fa fa-star' aria-hidden='true'></i>";
						output += "</button>";
						output += "<button type='button' class='btnrating44"+result[i].pid+" btn btn-default btn-sm' data-attr='4' id='rating-star-4' onclick='rating(44"+result[i].pid+")'>";
						output += "<i class='fa fa-star' aria-hidden='true'></i>";
						output += "</button>";
						output += "<button type='button' class='btnrating55"+result[i].pid+" btn btn-default btn-sm' data-attr='5' id='rating-star-5' onclick='rating(55"+result[i].pid+")'>";
						output += "<i class='fa fa-star' aria-hidden='true'></i>";
						output += "</button>";
						output += "</div>";
						output += "<div title='상품 구매자들의 리뷰를 분석하여 추출한 리뷰 토픽'>";
						if (result[i].tags != null){
							output += tags(result[i].tags);
						}
						output += "</div>";
						output += "</div>";
						output += "<div class='card-footer text-muted text-center' style='padding:3px'><button class='btn btn-primary-outline btn-sm' onclick='deleteWishlist("+ result[i].pid+ ")'>REMOVE</button></div>";
						output += "</div>";
						output += "</div>";
						$("#wishlist").html(output);
					}
					getRating(result);
				}
			}
		});
	}
	
	function tags(tags){
		var tag = [];
		tag = tags.split(" ");
		output = "";
		for(var i = 0; i < tag.length; i++){
			output += "<button class='btn btn-outline-info btn-sm m-1' style='font-size:0.75rem'>"+tag[i]+"</button>";
		}
		return output;
	}
	
	function getTotal() {
		var id = '<c:out value="${id}"/>';
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/wishlist/cnt.do?id=" + id,
			success : function(result) {
				$("#wishlistcnt").html(result);
			}
		});
	}
	
</script>
<%
	if (session.getAttribute("vo1") == null) {
%>
<jsp:forward page="/pages/login/login.jsp" />
<%
	} else {
%>
<%@ include file="/pages/include/header_afterlogin.jsp"%>
<%
	}
%>
</head>
<body>
	<div class="container mt-2">
		<div class="text-center">
			<ul>
				<li><h1>WISHLIST</h1></li>
			</ul>
			<br>
			<div id="empty"></div>
		</div>
		<br>
		<div class="row mb-5 pb-5" id="wishlist">
		</div>
	</div>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->
</body>
</html>