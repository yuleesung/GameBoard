<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Page</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
</head>
<body>
<div id=wrap>
	<!-- 메인 로고 이미지 시작 -->
	<div class="main_logo center">
		<span>
			<a href="Controller?type=main"><img alt="메인로고" src=""/></a>
		</span>
	</div>
	<!-- 메인 로고 끝 -->
	
	<!-- 메뉴 바 -->
	<div id="menu_bar"></div>
	<!-- 메뉴 바 끝 -->
	
</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#menu_bar").load("menu.jsp");
 	});
</script>
</body>
</html>