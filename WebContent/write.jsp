<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="css/summernote-lite.css"/>

<style type="text/css">
	#bbs table {
	    width:580px;
	    margin-left:10px;
	    border:1px solid black;
	    border-collapse:collapse; 
	    font-size:14px;
	    
	}
	
	#bbs table caption {
	    font-size:20px;
	    font-weight:bold;
	    margin-bottom:10px;
	}
	
	#bbs table th {
	    text-align:center;
	    border:1px solid black;
	    padding:4px 10px;
	}
	
	#bbs table td {
	    text-align:left;
	    border:1px solid black;
	    padding:4px 10px;
	}
	
	.no {width:15%}
	.subject {width:30%}
	.writer {width:20%}
	.reg {width:20%}
	.hit {width:15%}
	.title{background:lightsteelblue}
	
	.odd {background:silver}
	
		
</style>

</head>
<body>
	<div id="bbs">
	<form action="control?type=write" method="post" encType="multipart/form-data">
		<table>
			<caption> 글 쓰기 </caption>
			<tbody>
				<tr>
					<th>제목 : </th>
					<td><input type = "text" name="title" size="40"/></td>
				</tr>
				<tr>
					<th>이름:</th>
					<td><input type="text" name="writer" size="12" value="<%= %>" readonly/></td> <%-- 로그인 아이디 받기 --%>
				</tr>
				<tr>
					<th>첨부파일:</th>
					<td><input type="file" name="file"/></td>
				</tr>	
			</tbody>
		</table>
		<input type="hidden" name="content" id="str"/>
	</form>

		<table>
			<tbody>
				<tr>
					<th style="width:83px;">내용:</th>
					<td><textarea name="content" cols="50" 
							rows="8" id="content"></textarea>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<input type="button" value="보내기"
						onclick="sendData()"/>
						<input type="button" value="다시"/>
						<input type="button" value="목록"/>
					</td>
				</tr>
			</tbody>
		</table>	
	</div>
	
	<script src = "js/jquery-3.4.1.min.js"></script>
	<script src="js/summernote-lite.js"></script>
	<script src="js/lang/summernote-ko-KR.min.js"></script>
	<script>
	
	//썸머 노트
	$(function(){
		
		$("#content").summernote({
			height: 300,
			width: 450,
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
		frm.append("str", "Michael");
		
		
		$.ajax({
			url: "control?type=saveImage",
			type: "post",
			dataType: "json",
			contentType: false,
			processData: false,
			
			data: frm
			
		}).done(function(data){
			
			$("#content").summernote(
				"editor.insertImage", data.url);
			
			
		}).fail(function(err){
			console.log(err);
		});
	}
	
	
	//보내기 버튼 
	function sendData(){
		for(var i=0 ; i<document.forms[0].elements.length ; i++){
		
			if(i > 1)
				break;
			
			if(document.forms[0].elements[i].value == ""){
				alert(document.forms[0].elements[i].name+
						"를 입력하세요");
				document.forms[0].elements[i].focus();
				return;
			}
		}
		var str = $("#content").val();
		
		$("#str").val(str);
 
		document.forms[0].submit();
	}
	
	
	
	</script>


</body>
</html>