<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>My Page</title>
<link type="text/css" rel="stylesheet" href="css/main.css">
<link type="text/css" rel="stylesheet" href="css/myPage.css">
<link type="text/css" rel="stylesheet" href="css/footer.css">
</head>
<body>
<div id="wrap2">
	<!-- 메뉴 바 -->
	<div id="menu_bar"></div>
	<!-- 메뉴 바 끝 -->
	<div id="myPage_content" class="center">
		<div id="left_menu"></div>
		<div id="right_content"></div>
	</div>
</div>
	<div id="footer" class="footer"></div>
	
<script src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#menu_bar").load("menu.jsp");
		$("#left_menu").load("myPage_menu.jsp");
		$("#right_content").load("myBoard.jsp");
		$("#footer").load("footer.jsp");
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
	
	function goLogin(){
		location.href="Controller?type=login&path=myPage";
	}
	function goLogout(){
		location.href="Controller?type=logout&path=myPage";
	}
</script>
</body>
</html>