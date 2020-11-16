<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>RELAY.DO</title>
<link rel="stylesheet" href="https://wowjs.uk/css/libs/animate.css">
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
<script src="https://wowjs.uk/dist/wow.min.js"></script>
<script>
	new WOW().init();
</script>
<script src="/Relay/vendors/jquery/jquery-3.2.1.min.js"></script>
<script src="/Relay/vendors/bootstrap/bootstrap.bundle.min.js"></script>
<script src="/Relay/vendors/skrollr.min.js"></script>
<script src="/Relay/vendors/owl-carousel/owl.carousel.min.js"></script>
<script src="/Relay/vendors/nice-select/jquery.nice-select.min.js"></script>
<script src="/Relay/vendors/jquery.ajaxchimp.min.js"></script>
<script src="/Relay/vendors/mail-script.js"></script>
<script src="/Relay/js/main.js"></script>
<script type="text/javascript">
  $(document).ready(function() {
	  getMostWishedList();
	  getNoticeList();
	});

	function getNoticeList(){
	  $.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/notice/getListForMain.do",
			success : function(result){
				var output = "";
				for(var i in result){
					output += "<div class='col-md-6 col-lg-4 mb-4 mb-lg-0'>";
					output += "<div class='card card-blog'>";
					output += "<div class='card-blog__img'>";
					output += "<img class='card-img rounded-0' src='img/news/news.png' alt=''>";
					output += "</div>";
					output += "<div class='card-body'>";
					output += "<ul class='card-blog__info'>";
					output += "<li><a href='/Relay/noticeRead.do?nno="+result[i].nno+"'>"+result[i].nick+"</a></li>";
					output += "</ul>";
					output += "<h4 class='card-blog__title'><a href='/Relay/noticeRead.do?nno="+result[i].nno+"'>"+result[i].ntitle+"</a></h4>";
					output += "<p>"+result[i].ncontent+"</p>";
					output += "<a class='card-blog__link' href='/Relay/noticeRead.do?nno="+result[i].nno+"'>Read More <i class='ti-arrow-right'></i></a>";
					output += "</div>";
					output += "</div>";
					output += "</div>";
					$("#notice").html(output);
				}
	        }
	    });
  }
  
  function getMostWishedList(){
	  $.ajax({
			type : "get",
			dataType : "json",
			url : "/Relay/wishlist/getMostWishedList.do",
			success : function(result){
				var output = "";
				for(var i in result){
					output += "<div class='card text-center card-product' style='max-width:200px;'>";
					output += "<div class='card-product__img'>";
					output += "<img class='img-fluid' src='"+result[i].pimg+"' alt='' style='max-height:280px'>";
					//output += "<ul class='card-product__imgOverlay'>";
					//output += "<li><button><i class='ti-heart'></i></button></li>";
					//output += "</ul>";
					output += "</div>";
					output += "<div class='card-body'>";
					output += "<p>"+result[i].cat+"</p>";
					output += "<h6 class='card-product__title'><a href='"+result[i].pmallurl+"' target='_blank'><b>"+result[i].pname+"</b></a></h6>";
					output += "</div>";
					output += "</div>";
					$("#bestSellerCarousel").html(output);
				}
				if($('.owl-carousel').length > 0){
				    $('#bestSellerCarousel').owlCarousel({
				      loop:true,
				      margin:30,
				      autoplay: true,
			          slideTransition: 'linear',
			          autoplayTimeout: 6000,
			          autoplaySpeed: 6000,
			          autoplayHoverPause: true,
				      nav:true,
				      navText: ["<i class='ti-arrow-left'></i>","<i class='ti-arrow-right'></i>"],
				      dots: false,
				      responsive:{
				        0:{
				          items:1
				        },
				        600:{
				          items: 2
				        },
				        900:{
				          items:3
				        },
				        1130:{
				          items:4
				        }
				      }
				    })
				  }
	        }
	    });
  }

	function searchnow(){
		$(".header_area").hide();
		$("#searchview").show();
		$("#searchword").focus();
		$("#searchword").focusout(function(){
			$(".header_area").show();
			$("#searchview").hide();
		});
	}
