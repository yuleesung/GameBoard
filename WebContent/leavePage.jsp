<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div> <!-- 회원탈퇴 영역 -->
	<form name="leave_form" id="leave_form" method="post">
		<table>
			<caption>회원탈퇴 테이블</caption>
			<tbody>
				<tr>
					<th>
						<label for="wd_pw">비밀번호:</label>
					</th>
					<td>
						<input type="text" id="wd_pw" name="wd_pw"/>
						<div id="box"></div>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="button" id="wd_submit_btn" value="회원탈퇴"/>
						<input type="button" id="wd_close_btn" value="취소"/>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#wd_submit_btn").click(function(){ /* 회원탈퇴 신청버튼 */
		var pw = $("#wd_pw").val().trim();
		
		if(pw.length < 1){
			alert("비밀번호를 입력하세요");
			$("#wd_pw").focus();
			return;
		}
		
		var param = "type=leave?pw="+pw;
		
		$.ajax({
			url: "Controller",
			type: "POST",
			data: param,
			dataType: "json"
		}).done(function(data){
			alert(data.res);
		}).fail(function(err){
			console.log(err);
		});
	});
	
	$("#wd_close_btn").click(function(){
		alert("마이페이지 이동");
	});
})

</script>
</body>
</html>