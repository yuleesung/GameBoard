<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
BoardMemberVO mvo = (BoardMemberVO)session.getAttribute("mvo");
%>
<div> <!-- 회원수정 영역 -->
	<form name="pw_form" id="pw_form" action="Controller" method="post">
		<table>
			<caption>회원수정 테이블(비밀번호 확인)</caption>
			<tbody>
				<tr>
					<th>
						<label for="pw">비밀번호:</label>
					</th>
					<td>
						<input type="password" id="pw" name="pw"/>
					</td>
				</tr>
			</tbody>
			<tfoot>
			<tr>
				<td colspan="2">
					<input type="button" id="submit_btn" value="확인"/>
					<input type="button" id="close_btn" value="이전으로"/>
				</td>
			</tr>
		</tfoot>
		</table>
		<input type="hidden" id="mvo_pw" name="mvo_pw" value="11"/> <!-- mvo 비밀번호로 수정하기 -->
		<input type="hidden" name="type"/>
	</form>
</div>

<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#submit_btn").click(function(){
			var pw = $("#pw").val(); // 입력한 비밀번호
			var mvo_pw = $("#mvo_pw").val(); // 회원 비밀번호
			
			if(pw.trim().length<1){
				alert("비밀번호를 입력하세요");
				return;
			}
			
			if(pw == mvo_pw){
				document.pw_form.type.value="memberUpdate";
				document.pw_form.submit();
			}
			else
				alert("다시 입력해주세요");
		});
		
		$("#close_btn").click(function(){
			location.href="Controller?type=mypage"; // 마이페이지 이동
		});
	});
</script>
</body>
</html>