</script>
<body style="background-color: #ffffff">

  <main class="site-main">
    
    <!--================ Hero banner start =================-->
    <section class="hero-banner">
      <div class="container">
        <div class="row no-gutters align-items-center pt-60px">
          <div class="col-5 d-none d-sm-block">
            <div class="hero-banner__img">
              <img class="img-fluid" src="img/home/main-banner.jpg" alt="">
            </div>
          </div>
          <div class="col-sm-7 col-lg-6 offset-lg-1 pl-4 pl-md-5 pl-lg-0">
            <div class="hero-banner__content">
            	<div class="wow fadeInDown" data-wow-duration="1s" data-wow-delay="0.8s">
	              <h1>RELAY로  선물 준비~</h1>
	              <br>
	            </div>
	            <div class="wow fadeInUp" data-wow-duration="1s" data-wow-delay="0.1s">
	              <p>특별한 날에 특별한 선물을 특별한 방법으로 주고 싶은 마음은 누구에게나 있습니다. <br><br> 저희는 다수의 인원들이 중복되지 않으면서 공유하며 시너지를 내는 선물을 한 사람에게 할 수 있는 릴레이 선물목록 서비스를 제공합니다.
	              </p>
	              <!-- <a class="button button-hero" href="#">Browse Now</a> -->
            	</div>
            </div>
          </div>
        </div>
      </div>
    </section>
    
    <!-- ================ Best Selling item  carousel ================= --> 
    <section class="section-margin calc-60px">
      <div class="container">
        <div class="section-intro pb-60px">
          <p>Popular Item in the market</p>
          <h2>Most Wished <span class="section-intro__style">Items</span></h2>
        </div>
        
        <div class="owl-carousel owl-theme" id="bestSellerCarousel"> 
        </div>
         
      </div>
    </section>
    <!-- ================ Best Selling item  carousel end ================= --> 


    <!-- ================ offer section start ================= --> 
    <section class="offer" id="parallax-1" data-anchor-target="#parallax-1" data-300-top="background-position: 80px 30px" data-top-bottom="background-position: 0 20px">
      <div class="container">
        <div class="row">
          <div class="col-xl-5">
            <div class="offer__content text-center">
              <h3><!-- Up To 50% Off --></h3>
              <h4><!-- Winter Sale --></h4>
              <p>Some gifts are big. Others are small. But the ones that come from the heart are the best gifts of all.</p>
              <a class="button button--active mt-3 mt-xl-4" href="#" onclick="searchnow()">Search Now</a>
            </div>
          </div>
        </div>
      </div>
      
    </section>
    <!-- ================ offer section end ================= -->

    <!-- ================ Blog section start ================= -->  
    <section class="blog pt-60px pb-60px">
      <div class="container">
        <div class="section-intro pb-60px">
          <h2>Latest <span class="section-intro__style">News</span></h2>
        </div>

        <div class="row" id="notice">
        </div>
      </div>
    </section>
    <!-- ================ Blog section end ================= -->  

    <!-- ================ Subscribe section start ================= --> 
    <!-- <section class="subscribe-position">
      <div class="container">
        <div class="subscribe text-center">
          <h3 class="subscribe__title">Get Update From Anywhere</h3>
          <p>Bearing Void gathering light light his eavening unto dont afraid</p>
          <div id="mc_embed_signup">
            <form target="_blank" action="https://spondonit.us12.list-manage.com/subscribe/post?u=1462626880ade1ac87bd9c93a&amp;id=92a4423d01" method="get" class="subscribe-form form-inline mt-5 pt-1">
              <div class="form-group ml-sm-auto">
                <input class="form-control mb-1" type="email" name="EMAIL" placeholder="Enter your email" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Your Email Address '" >
                <div class="info"></div>
              </div>
              <button class="button button-subscribe mr-auto mb-1" type="submit">Subscribe Now</button>
              <div style="position: absolute; left: -5000px;">
                <input name="b_36c4fd991d266f23781ded980_aefe40901a" tabindex="-1" value="" type="text">
              </div>

            </form>
          </div>
          
        </div>
      </div>
    </section> -->
    <!-- ================ Subscribe section end ================= --> 
	</main>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->

</body>
</html>