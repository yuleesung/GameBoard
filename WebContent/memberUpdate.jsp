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
	<form name="update_form" id="update_form" method="post">
		<table>
			<caption>회원수정 테이블</caption>
			<tbody>
				<tr>
					<th>
						<label for="id">ID(변경불가):</label>
					</th>
					<td>
						<label id="id">아이디</label>
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
						<input type="text" id="name" name="name" value="이름"/>
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
						<input type="button" id="submit_btn" value="수정완료"/>
						<input type="button" id="close_btn" value="이전으로"/>
					</td>
				</tr>
			</tfoot>
		</table>
	</form>
</div>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#submit_btn").click(function(){ /* 수정완료 버튼 */
		var pw = $("#pw").val();
	
		if(pw.trim().length<1){
			alert("비밀번호를 입력하세요");
			return;
		}
		
		// 업데이트 액션주기
		
	});
	
	$("#close_btn").click(function(){ /* 이전으로 버튼 */
		location.href="Controller?type=mypage"; // 마이페이지 이동
	});
});
</script>
</body>
</html>