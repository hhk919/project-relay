var idn = 0;
	var pwn = 0;
	var rpwn = 0;
	var namen = 0;
	var nickn = 0;
	var addrn = 0;
	var birthn = 0;
	var sexn = 0;

	function checkWrite() {/* 해당 항목의 값이 null인지 체크하기, document.뒤에는 해당 폼의 이름이 들어가야함 */
		if (idn == 0) {
			document.signup.id.focus();
		} else if (pwn == 0) {
			document.signup.pw.focus();
		} else if (rpwn == 0) {
			document.signup.rpw.focus();
		} else if (document.signup.pw.value != ""
				&& document.signup.rpw.value != "")/* 비밀번호가 null값이 아닐때 비밀번호와 확인 비밀번호 일치 여부 */
			if (document.signup.pw.value != document.signup.rpw.value) {
				document.signup.rpw.focus();
			} else if (namen == 0) {
				document.signup.name.focus();
			} else if (nickn == 0) {
				document.signup.nick.focus();
			} else if (addrn == 0) {
				document.signup.addr.focus();
			} else if (birthn == 0) {
				document.signup.birth.focus();
			} else if (sexn == 0) {
				document.signup.sex.focus();
			} else {
				document.signup.submit();
			}

	}

	function showErrorMsg(obj, id, msg) {

		obj.attr("class", "check");
		obj.css("color", "red");
		obj.css("font-size", "12px");
		id.css("background-color", "#FFCECE");
		$(".join").prop("disabled", true);
		$(".join").css("background-color", "#aaaaaa");
		obj.html(msg);
		obj.show();

	}

	function showSuccessMsg(obj, id, msg) {

		obj.attr("class", "check");
		obj.css("color", "blue");
		obj.css("font-size", "12px");
		id.css("background-color", "#B0F6AC");
		$(".join").prop("disabled", false);
		$(".join").css("background-color", "#4CAF50");
		obj.html(msg);
		obj.show();
	}

	//아이디 유효성,중복 검사
	$(function() {
		$("#id").blur(
				function() {

					var oMsg = $("#id_check");
					var oId = $("#id");
					var isID = /^[a-z0-9]{4,19}$/;

					$.ajax({
						type : "POST",
						data : {
							"id" : $('#id').val()
						},
						url : "/Relay/idCheck.do",
						success : function(data) {
							if ($.trim(data) == "yes") {
								if (oId.val() == "") {
									idn = 0;
									showErrorMsg(oMsg, oId, "아이디를 입력해주세요.");
								} else if (!isID.test(oId.val())) {
									idn = 0;
									showErrorMsg(oMsg, oId,
											"5~20자의 영문 소문자, 숫자만 사용 가능합니다.");
								} else {
									idn = 1;
									showSuccessMsg(oMsg, oId, "사용가능한 아이디입니다!");
									
								}
							} else {
								idn = 0;
								showErrorMsg(oMsg, oId, "이미 사용중인 아이디입니다.");
							}
						},
						error : function(error) {
							alert("error : " + error);
						}
					});
				});
	});

	//빈칸 검사
	function checkSpace(str) {
		if (str.search(/\s/) != -1) {
			return true;
		} else {
			return false;
		}
	}

	//비밀번호 확인 함수
	function isValidPasswd(str) {
		var cnt = 0;
		if (str == "") {
			return false;
		}

		/* check whether input value is included space or not */
		var retVal = checkSpace(str);
		if (retVal) {
			return false;
		}
		if (str.length < 8) {
			return false;
		}
		for (var i = 0; i < str.length; ++i) {
			if (str.charAt(0) == str.substring(i, i + 1))
				++cnt;
		}
		if (cnt == str.length) {
			return false;
		}

		var isPW = /^(?=.*\d{1,16})(?=.*[~`!@#$%\^&*()-+=]{1,16})(?=.*[a-zA-Z]{2,16}).{8,16}$/;
		if (!isPW.test(str)) {
			return false;
		}

		return true;
	}

	//비밀번호 유효성 검사
	$(function() {
		$("#pw").blur(function() {

			var oMsg = $("#pw_check");
			var oPw = $("#pw");

			if (oPw.val() == "") {
				pwn = 0;
				showErrorMsg(oMsg, oPw, "비밀번호를 입력해주세요.");
			} else if (isValidPasswd(oPw.val()) != true) {
				pwn = 0;
				showErrorMsg(oMsg, oPw, "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
			} else {
				pwn = 1;
				showSuccessMsg(oMsg, oPw, "");
			}
		});
	});

	//비밀번호 일치 검사
	$(function() {
		$("#rpw").blur(function() {

			var oMsg = $("#rpw_check");
			var oPw01 = $("#pw");
			var oRpw = $("#rpw");

			if (oRpw.val() == "") {
				rpwn = 0;
				showErrorMsg(oMsg, oRpw, "비밀번호를 재입력해주세요.");
			} else if (oPw01.val() != oRpw.val()) {
				rpwn = 0;
				showErrorMsg(oMsg, oRpw, "비밀번호가 일치하지 않습니다.");
			} else {
				rpwn = 1;
				showSuccessMsg(oMsg, oRpw, "비밀번호가 일치합니다");
			}
		});
	});

	//이름 유효성 검사
	$(function() {
		$("#name").blur(function() {

			var oMsg = $("#name_check");
			var oName = $("#name");
			var pattern = /^[가-힣]{2,19}$/;

			if (oName.val() == "") {
				namen = 0;
				showErrorMsg(oMsg, oName, "이름을 입력해주세요.");
			} else if (!pattern.test(oName.val())) {
				namen = 0;
				showErrorMsg(oMsg, oName, "이름을 정확히 입력해주세요.");
			} else {
				namen = 1;
				showSuccessMsg(oMsg, oName, "");
			}
		});
	});

	//닉네임 유효성,중복 검사
	$(function() {
		$("#nick")
				.blur(
						function() {

							var oMsg = $("#nick_check");
							var onick = $("#nick");
							var isNick = /^[a-z0-9A-Zㄱ-힣]{4,19}$/;

							$
									.ajax({
										type : "POST",
										data : {
											"nick" : $('#nick').val()
										},
										url : "/Relay/nickCheck.do",
										success : function(data) {
											if ($.trim(data) == "yes") {
												if (onick.val() == "") {
													nickn = 0;
													showErrorMsg(oMsg, onick,
															"닉네임을 입력해주세요.");
												} else if (!isNick.test(onick
														.val())) {
													nickn = 0;
													showErrorMsg(oMsg, onick,
															"특수기호로 시작할 수 없고, 5~20자만 사용 가능합니다.");
												} else {
													nickn = 1;
													showSuccessMsg(oMsg, onick,
															"사용가능한 닉네임입니다!");
												}
											} else {
												nickn = 0;
												showErrorMsg(oMsg, onick,
														"이미 사용중인 닉네임입니다.");
											}
										},
										error : function(error) {
											alert("error : " + error);
										}
									});
						});
	});

	//주소 유효성 검사
	$(function() {
		$("#addr").blur(function() {

			var oMsg = $("#addr_check");
			var oAddr = $("#addr");
			var pattern = /^[ a-zA-Z가-힣0-9-]{2,50}$/;

			if (oAddr.val() == "") {
				addrn = 0;
				showErrorMsg(oMsg, oAddr, "주소를 입력해주세요.");
			} else if (!pattern.test(oAddr.val())) {
				addrn = 0;
				showErrorMsg(oMsg, oAddr, "주소를 정확히 입력해주세요.");
			} else {
				addrn = 1;
				showSuccessMsg(oMsg, oAddr, "");
			}
		});
	});

	//주소 유효성 검사
	$(function() {
		$("#sex").blur(function() {

			var oMsg = $("#sex_check");
			var oSex = $("#sex");

			if (oSex.val() == "") {
				sexn = 0;
				showErrorMsg(oMsg, oSex, "선택해주세요.");
			} else {
				sexn = 1;
				showSuccessMsg(oMsg, oSex, "");
			}
		});
	});

	//생년월일 유효성 검사
	$(function() {
		$("#birth")
				.blur(
						function() {

							var oMsg = $("#birth_check");
							var oBirth = $("#birth");
							var pattern = /^([0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
							var today = new Date();
							var adult = today.getFullYear() - 20;
							var oBirthyear = parseInt(oBirth.val().substr(0, 4));

							if (oBirth.val() == "") {
								birthn = 0;
								showErrorMsg(oMsg, oBirth, "생년월일을 입력해주세요.");
							} else if (!pattern.test(oBirth.val())) {
								birth = 0;
								showErrorMsg(oMsg, oBirth,
										"생년월일을 형식에 맞게 입력해주세요. ex)930818");
							} else {
								birthn = 1;
								showSuccessMsg(oMsg, oBirth, "");
							}
						});
	});