<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Page</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
<style type="text/css">
	#left_menu{
		display:inline-block;
		float: left;
		width: 150px;
		border: 1px solid red;
	}
	#right_content{
		display:inline-block;
		float: left;
		width: 400px;
		border: 1px solid red;
	}
</style>
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
	<div id="myPage_content" class="center">
		<div id="left_menu"></div>
		<div id="right_content"></div>
	</div>
</div>
<script src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#menu_bar").load("menu.jsp");
		$("#left_menu").load("myPage_menu.jsp");
		$("#right_content").load("myBoard.jsp");
 	});
	
	function changePage(val){
		if(val == 0){
			$("#right_content").load("myBoard.jsp");
		}else if(val == 1){
			$("#right_content").load("memberUpdate.jsp");
		}else{
			$("#right_content").load("leavePage.jsp");
		}
	}
</script>
</body>
</html>