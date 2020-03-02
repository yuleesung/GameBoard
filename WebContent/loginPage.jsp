<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/loginPage.css">
<link type="text/css" rel="stylesheet" href="css/footer.css">
</head>
<body>
<%
String path = (String)request.getAttribute("path");
String cPage = (String)request.getAttribute("cPage");
String category = (String)request.getAttribute("category");
String b_idx = (String)request.getAttribute("b_idx");
String search_val = (String)request.getAttribute("search_val");

if(path==null)
	path = "main";
%>
<div id="wrap">

	<div class="main_logo"> <!-- 로고 이미지 -->
		<span>
			<a href="Controller?type=main"><img alt="메인로고" 
				src="css/images/linkedin_profile_image.png" width="410px"/></a>
		</span>
	</div>

	<div id="login_div"> <!-- 로그인 화면영역 -->
		<form id="login_form" name="login_form" action="Controller" method="post">
			<table id="login_table">
				<tbody>
					<tr>
						<td>
							<input type="text" id="s_id" name="s_id" placeholder="아이디" onkeypress="enterkey(this.form)"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="password" id="s_pw" name="s_pw" placeholder="비밀번호" onkeypress="enterkey(this.form)"/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="button" id="login_btn" value="로그인"/>			
						</td>
					</tr>
					<tr>
						<td>
							<a id="main_btn">이전으로</a>		
							&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<a id="reg_btn">회원가입</a>
						</td>	
					</tr>
				</tbody>
			</table>
			<input type="hidden" id="type" name="type" value="<%=path %>"/> <!-- path로 변경해야 함 -->
			<input type="hidden" name="cPage" value="<%=cPage %>"/>
			<input type="hidden" name="category" value="<%=category %>"/>
			<input type="hidden" name="b_idx" value="<%=b_idx %>"/>
			<input type="hidden" name="search_val" value="<%=search_val %>"/>
		</form>
	</div>
</div>
	<div id="footer" class="footer"></div>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
		$(function(){
			$("#login_btn").click(function(){ /* 로그인 버튼 */
				loginlogin();
			});
			
				
			$("#main_btn").click(function(){ /* 이전으로 버튼 */
				history.back();
			});
					
			$("#reg_btn").click(function(){ /* 회원가입 버튼 */
				location.href="registryPage.jsp";
			});
		});	/* 끝 */
		
		function enterkey(frm) { /* 엔터버튼 눌렀을 때 진입 */
			if(window.event.keyCode==13){
				loginlogin();
			}
		}
		
		function loginlogin() { /* 로그인 동작하는 기능 */
			var id = $("#s_id").val();
			var pw = $("#s_pw").val();
			
			/* 유효성 검사 */
			if(id.trim().length <= 0){
				alert("아이디를 입력하세요");
				id.focus();
				return;
			}
			if(pw.trim().length <= 0){
				alert("비밀번호를 입력하세요");
				pw.focus();
				return;
			}
			
			var param = "type=login&id="+id+"&pw="+pw;
			
			$.ajax({
				url: "Controller",
				type: "POST",
				data: param,
				dataType: "json"
			}).done(function(data){
				if(data.res=="ok"){
					document.login_form.submit();
				}else{
					alert("로그인에 실패했습니다");
				}

			}).fail(function(err){
				console.log(err);
			});
		}
		
		$(document).ready(function(){
	        $("#footer").load("footer.jsp");
	     });
</script>
</body>
</html>