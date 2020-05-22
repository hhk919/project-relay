<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="relay.vo.member.MemberVO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style type="text/css">

@import url("/Relay/css/admin.css");
    
footer {
	display: block;
}
</style>
<%
	if (((MemberVO)session.getAttribute("vo1")).getMno() != 1)
	{
%>
		<jsp:forward page="/pages/login/login.jsp"/>
<%	
	}
	else{
%>
		
<%}
		%>
</head>
<link rel="stylesheet" href="/Relay/vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="/Relay/vendors/fontawesome/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.9.3/dist/Chart.min.js"></script>
<body>
	<Header>
		<h1 align="left"><a href="/Relay/index.jsp">Relay</a> Admin</h1>
		<p style="text-align: center">
			<a href="/Relay/pages/adminMember/memberM.jsp">Member</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminProduct/productM.jsp">Products</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminBoard/boardM.jsp">Board</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/adminNotice/noticeM.jsp">Notice</a>
			&nbsp;|&nbsp;
			<a href="/Relay/pages/login/loginout.jsp">Logout</a>
			&nbsp;&nbsp;
		</p>
	</Header>
	
	<!-- ================ container start ================= --> 
	<div class="container pt-5 mt-5">
	
		<!-- ================ row start ================= --> 
		<div class="row">

            <!-- Area Chart -->
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <div class="chart-area">
                    <canvas id="myAreaChart"></canvas>
                  </div>
                </div>
              </div>
            </div>

            <!-- Pie Chart -->
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4">
                <!-- Card Header - Dropdown -->
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-primary">Revenue Sources</h6>
                </div>
                <!-- Card Body -->
                <div class="card-body">
                  <div class="chart-pie pt-4 pb-2">
                    <canvas id="myPieChart"></canvas>
                  </div>
                  <div class="mt-4 text-center small">
                    <span class="mr-2">
                      <i class="fas fa-circle text-primary"></i> A
                    </span>
                    <span class="mr-2">
                      <i class="fas fa-circle text-success"></i> B
                    </span>
                    <span class="mr-2">
                      <i class="fas fa-circle text-info"></i> C
                    </span>
                  </div>
                </div>
              </div>
            </div>
		
			<!-- Bar Chart -->
			<div class="col-xl-8 col-lg-7">
				<div class="card shadow mb-4">
				<!-- Card Header - Dropdown -->
					<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
						<h6 class="m-0 font-weight-bold text-primary">Earnings Overview</h6>
					</div>
				<!-- Card Body -->
				<div class="card-body">
					<div class="chart-area">
						<canvas id="myBarChart"></canvas>
					</div>
				</div>
				</div>
			</div>
   
		</div>
		<!-- ================ row end ================= --> 
		
	</div>
	<!-- ================ container end ================= --> 
	
	<!-- <footer style="margin-top: 60px">
		<a href="adminindex.jsp" style="text-decoration:none">Home</a>
	</footer> -->

	<script src="/Relay/js/chart-area.js"></script>
	<script src="/Relay/js/chart-pie.js"></script>
	<script src="/Relay/js/chart-bar.js"></script>
</body>
</html>