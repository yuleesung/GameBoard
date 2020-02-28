<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu Bar</title>
<link type="text/css" rel="stylesheet" href="css/menu.css">
</head>
<body>
<%
Object o = session.getAttribute("mvo");
%>

	<!-- 상위 메뉴 시작 -->
	<div class="main_box center">
		<!-- 메인 로고 이미지 시작 -->
		<div class="main_logo center">
			<span>
				<a href="Controller?type=main">
					<img alt="메인로고" src="css/images/logo_transparent_1.png" width="90px"/>
					<img id="logo_txt" alt="로고텍스트" src="css/images/logo_text.png" width="250px"/>
				</a>
			</span>
		</div>
		<!-- 메인 로고 끝 -->
		
		<!-- 상위 이미지, 로그인 메뉴 시작 -->
		<%
		if(o != null){
			BoardMemberVO mvo = (BoardMemberVO)o;
		%>
		<div class="main_bar center">
			<a href="javascript:goLogout()" id="logout">로그아웃</a>&nbsp;&nbsp;&nbsp;
			<input type="button" id="search_button" value="검색" onclick="search()"/>	
			<input type="text" id="search_value"/>
			<div id="welcome">
				<b><%=mvo.getM_name() %>님 환영합니다!</b>
				<img alt="welcome" src="css/images/welcome.png" width="50px"/>
			</div>
		</div>
		<%
		}else{
		%>
		<div class="main_bar center">
			<a href="javascript:goLogin()">로그인</a>&nbsp;
			<a href="javascript:location.href='Controller?type=registry&path=main'">회원가입</a>&nbsp;&nbsp;&nbsp;
			<input type="button" id="search_button" value="검색" onclick="search()"/>
			<input type="text" id="search_value"/>
		</div>
		<%
		}
		%>
	</div>
	<!-- 상위 메뉴 끝 -->
	
	<div class="nav_menu center">
		<!-- 메뉴바 시작 -->
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
		<!-- 메뉴바 끝 -->
	</div>
	<script type="text/javascript">
	function search(){
		var search_val = document.getElementById("search_value").value;
		location.href="Controller?type=searchlist&search_val="+search_val;
	}
	</script>
</body>
</html>