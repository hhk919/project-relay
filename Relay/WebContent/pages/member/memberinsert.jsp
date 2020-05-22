<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Relay: 회원가입</title>
<link rel="stylesheet" href="/Relay/css/join.css">
<link rel="stylesheet" href="/Relay/css/all.css">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="/Relay/js/validator.js"></script>
<%@ include file="/pages/include/header.jsp"%>
</head>
<body>
	<div class="wrapper fadeInDown">
		<br>
		<div class="card bg-light">
			<article class="card-body mx-auto" style="max-width: 400px;">
				<h4 class="card-title mt-3 text-center">회원가입</h4>
				<p class="divider-text"></p>
				<hr>
				<form action="/Relay/memberInsert.do" method="POST"
					autocomplete="off" name="signup">
					<div class="check" id="id_check"></div>
					<div style="font-size: 12px; color: red" id="id-error-dialog"></div>
					<div class="form-group input-group">

						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-user"></i>
							</span>
						</div>

						<input id="id" name="id" class="form-control" placeholder="아이디"
							type="text">
					</div>

					<div class="check" id="pw_check"></div>
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-lock"></i>
							</span>
						</div>
						<input id="pw" name="pw" class="form-control" placeholder="비밀번호"
							type="password">
					</div>

					<div class="check" id="rpw_check"></div>
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-lock"></i>
							</span>
						</div>
						<input id="rpw" class="form-control" placeholder="비밀번호 재확인"
							type="password">
					</div>

					<div class="check" id="name_check"></div>
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-language"></i>
							</span>
						</div>
						<input id="name" name="name" class="form-control" placeholder="이름"
							type="text">
					</div>

					<div class="check" id="nick_check"></div>
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-signature"></i>
							</span>
						</div>
						<input id="nick" name="nick" class="form-control"
							placeholder="닉네임" type="text">
					</div>

					<div class="check" id="addr_check"></div>
					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i
								class="fa fa-map-marker-alt"></i>
							</span>
						</div>
						<input id="addr" name="addr" class="form-control" placeholder="주소"
							type="text">
					</div>

					<div class="check" id="birth_check"></div>

					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-id-card"></i>
							</span>
						</div>
						<input id="birth" name="birth" class="form-control"
							placeholder="주민등록번호" type="text" maxlength="6"> &emsp;

						<div class="mt-1">
							<i class="fa fa-minus"></i>
						</div>
						&emsp; <select id="sex" name="sex" class="custom-select"
							style="max-width: 120px;">
							<option selected=""></option>
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
					</div>

					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-building"></i>
							</span>
						</div>
						<input name="job" class="form-control" placeholder="직업"
							type="text">
					</div>
					<!-- form-group end.// -->

					<div class="form-group input-group">
						<div class="input-group-prepend">
							<span class="input-group-text"> <i class="fa fa-hiking"></i>
							</span>
						</div>
						<input name="hobby" class="form-control" placeholder="취미"
							type="text">
					</div>

					<!-- SUBMIT 버튼 -->
					<div class="form-group">
						<button type="button" id="join" name="join"
							class="btn btn-primary btn-block"
							onclick="javascript:checkWrite()">회원가입</button>
					</div>

					<!-- 로그인 페이지 이동 -->
					<p class="text-center">
						이미 계정이 있으신가요? <a href="/Relay/pages/login/login.jsp">Login</a>
					</p>
				</form>
			</article>
		</div>

	</div>
	<!--container end.//-->
	<br>
	<br>
	<!--================ Start footer Area  =================-->	
	<%@ include file="/pages/include/footer.jsp"%>
	<!--================ End footer Area  =================-->
</body>
</html>