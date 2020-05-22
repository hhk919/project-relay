<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script type="text/javascript">
	var $h = jQuery.noConflict();
	$h(document).ready(function(){
	 getTotal();
	 getUnreadCount();
	 getWeather();
	 searchview();
	});
	 
	function getTotal(){
		var id = '<c:out value="${id}"/>';
		$h.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/wishlist/cnt.do?id="+id,
			success : function(result){
				$h("#wishlistcnt").html(result);
	        }
	    });
	}
	 
	function getUnreadCount(){
		var mno = '<c:out value="${vo1.mno}"/>';
		$h.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/message/getUnreadCount.do?mno="+mno,
			success : function(result){
				if(result == 0){
					$h("#unread").html("");
				}else{
					$h("#unread").html(result);
				}
	        },
	    });
	}
	
	function popupWindow(url, title, win, w, h) {
	    const y = win.top.outerHeight/2 + win.top.screenY - (h/2);
	    const x = win.top.outerWidth/2 + win.top.screenX - (w/2);
	    return win.open(url, title, 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no, copyhistory=no, width='+w+', height='+h+', top='+y+', left='+x);
	}
	
	function getWeather(){
		  $h.ajax({
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
					$h("#weather").html(output);
		        }
		  });
	  }
	
	function searchview(){
		$h("#searchbtn").click(function (event) {
			$h(".header_area").hide();
			$h("#searchview").show();
			$h("#searchword").focus();
			$h("#searchword").focusout(function(){
				$h(".header_area").show();
				$h("#searchview").hide();
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
              <li class="nav-item"><a class="nav-link" href="/Relay/boardList.do" title="게시판">Board</a></li>
              <!--<li class="nav-item"><a class="nav-link" href="/Relay/pages/product/recommend.jsp" title="상품 추천">Recommend</a></li>-->
            </ul>

            <ul class="nav-shop">
              <li class="nav-item submenu dropdown">
				<button title="상품 검색" data-toggle="dropdown" role="button" aria-haspopup="true"
				    aria-expanded="false" id="searchbtn"><i class="ti-search"></i></button>
				</li>
              <li class="nav-item"><a href="/Relay/wishlist.do?id=${id}"><button title="위시리스트"><i class="ti-heart"></i><span class="nav-shop__circle" id="wishlistcnt"></span></button></a></li>
              <li class="nav-item"><a href="#" onClick="popupWindow('/Relay/pages/message/inbox.jsp', 'Message', window, 760, 630)"><button title="메시지"><i class="ti-email"></i><span class="nav-shop__circle" id="unread"></span></button></a></li>
              <li class="nav-item"><a href="/Relay/memberRead.do"><button title="회원정보"><i class="ti-user"></i></button></a></li>
              <li class="nav-item"><a href="/Relay/pages/relay/main.jsp"><button title="릴레이"><i class="ti-medall"></i></button></a></li>
              <li class="nav-item"><a href="/Relay/memberlogout.do"><button title="로그아웃">Logout</button></a></li>
              <li class="nav-item">
	              <div class="dropdown" id="weather">
	              </div>
              </li>
              <c:if test="${vo1.getMno() eq 1}">
				<li class="nav-item"><a class="nav-link" href="/Relay/pages/admin/adminindex.jsp" target="_blank"><button title="관리자 페이지">Admin</button></a></li>
			  </c:if>
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