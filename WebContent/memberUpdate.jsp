<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#update{
display: none;
}
</style>
</head>
<body>
<%
Object obje = session.getAttribute("mvo");
if(obje != null){
BoardMemberVO mvo = (BoardMemberVO)obje;
%>
<div id="update"> <!-- 회원수정 영역 -->
	<form name="update_form" id="update_form" action="Controller" method="post">
		<table>
			<caption>회원수정 테이블</caption>
			<tbody>
				<tr>
					<th>
						<label for="id">ID:</label>
					</th>
					<td>
						<label id="id"><%=mvo.getM_id() %></label>
					</td>
				</tr>
				<tr>
					<th>
						<label for="pw">비밀번호:</label>
					</th>
					<td>
						<input type="password" id="pw" name="pw"/>
					</td>
				</tr>
				<tr>
					<th>
						<label for="name">이름:</label>
					</th>
					<td>
						<input type="text" id="name" name="name"/>
					</td>
				</tr>
				
				<tr>
					<th>
						<label for="email">이메일:</label>
					</th>
					<td>
						<input type="text" id="email" name="email"/>
						<label for="email2">@</label>
						<input type="text" id="email2" name="email"/>
					</td>
				</tr>
				<tr>
					<th>
						<label for="phone">연락처:</label>
					</th>
					<td>
						<select name="phone" id="phone">
							<option value="010">010</option>
							<option value="011">011</option>
							<option value="017">017</option>
						</select>
						<label for="phone2">-</label>
						<input type="text" id="phone2" name="phone"/>
						<label for="phone3">-</label>
						<input type="text" id="phone3" name="phone"/>
					</td>
				</tr>
			</tbody>
			<tfoot>
				<tr>
					<td colspan="2">
						<input type="button" value="수정완료" onclick="sendData(this.form)"/>
					</td>
				</tr>
			</tfoot>
		</table>
		<input type="hidden" name="m_idx" value="<%=mvo.getM_idx()%>"/>
		<input type="hidden" name="type" value="memberEdit"/>
	</form>
</div>

<div id="check_pw"><!-- 패스워드 체크 영역 -->
	<form name="pw_form" id="pw_form" action="Controller" method="post">
		<table>
			<caption>회원수정 테이블(비밀번호 확인)</caption>
			<tbody>
				<tr>
					<th>
						<label for="pw">비밀번호:</label>
					</th>
					<td>
						<input type="password" id="pwd"/>
					</td>
				</tr>
			</tbody>
			<tfoot>
			<tr>
				<td colspan="2">
					<input type="button" value="확인" onclick="checkPw('<%=mvo.getPw()%>')"/>
				</td>
			</tr>
		</tfoot>
		</table>
	</form>
</div>
<%
}
%>

<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#update").css("display", "none");
});

function checkPw(pw){
	var pwd = document.getElementById("pwd");
	
	if(pwd.value.trim().length<1){
		alert("비밀번호를 입력하세요");
		return;
	}
	
	if(pw == pwd.value){
		$("#check_pw").css("display", "none");
		$("#update").css("display", "block");
	}else{
		alert("비밀번호가 맞지 않습니다!");
	}
}

function sendData(frm){
	var input = $("#update_form input");
	for(i=0; i<input.length; i++){
		if(input[i].value.trim().length < 1){
			alert("빈칸을 입력해주세요");
			input[i].focus();
			return;
		}
	}
	frm.submit();
}

</script>
</body>
</html>