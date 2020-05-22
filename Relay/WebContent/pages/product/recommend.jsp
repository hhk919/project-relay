<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page autoFlush="true" buffer="1094kb"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 상품 추천</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<link rel="stylesheet" href="/Relay/css/all.css">
<link rel="stylesheet" href="/Relay/css/recommend.css">
<link rel="stylesheet" href="https://wowjs.uk/css/libs/animate.css">
<script src="https://wowjs.uk/dist/wow.min.js"></script>
<script>
	new WOW().init();
</script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script type="text/javascript">
	var nick = '<c:out value="${vo1.nick}"/>';
	var mno = '<c:out value="${vo1.mno}"/>';
	var age = '<c:out value="${vo1.age}"/>';
	var gender = '<c:out value="${vo1.gender}"/>';
	var hobby = '<c:out value="${vo1.hobby}"/>';
	
	$(document).ready(function(){
		loading();
		getRecommendListByWishlist();
		getRecommendListByAge();
		getRecommendListByGender();
		getRecommendListByHobby();
		getRecommendListByAgeGenderHobby();
	});
	
	function loading(){
		output = "";
		output += "<div class='text-center pt-3' id='loading'>";
		output += "<img src='/Relay/img/loader/ajax-loader1.gif'>";
		output += "&nbsp;&nbsp;<font style='color: blue; font-weight: bold'>"+nick+"</font> 회원님의 Wishlist를 통해 추천 상품을 분석 중입니다. 잠시만 기다려 주시기 바랍니다.";
		output += "</div>";
		$("#desc").append(output);
	}
	
	function getRecommendListByWishlist(){
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/recommend/getRecommendListByWishlist.do?mno=" + mno,
			success : function(result){
				if($.isEmptyObject(result)){
					$("#loading").hide();
					output = "";
					output += "<div class='col-4 mt-5' id='title'>";
					output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>Wishlist</font><font style='font-size: 1.2rem'>를 통한 </font>";
					output += "<font style='font-size: 1.4rem;'>추천 상품</font>";
					output += "<hr>";
					output += "</div>";
					output += "<div class='col-4'></div>";
					output += "<div class='col-4'></div>";
					output += "<div class='ml-4 wow bounceIn' data-wow-duration='2s'>";
					output += "<p style='color: red; font-size: 1.2rem'>Wishlist를 통해 추천을 받기 위해서는 Wishlist에 더 많은 상품을 담고 별점을 부여해주시기 바랍니다.</p>";
					output += "</div>"; 
					$("#wishlist").append(output);
				} else {
					$("#loading").hide();
					output = "";
					output += "<div class='col-4 mt-5' id='title'>";
					output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>Wishlist</font><font style='font-size: 1.2rem'>를 통한 </font>";
					output += "<font style='font-size: 1.4rem;'>추천 상품</font>";
					output += "<hr>";
					output += "</div>";
					output += "<div class='col-4'></div>";
					output += "<div class='col-4'></div>";
					for(var i in result){
						output += "<div class='col wow zoomIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
						output += "<a href='"+result[i].pmallurl+"' target='_blank'>";
						output += "<div class='card' style='width: 18rem; max-width: 183px; border: none; color: black;'>";
						output += "<img class='card-img-top ml-3 mt-2' src='"+result[i].pimg+"' alt='product image' style='max-width: 150px;'>";
						output += "<div class='card-body'>";
						output += "<p class='card-text font-weight-bold' style='font-size: 0.83rem;'>"+result[i].pname+"</p>";
						output += "<p class='card-text font-weight-bold float-right'>"+result[i].plprice+"</p>";
						output += "</div>";
						output += "</div>";
						output += "</a>";
						output += "</div>";
					}
					$("#wishlist").html(output);
				}
			},
		});
	}
	
	function getRecommendListByAge(){
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/recommend/getRecommendListByAge.do?age=" + age,
			success : function(result){
				output = "";
				output += "<div class='col-4 mt-5' id='title'>";
				output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>"+age+"대</font><font style='font-size: 1.2rem'>인 회원들의 </font>";
				output += "<font style='font-size: 1.4rem;'>선택</font>";
				output += "<hr>";
				output += "</div>";
				output += "<div class='col-4'></div>";
				output += "<div class='col-4'></div>";
				for(var i in result){
					output += "<div class='col wow zoomIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
					output += "<a href='"+result[i].pmallurl+"' target='_blank'>";
					output += "<div class='card' style='width: 18rem; max-width: 183px; border: none; color: black;'>";
					output += "<img class='card-img-top ml-3 mt-2' src='"+result[i].pimg+"' alt='product image' style='max-width: 150px;'>";
					output += "<div class='card-body'>";
					output += "<p class='card-text font-weight-bold' style='font-size: 0.83rem;'>"+result[i].pname+"</p>";
					output += "<p class='card-text font-weight-bold float-right'>"+result[i].plprice+"</p>";
					output += "</div>";
					output += "</div>";
					output += "</a>";
					output += "</div>";
				}
				$("#age").html(output);
			}
		});
	}
	
	function getRecommendListByGender(){
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/recommend/getRecommendListByGender.do?gender=" + gender,
			success : function(result){
				output = "";
				output += "<div class='col-4 mt-5' id='title'>";
				output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>"+gender+"</font><font style='font-size: 1.2rem'>인 회원들의 </font>";
				output += "<font style='font-size: 1.4rem;'>선택</font>";
				output += "<hr>";
				output += "</div>";
				output += "<div class='col-4'></div>";
				output += "<div class='col-4'></div>";
				for(var i in result){
					output += "<div class='col wow zoomIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
					output += "<a href='"+result[i].pmallurl+"' target='_blank'>";
					output += "<div class='card' style='width: 18rem; max-width: 183px; border: none; color: black;'>";
					output += "<img class='card-img-top ml-3 mt-2' src='"+result[i].pimg+"' alt='product image' style='max-width: 150px;'>";
					output += "<div class='card-body'>";
					output += "<p class='card-text font-weight-bold' style='font-size: 0.83rem;'>"+result[i].pname+"</p>";
					output += "<p class='card-text font-weight-bold float-right'>"+result[i].plprice+"</p>";
					output += "</div>";
					output += "</div>";
					output += "</a>";
					output += "</div>";
				}
				$("#gender").html(output);
			}
		});
	}
	
	function getRecommendListByHobby(){
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/recommend/getRecommendListByHobby.do?hobby=" + hobby,
			success : function(result){
				output = "";
				output += "<div class='col-4 mt-5' id='title'>";
				output += "<font style='font-size: 1.2rem'>취미가 </font><font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>"+hobby+"</font><font style='font-size: 1.2rem'>인 회원들의 </font>";
				output += "<font style='font-size: 1.4rem;'>선택</font>";
				output += "<hr>";				
				output += "</div>";
				output += "<div class='col-4'></div>";
				output += "<div class='col-4'></div>";
				for(var i in result){
					output += "<div class='col wow zoomIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
					output += "<a href='"+result[i].pmallurl+"' target='_blank'>";
					output += "<div class='card' style='width: 18rem; max-width: 183px; border: none; color: black;'>";
					output += "<img class='card-img-top ml-3 mt-2' src='"+result[i].pimg+"' alt='product image' style='max-width: 150px;'>";
					output += "<div class='card-body'>";
					output += "<p class='card-text font-weight-bold' style='font-size: 0.83rem;'>"+result[i].pname+"</p>";
					output += "<p class='card-text font-weight-bold float-right'>"+result[i].plprice+"</p>";
					output += "</div>";
					output += "</div>";
					output += "</a>";
					output += "</div>";
				}
				$("#hobby").html(output);
			}
		});
	}
	
	function getRecommendListByAgeGenderHobby(){
		$.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/recommend/getRecommendListByAgeGenderHobby.do?age=" + age + "&gender=" + gender + "&hobby=" + hobby,
			success : function(result){
				output = "";
				output += "<div class='col-5 mt-5' id='title'>";
				output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>"+age+"대</font>";
				output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'> "+gender+" </font>";
				output += "<font style='font-size: 1.2rem'>중에 취미가 </font>";
				output += "<font style='font-size: 1.6rem; color: #FF7F7F; font-weight: bold'>"+hobby+"</font>";
				output += "<font style='font-size: 1.2rem'>인 회원들의 </font>";
				output += "<font style='font-size: 1.4rem;'>선택</font>";
				output += "<hr>";
				output += "</div>";
				output += "<div class='col-4'></div>";
				output += "<div class='col-3'></div>";
				for(var i in result){
					output += "<div class='col wow zoomIn' data-wow-duration='1s' data-wow-delay='0.1s'>";
					output += "<a href='"+result[i].pmallurl+"' target='_blank'>";
					output += "<div class='card' style='width: 18rem; max-width: 183px; border: none; color: black;'>";
					output += "<img class='card-img-top ml-3 mt-2' src='"+result[i].pimg+"' alt='product image' style='max-width: 150px;'>";
					output += "<div class='card-body'>";
					output += "<p class='card-text font-weight-bold' style='font-size: 0.83rem;'>"+result[i].pname+"</p>";
					output += "<p class='card-text font-weight-bold float-right'>"+result[i].plprice+"</p>";
					output += "</div>";
					output += "</div>";
					output += "</a>";
					output += "</div>";
				}
				$("#age_gender_hobby").html(output);
			}
		});
	}
	
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
	<div class="container">
		<div class="row">
			<div class="col-4"></div>
			<div class="col-4 text-center"><h1>RECOMMEND</h1></div>
			<div class="col-4"></div>

			<div class="col-2">
			</div>
			<div class="col-8 text-left mt-3" id="desc">
				<p><b>‘Wishlist를 통한 추천’</b>은 고객님께서 담은 상품들에 매긴 평점을 기반으로 유사도가 높은 회원들을 찾아 그 회원들의 wishlist 평점을 분석하여 머신러닝을 통해 고객님께서 높게 평점을 줄 것 같은 상품들을 추천해드리는 시스템입니다.
				많은 상품을 담아 평점을 매길수록 정확한 추천이 이루어집니다.</p>
				<p><b>나이, 성별, 취미를 통한 추천</b>은 해당 분류에 속하는 회원들이 위시리스트에 많이 담은 상품을 추천해드리는 시스템입니다. 이 추천을 통해 고객님이 속해있는 집단의 트렌드를 파악할 수 있습니다.</p>
			</div>
			<div class="col-2">
			</div>
			
			<div class="row mb-5 pb-5">
			
				<div class="row" id="wishlist">
				</div>
				
				<div class="row" id="age">
				</div>
					
				<div class="row" id="gender">
				</div>
				
				<div class="row" id="hobby">
				</div>
				
				<div class="row" id="age_gender_hobby">
				</div>
				
			</div>
			
		</div>
	</div>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->
</body>
</html>