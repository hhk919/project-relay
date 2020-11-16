<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="/Relay/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/Relay/vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="/Relay/vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="/Relay/vendors/nice-select/nice-select.css">
<link rel="stylesheet" href="/Relay/vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet" href="/Relay/vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="/Relay/css/style.css">
<link rel="stylesheet" href="/Relay/css/header.css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	var $j = jQuery.noConflict();
	
	$j(document).ready(function() {
		getWeather();
		searchview();
	});
	
	function getWeather(){
		$j.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/weather.do",
			success : function(result){
				output = "";
				var today = new Date();
				var mm = String(today.getMonth() + 1).padStart(2, '0');
				var dd = String(today.getDate()).padStart(2, '0');
		        output += result.temp+"&#8451;&nbsp;&nbsp;<i class='fas fa-temperature-high'></i>";
		        output += "<div class='dropdown-content' style='right: 0; left: auto;'>";
				output += "<p>오늘 ("+mm+"월 "+dd+"일) "+result.hour+"시 서울 온도 예보</p>";
				output += "<p>날씨 : "+result.wfKor+"</p>";
				output += "<p>온도 : "+result.temp+"&#8451;</p>";
				if(result.tmx == -999){
					output += "<p>최고온도 : 정보 없음</p>";
				}
				if(result.tmx != -999){
					output += "<p>최고온도 : "+result.tmx+"&#8451;</p>";
				}
				if(result.tmn == -999){
					output += "<p>최저온도 : 정보 없음</p>";
				}
				if(result.tmn != -999){
					output += "<p>최저온도 : "+result.tmn+"&#8451;</p>";
				}
				output += "</div>";
				$j("#weather").html(output);
			}
		});
	}
	
	function searchview(){
		$j("#searchbtn").click(function (event) {
			$j(".header_area").hide();
			$j("#searchview").show();
			$j("#searchword").focus();
			$j("#searchword").focusout(function(){
				$j(".header_area").show();
				$j("#searchview").hide();
			});
		});
	}
</script>
</head>
<header class="header_area">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
          <a class="navbar-brand logo_h" href="/Relay/index.jsp"><!-- <img src="img/logo.png" alt=""> -->RELAY.DO</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
            <ul class="nav navbar-nav menu_nav ml-auto mr-auto">
              <!-- <li class="nav-item"><a class="nav-link" href="/Relay/pages/product/recommend.jsp" title="상품 추천">Recommend</a></li>-->
            </ul>
            <ul class="nav-shop">
				<li class="nav-item submenu dropdown">
					<button title="상품 검색" data-toggle="dropdown" role="button" aria-haspopup="true"
				    aria-expanded="false" id="searchbtn"><i class="ti-search"></i></button>
				</li>
				<li class="nav-item"><a href="/Relay/boardList.do"><button title="게시판"><i class="ti-clipboard"></i></button></a></li>
            	<li class="nav-item"><a class="nav-link" href="/Relay/pages/login/login.jsp"><button title="로그인">Login</button></a></li>
	            <li class="nav-item"><a class="nav-link" href="/Relay/pages/member/memberinsert.jsp"><button title="회원가입">Join</button></a></li>
	            <li class="nav-item">
	            	<div class="dropdown" id="weather"></div>
              	</li>
            </ul>
          </div>
        </div>
      </nav>
    </div>
  </header>
  
  <header class="header_area" id="searchview">
    <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container">
          <a class="navbar-brand logo_h" href="/Relay/index.jsp"><!-- <img src="img/logo.png" alt=""> -->RELAY.DO</a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <div class="collapse navbar-collapse offset" id="navbarSupportedContent">
			<form class="form-inline mx-auto" action="/Relay/apisearch.do" method="get" autocomplete="off">
			    <i class="ti-search"></i>
			    <input class="form-control mr-2" name="word" id="searchword" type="search" placeholder="Search relay.do" aria-label="Search">
			    <input type="hidden" name="start" value = 1>
			  </form>
          </div>
        </div>
      </nav>
    </div>
  </header>