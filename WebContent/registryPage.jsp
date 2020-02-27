<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/registryPage.css"/>
</head>
<body>
<div id="wrap">
	<div class="main_logo"> <!-- 로고 이미지 -->
		<span>
			<a href="Controller?type=main"><img alt="메인로고" 
				src="images/linkedin_profile_image.png" width="100%" height="100%"/></a>
		</span>
	</div>

	<div id="reg_div"> <!-- 회원가입 영역 -->
		<form class="reg_form" name="reg_form" id="reg_form" action="Controller" method="post">
			<table id="reg_table">
				<caption>회원추가 테이블</caption>
				<colgroup>
					<col width="150px"/>
					<col width="*"/>
				</colgroup>
				<tbody>
					<tr>
						<th>
							<label for="id">아이디</label>
						</th>
						<td>
							<input type="text" id="id" name="id"/>
							<div id="id_box"></div>
						</td>
					</tr>
					<tr>
						<th>
							<label for="pw">비밀번호</label>
						</th>
						<td>
							<input type="password" id="pw" name="pw"/>
						</td>
					</tr>
					<tr>
						<th>
							<label for="name">이름</label>
						</th>
						<td>
							<input type="text" id="name" name="name"/>
						</td>
					</tr>
					<tr>
						<th>
							<label for="email">이메일</label>
						</th>
						<td>
							<input type="text" id="email" name="email"/>
							<label for="email2">@</label>
							<input type="text" id="email2" name="email"/>
						</td>
					</tr>
					<tr>
						<th>
							<label for="phone">연락처</label>
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
						<td id="sub_btn" colspan="2">
							<input type="button" id="submit_btn" value="가입하기"/>	
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<a id="close_btn">가입취소</a>
						</td>
					</tr>
				</tfoot>
			</table>
			<input type="hidden" name="type" value="registry"/>
		</form>
	</div>
	
	<div class="footer"> <!-- 하단영역 -->
		<div class="footer_area">
			<ul class="foot_guide">
				<li><a href="">개인정보취급방침</a></li>
				<li><a href="">웹회원 이용약관</a></li>
				<li><a href="">책임한계와 법적고지</a></li>
				<li><a href="">이메일 무단수집 거부</a></li>
			</ul>
			<address>
			 서울시 중구 을지로 몇가 번지
			 대표이사: ㅁㄴㅇㄹ 
			 고객상담: 국번없이 114 혹은 
			 02-1234-1234 (평일 09:00~17:00)
			</address> 
			<p class="copyright">
				Copyright (c) 2020 어쩌구
			</p>
		</div>
	</div>
</div>	
</body>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("#id").bind("keyup",function(){ /* 아이디 중복체크 */
		var str = $(this).val(); // str = ID 값
		
		//console.log(str);
		
		if(str.trim().length > 3){
			var param = "type=idcheck&id="+encodeURIComponent(str);
			
			$.ajax({
				url: "Controller",
				type: "POST",
				data: param,
				dataType: "json"
			}).done(function(data){
				$("#id_box").html(data.res);
			}).fail(function(err){
				console.log(err);
			});
		}else{  /* id길이가 4 미만일 때는 공백처리 */
			$("#id_box").html("");
		}
	});
	
	
	
	$("#submit_btn").click(function(){ /* 회원가입 제출버튼 */
		var id = $("#id").val().trim();
		var pw = $("#pw").val().trim();
		var name = $("#name").val().trim();
		
		console.log(id+","+pw+","+name);
		
		/* 유효성 검사 */
		if(id.length < 1){
			alert("아이디를 입력하세요");
			$("#id").focus();
			return;
		}
		if(pw.length < 1){
			alert("비밀번호를 입력하세요");
			$("#pw").focus();
			return;
		}
		if(name.length < 1){
			alert("이름을 입력하세요");
			$("#name").focus();
			return;
		}	
		document.reg_form.submit();
	});
	
	
	$("#close_btn").click(function(){ /* 취소버튼 */
		location.href="Controller?type=main";
	});
	
});
</script>
</html>