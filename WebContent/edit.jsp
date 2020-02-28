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
<link rel="stylesheet" href="css/summernote-lite.min.css"/>
<link rel="stylesheet" href="css/menu.css"/>
<link rel="stylesheet" href="css/main.css"/>
<link rel="stylesheet" href="css/write.css"/>
<link rel="stylesheet" href="css/footer.css"/>
</head>
<body>
<%
	BoardMemberVO mvo = (BoardMemberVO) session.getAttribute("mvo");
	Object obj = request.getAttribute("vo");

	if(obj != null){//
		BoardVO vo = (BoardVO)obj;
%>
	<div id="wrap">
		<div id="menu_bar" class="center"></div>
		<div id="bbs">
			<header>
				<h2>게시글 수정</h2>
			</header>
			<form action="Controller?type=edit" method="post" 
			encType="multipart/form-data">
			
				<input type="hidden" name="b_idx" value="${param.b_idx }"/>
				<input type="hidden" name="cPage" value="${param.cPage }"/>
				<input type="hidden" name="category" value="${requestScope.category }"/>
			
				<table summary="게시판 글쓰기" id="t1">
					<caption>게시판 수정</caption>
					<tbody>
						<tr>
							<th>제목:</th>
							<td><input type="text" name="subject" 
								size="45" value="<%=vo.getSubject()%>"/></td>
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
	
			<table id="t2">
				<tbody>
					<tr>
						<th colspan="2">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</th>
					</tr>
					<tr>
						<td colspan="2"><textarea name="content" cols="50" 
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
		<div id="footer" class="footer"></div>
	</div>
<%
	}
%>	
	
	<script src="js/jquery-3.4.1.min.js"></script>
	<script src="js/summernote-lite.min.js"></script>
	<script src="js/lang/summernote-ko-KR.min.js"></script>
	<script>
	
		$(function(){
			$("#menu_bar").load("menu.jsp");
			$("#footer").load("footer.jsp");
			
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












    