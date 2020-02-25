<%@page import="java.util.List"%>
<%@page import="mybatis.vo.BoardCommentVO"%>
<%@page import="com.sun.xml.internal.ws.server.sei.EndpointResponseMessageBuilder.Bare"%>
<%@page import="mybatis.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="e" uri="http://java.sun.com/jsp/jstl/core" %>  
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
	
	
	#del_win{
		display: none;
	}
		
</style>
</head>
<body>
	<%-- 본문  보기 영역--%>
	<div id = "bbs">
	<form method = "post">
		<table>
			<caption> 게시물 </caption>
			<tbody>
				<%
					Object obj = request.getAttribute("vo");
	
					if(obj != null){
						BoardVO vo = (BoardVO)obj;
					
				%>
				<tr>
					<th>Title : </th>
					<td><%=vo.getSubject() %></td>
					<th>Date : </th>
					<td><%=vo.getWrite_date() %></td>
				</tr>
				<tr>
					<th>Writer : </th>
					<td><%= %></td> <%--로그인 아이디 들어가야함 --%>
					<th>Hit : </th>
					<td><%=vo.getHit() %></td>
				</tr>
				<tr>
					<th>첨부파일 : </th>
					<td colspan ="3">
					<%
						if(vo.getFile_name() != null &&
						vo.getFile_name().length() > 4){
					%>
					<a href="javascript: fDown('<%=vo.getFile_name()%>')">
						<%=vo.getFile_name() %>
						(<%=vo.getOri_name() %>)
					</a>
					<%
						}
					%>
					</td>
				</tr>
				<tr>
					<th> 내용 : </th>
					<td colspan="3"><pre><%=vo.getContent() %></pre></td>	
				</tr>
				<tr>
					<td colspan="4">
						<input type="button" value="Edit"
							onclick="edit()"/>
						<input type="button" value="Delete" 
							id="del_btn"/>
						<input type="button" value="List"
							onclick="goList()"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>


	<%-- 댓글 쓰기 영역 --%>
	<form method="post" action="ans_write.jsp">
		이름:<input type="text" name="writer"/><br/>
		내용:<textarea rows="4" cols="55" name="content"></textarea><br/>
		비밀번호:<input type="password" name="pwd"/><br/>
		
		
		<input type="hidden" name="b_idx" value="${param.b_idx }">
		<input type="hidden" name="cPage" value="${cPage }"/>
		<input type="hidden" name="ip" 
			value="<%=request.getRemoteAddr()%>"/>
		<input type="submit" value="저장하기"/> 
	</form>
	
	
	
	<%-- 댓글 보기 영역 --%>
<%
		List<BoardCommentVO> c_list = vo.getBc_list();
		for(BoardCommentVO cvo:c_list){
%>	
		<hr/><hr/>
		<div>
			이름: <%=cvo.getWriter() %> &nbsp;&nbsp;
			날짜: <%=cvo.getWrite_date() %><br/>
			내용: <%=cvo.getContent() %>
		</div>
		<hr/><hr/>
	
<%
		}
	}else{
		response.sendRedirect("control");
	}
	
%>
	</div>
	<form action="control" name="frm" method="post">		
		<input type="hidden" name="type"/>
		<input type="hidden" name="f_name"/>
		<input type="hidden" name="b_idx" value="${param.b_idx }">
		<input type="hidden" id="cPage" name="cPage" value="${cPage }"/>
	</form>
	
	
	<div id="del_win">
		<form>
			<input type="hidden" name="b_idx" id="b_idx"
				value="${param.b_idx }"/>
			<label for="pw">비밀번호:</label>
			<input type="password" id="pw" name="pw"/>
			<br/>
			<button type="button" id="delete_bt">삭제</button>
			<button type="button" id="close_bt">닫기</button>
		</form>
	</div>


	<script src="js/jquery-3.4.1.min.js"></script>
	<script>
	$(function(){
		
		$("#del_btn").bind("click",function(){
			$("#del_win").css("display","block");
			$("#del_win").dialog();
		});
		
		$("#close_bt").bind("click",function(){
			
			$("#del_win").dialog("close");
		});
		
		$("#delete_bt").bind("click",function(){
			var b_idx = $("#b_idx").val();
			var pw = $("#pw").val();
			
			
			var param = "type=del&b_idx="+encodeURIComponent(b_idx)+
				"&pw="+encodeURIComponent(pw);
			
			$.ajax({
				url: "control",
				type: "post",
				data: param,
				dataType: "json"
			}).done(function(data){
				
				if(data.value == "true")
					location.href = "control?type=list&cPage=${cPage }";
				else{						
					alert("비밀번호가 다릅니다.");
				}
			}).fail(function(err){
				
			});
			
		});
	});

	function fDown(fname){
		
		document.frm.type.value = "down";
		document.frm.f_name.value = fname;
		document.frm.submit();
	}
	
	function goList(){
		document.frm.type.value = "list";
		document.frm.submit();
	}
	
	function edit(){
		document.frm.type.value = "edit";
		document.frm.submit();
	}
		
		
	
	
	</script>
	


</body>
</html>