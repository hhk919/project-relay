$(document).ready(function(){
	replyList();
	$("#btnReply").click(function(){
        replyInsert();
    });
});

function replyUpdateShow(cno){
	var replyupdatetext = "#replyupdatetext"+cno;
	$(replyupdatetext).show();
}


function replyUpdate(cno){
	var c = "#replyupdatetextarea"+cno;
	var ccontent= $(c).val();
	var bno = '<c:out value="${vo.bno}"/>';
	var creplyer = '<c:out value="${vo1.getNick()}"/>';
	console.log(ccontent);
	console.log(bno);
	console.log(cno);
	console.log(creplyer);
	$.ajax({
		type : 'put',
		url : '/Relay/replyUpdate.do?cno=' + cno,
		dataType : 'text',
		data : JSON.stringify({
			cno : cno,
			ccontent : ccontent
		}),
		contentType : "application/json; charset=UTF-8",
		success : function(){
			alert("댓글이 수정되었습니다");
			replyList();
		},
	})
}

function replyDelete(cno){
	$.ajax({
		type : 'put', 
		url : '/Relay/replyDelete.do?cno=' + cno,
		success : function(){
			alert("댓글이 삭제되었습니다");
			replyList();
		},
	})
}

function replyList(){
	var bno = '<c:out value="${vo.bno}"/>';
	$.ajax({
		type : "get",
		dataType : "json",
		url : "/Relay/replyList.do?bno="+bno,
		success : function(result){
			var output = "";
			for(var i in result){
				output += "<li class='list-group-item' data-cno='"+result[i].cno+"'>";
				output += "  <div><div class='header'><strong>"+result[i].creplyer+"</strong>"; 
				output += "    <small class='pull-right text-muted'>"
	     	           +result[i].cdate+"</small></div>";
				output += ""+result[i].ccontent;
				if('<c:out value="${vo1.getNick()}"/>' == result[i].creplyer){
					output += "<div class='float-right'>";
					output += "<i class='fas fa-hammer mr-2' id='btnUpdate' onclick='replyUpdateShow("+result[i].cno+")'> 수정</i>";
					output += "<i class='fas fa-trash-alt' id='btnDelete' onclick='replyDelete("+result[i].cno+")'> 삭제</i>";
					output += "</div>";
					output += "<div class='rp mt-3' id='replyupdatetext"+result[i].cno+"'>";
					output += "<textarea rows='5' cols='80' class='form-control' id='replyupdatetextarea"+result[i].cno+"'>" + result[i].ccontent + "</textarea>";
					output += "<button type='button' class='btn btn-outline-primary btn-sm mt-2 float-right' onclick='replyUpdate("+result[i].cno+")'>수정</button>";
					output += "</div>";
				}
				output += "</div>";
				output += "</li>";
                
			$("#listReply").html(output);
			$(".rp").hide();
			}
        }
    });
}

function replyInsert(){
	var ccontent= $("#replytext").val();
	var bno = '<c:out value="${vo.bno}"/>';
	var creplyer = '<c:out value="${vo1.getNick()}"/>';
	$.ajax({
		type : 'post',
		url : '/Relay/replyInsert.do',
		dataType: "text",
		data : JSON.stringify({
			bno : bno, 
			ccontent : ccontent,
			creplyer : creplyer
		}),
		contentType : "application/json; charset=UTF-8",
		success : function(){
			alert("댓글이 등록되었습니다");
			replyList();
		},
	})
}