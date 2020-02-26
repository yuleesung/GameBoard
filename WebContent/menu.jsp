<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu Bar</title>
</head>
<body>
<%
Object o = session.getAttribute("mvo");
%>
<div class="nav_menu center">
	<ul class="gnb">
		<li><a href="javascript:location.href='Controller?type=list&category=news'"><span class="menu">뉴스</span></a></li>
		<li><a href="javascript:location.href='Controller?type=list&category=db'"><span class="menu">게임정보</span></a></li>
		<li><a href="javascript:location.href='Controller?type=list&category=free'"><span class="menu">자유게시판</span></a></li>
		<li><a href="javascript:location.href='Controller?type=list&category=qa'"><span class="menu">Q&A</span></a></li>
		<%
		if(o != null){
		%>
			<li><a href="javascript:location.href='Controller?type=myPage'"><span class="menu">마이페이지</span></a></li>
		<%
		}else{
		%>
			<li><a href="javascript:goLogin()"><span class="menu">마이페이지</span></a></li>
		<%
		}
		%>
	</ul>
</div>
</body>
</html>