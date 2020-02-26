<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.t1 th, .t1 td{
	border: 1px solid blue;
}
</style>
</head>
<body>
<%
	Object obj = session.getAttribute("mvo");
	BoardMemberVO mvo = null;
	if(obj != null)
		mvo = (BoardMemberVO)obj;
%>
	<div id="wrap">
		<table class="t1">
			<tr>
				<th colspan="2"><%=mvo.getM_name() %>님의 정보</th>
			</tr>
			<tr>
				<th>E Mail</th>
				<td><%=mvo.getEmail() %></td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td><%=mvo.getPhone() %></td>
			</tr>
			<tr>
				<th>가입일자</th>
				<td><%=mvo.getReg_date() %></td>
			</tr>
		</table>
	</div>
</body>
</html>