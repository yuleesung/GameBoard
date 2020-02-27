<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#login_div{
	border: 1px solid red;
	width:673px;
	margin:auto;
	}
	
</style>
</head>
<body>
<%
String path = (String)request.getAttribute("path");
String cPage = (String)request.getAttribute("cPage");
String category = (String)request.getAttribute("category");

if(path==null)
	path = "main";
%>
<div id="wrap">
	<div id="login_div"> <!-- 로그인 화면영역 -->
		<form name="login_form" action="Controller" method="post">
			<table>
				<colgroup>
					<col width="100px"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<td><label for="s_id">ID:</label></td>
						<td>
							<input type="text" id="s_id" name="s_id"/>
						</td>
					</tr>
					<tr>
						<td><label for="s_pw">PW:</label></td>
						<td>
							<input type="password" id="s_pw" name="s_pw"/>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<input type="button" id="login_btn" value="로그인"/>			
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<a id="main_btn">이전으로</a>
							<a id="reg_btn">회원가입</a>		
						</td>
					</tr>
				</tbody>
			</table>
			<input type="hidden" id="type" name="type" value="<%=path %>"/> <!-- path로 변경해야 함 -->
			<input type="hidden" name="cPage" value="<%=cPage %>"/>
			<input type="hidden" name="category" value="<%=category %>"/>
		</form>
	</div>
</div>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
		$(function(){
			$("#login_btn").click(function(){ /* 로그인 버튼 */
				var id = $("#s_id").val();
				var pw = $("#s_pw").val();
				var type = $("#type").val();
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
			});
				
			$("#main_btn").click(function(){ /* 이전으로 버튼 */
				location.href="Controller?type="+type;
			});
					
			$("#reg_btn").click(function(){ /* 회원가입 버튼 */
				location.href="registryPage.jsp";
			});
		});	/* 끝 */
</script>
</body>
</html>