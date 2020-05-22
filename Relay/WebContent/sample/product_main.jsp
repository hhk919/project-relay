<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<div class="section-intro pb-60px">
		<p>Popular Item in the market</p>
		<h2>Trending <span class="section-intro__style">Product</span></h2>
	</div>
        
        <!-- 1st row -->
        <h4>10대</h4>
        <hr>
        <div class="row">
        <c:forEach items="${list10}" var="list">
          <div class="col-md-6 col-lg-4 col-xl-3">
            <div class="card text-center card-product">
              <div class="card-product__img">
                <img class="card-img" src="${list.image}" alt="${list.title}">
                <ul class="card-product__imgOverlay">
                  <li><a href="${list.link}" target="_blank"><button><i class="ti-search"></i></button></a></li>
                  <li><button><i class="ti-heart"></i></button></li>
                </ul>
              </div>
              <!-- <div class="card-body">
                <p>Accessories</p>
                <h4 class="card-product__title"><a href="single-product.html">Man Office Bag</a></h4>
                <p class="card-product__price">$150.00</p>
              </div> -->
            </div>
          </div>
         </c:forEach>
         </div>
         
        <!-- 2nd row -->
        <h4>20대</h4>
        <hr>
         <div class="row">
          <c:forEach items="${list20}" var="list">
          <div class="col-md-6 col-lg-4 col-xl-3">
            <div class="card text-center card-product">
              <div class="card-product__img">
                <img class="card-img" src="${list.image}" alt="${list.title}">
                <ul class="card-product__imgOverlay">
                  <li><a href="${list.link}" target="_blank"><button><i class="ti-search"></i></button></a></li>
                  <li><button><i class="ti-heart"></i></button></li>
                </ul>
              </div>
              <!-- <div class="card-body">
                <p>Accessories</p>
                <h4 class="card-product__title"><a href="single-product.html">Man Office Bag</a></h4>
                <p class="card-product__price">$150.00</p>
              </div> -->
            </div>
          </div>
        </c:forEach>
        </div>
        
        <!-- 3rd row -->
        <h4>30대</h4>
        <hr>
        <div class="row">
          <c:forEach items="${list30}" var="list">
          <div class="col-md-6 col-lg-4 col-xl-3">
            <div class="card text-center card-product">
              <div class="card-product__img">
                <img class="card-img" src="${list.image}" alt="${list.title}">
                <ul class="card-product__imgOverlay">
                  <li><a href="${list.link}" target="_blank"><button><i class="ti-search"></i></button></a></li>
                  <li><button><i class="ti-heart"></i></button></li>
                </ul>
              </div>
              <!-- <div class="card-body">
                <p>Accessories</p>
                <h4 class="card-product__title"><a href="single-product.html">Man Office Bag</a></h4>
                <p class="card-product__price">$150.00</p>
              </div> -->
            </div>
          </div>
        </c:forEach>
      	</div>
      	
        <!-- 4th row -->
      	<h4>40대</h4>
        <hr>
      	<div class="row">
          <c:forEach items="${list40}" var="list">
          <div class="col-md-6 col-lg-4 col-xl-3">
            <div class="card text-center card-product">
              <div class="card-product__img">
                <img class="card-img" src="${list.image}" alt="${list.title}">
                <ul class="card-product__imgOverlay">
                  <li><a href="${list.link}" target="_blank"><button><i class="ti-search"></i></button></a></li>
                  <li><button><i class="ti-heart"></i></button></li>
                </ul>
              </div>
              <!-- <div class="card-body">
                <p>Accessories</p>
                <h4 class="card-product__title"><a href="single-product.html">Man Office Bag</a></h4>
                <p class="card-product__price">$150.00</p>
              </div> -->
            </div>
          </div>
        </c:forEach>
        </div>
</body>
</html>