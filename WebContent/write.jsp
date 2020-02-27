<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/summernote-lite.min.css"/>
<link rel="stylesheet" href="css/menu.css"/>
<link rel="stylesheet" href="css/main.css"/>
<link rel="stylesheet" href="css/write.css"/>

</head>
<body>
	<div id="menu_bar" class="center"></div>
	<div id="bbs">
		<header>
			<h1>게시글 쓰기</h1>
		</header>
		<form action="Controller?type=write" method="post" encType="multipart/form-data">
			<input type="hidden" name="category" value="${requestScope.category }"/>
			<input type="hidden" name="cPage" value="${requestScope.cPage }"/>
			<table id="t1">
				<caption> 글 쓰기 </caption>
				<tbody>
					<tr>
						<th>제목:</th>
						<td><input type="text" name="subject" id="subject" size="40"/></td>
					</tr>
					<tr>
						<th>첨부파일:</th>
						<td><input type="file" name="file" id="file"/></td>
					</tr>	
				</tbody>
			</table>
			<input type="hidden" name="content" id="str"/>
		</form>
	
		<table id="t2">
			<tbody>
				<tr>
					<th colspan="2">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</th>
				</tr>
				<tr>
					<td colspan="2"><textarea name="content" cols="50" 
							rows="8" id="content"></textarea>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<input type="button" value="저  장" onclick="writeData()"/>
						<input type="button" value="취  소" onclick="cancelWrite('${requestScope.category}', '${requestScope.cPage }')"/>
					</td>
				</tr>
			</tbody>
		</table>	
	</div>
	
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/summernote-lite.min.js"></script>
	<script src="js/lang/summernote-ko-KR.min.js"></script>
	<script>
	$(document).ready(function(){
        $("#menu_bar").load("menu.jsp");
     });
	//썸머 노트
	$(function(){
		
		$("#content").summernote({
			height: 300,
			width: 620,
			lang: "ko-KR",
			callbacks:{
				onImageUpload: function(files, editor){
					for(var i=0; i<files.length; i++){
						sendFile(files[i], editor);
					}
				},
			}
		});
		
			$("#content").summernote("lineHeight", 1.0);
	});
	
	
	//이미지 서버 업로드
	function sendFile(file, editor){
		
		var frm = new FormData();
		
		frm.append("upload", file);
		
		$.ajax({
			url: "Controller?type=saveImage",
			type: "post",
			dataType: "json",
			contentType: false,
			processData: false,
			data: frm
		}).done(function(data){
			// console.log(data.url);
			$("#content").summernote("editor.insertImage", data.url);
		}).fail(function(err){
			console.log(err);
		});
	}
	
	
	//보내기 버튼 
	function writeData(){
		
		var subject = document.getElementById("subject");
		var content = document.getElementById("content");
		
		// 유효성 검사
		if(subject.value.trim().length < 1){
			alert("제목을 입력하세요!");
			subject.focus();
			return;
		}
		
		if(content.value.trim().length < 1){
			alert("내용을 입력하세요!");
			content.focus();
			return;
		}
		
		var str = $("#content").val();
		
		$("#str").val(str);
 
		document.forms[0].submit();
	}
	
	// 취소 버튼
	function cancelWrite(category, cPage) {
		location.href = "Controller?type=list&category="+category+"&cPage="+cPage;
	}
	
	
	
	</script>


</body>
</html>