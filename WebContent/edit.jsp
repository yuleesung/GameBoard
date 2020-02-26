<%@page import="mybatis.vo.BoardMemberVO"%>
<%@page import="mybatis.dao.BbsDAO"%>
<%@page import="mybatis.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<link rel="stylesheet" href="css/summernote-lite.min.css"/>
</head>
<body>
<%
	BoardMemberVO mvo = (BoardMemberVO) session.getAttribute("mvo");
	Object obj = request.getAttribute("vo");

	if(obj != null){
		BoardVO vo = (BoardVO)obj;
%>
	<div id="bbs">
	<form action="Controller?type=edit" method="post" 
	encType="multipart/form-data">
	
		<input type="hidden" name="b_idx" value="${param.b_idx }"/>
		<input type="hidden" name="cPage" value="${param.cPage }"/>
		<input type="hidden" name="category" value="${requestScope.category }"/>
	
		<table summary="게시판 글쓰기">
			<caption>게시판 수정</caption>
			<tbody>
				<tr>
					<th>제목:</th>
					<td><input type="text" name="subject" 
						size="45" value="<%=vo.getSubject()%>"/></td>
				</tr>
				<tr>
					<th>이름:</th>
					<td><input type="text" name="writer"
					 size="12" value="<%=mvo.getM_name() %>" readonly/></td> <%-- 접속자 이름 --%>
				</tr>
			
				<tr>
					<th>첨부파일:</th>
					<td>
						<input type="file" name="file" id="file"/>
					<%
						if(vo.getFile_name() != null &&
							vo.getFile_name().trim().length()>4){
					%>
					(<%=vo.getFile_name() %>)
					<%		
						}
					%>	
						
					</td>
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
			rows="8" id="content"><%=vo.getB_content() %></textarea>
					</td>
				</tr>
			
				<tr>
					<td colspan="2">
						<input type="button" value="수정"
						onclick="editData()"/>
						<input type="button" value="취소"
							onclick="goView('${param.cPage}', '${param.b_idx }', '${requestScope.category }')"/>
					</td>
				</tr>
			</tbody>
		</table>	
	
	</div>
<%
	}
%>	
	
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/summernote-lite.min.js"></script>
	<script src="js/lang/summernote-ko-KR.min.js"></script>
	<script>
	
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

				$("#content").summernote(
					"editor.insertImage", data.url);
		
			}).fail(function(err){
				console.log(err);
			});
		}
		
		
		function editData(){
			
			var msg = confirm("수정하시겠습니까?");
			
			var str = $("#content").val();
			$("#str").val(str);

			if(msg){
				document.forms[0].submit();
			}
 
		}
		
		function goView(cPage, b_idx, category){
			location.href="Controller?type=view&cPage="+cPage+"&b_idx="+b_idx+"&category="+category;
		}
	</script>
</body>
</html>












    