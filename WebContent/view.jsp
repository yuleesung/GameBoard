<%@page import="mybatis.vo.BoardMemberVO"%>
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
<link type="text/css" rel="stylesheet" href="css/main.css">
<link type="text/css" rel="stylesheet" href="css/menu.css">
<style type="text/css">


	body{
		background-color: #C6E5F3;
	}

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
	    background-color: white;
	}
	
	th{
		height: 40px;
		color: #353866;
		font-family: ‘Roboto’, ‘Spoqa Han Sans’, ‘Spoqa Han Sans JP’, ‘Sans-serif’; 
		font-size: 18px;
		font-weight: 700;
		background-color: #d9e1e8;
	}
	
	
	
	#goList1, #del1, #edit1{
		width:50px;
	    background-color: #2b90d9;
	    border: none;
	    color:#fff;
	    padding: 6px 0;
	    text-align: center;
	    text-decoration: none;
	    display: inline-block;
	    font-size: 15px;
	    margin: 4px;
	    cursor: pointer;
		border-radius:10px;
		
	}
	
	
	form#answer_form table{
		border: 1px solid #dddddd;
		border-collapse:collapse;
	}
	
	
	
		#bbs table {
	    width:640px;
	   	margin: auto;
	    
	    border-collapse:collapse;
	    font-size:14px;
	}
	
	#answer{
		width: 640px;
		margin: auto;
		background-color: #ffffff;
		
	}	
	
	
	#answer_write{
		width: 640px;
		margin: auto;
		padding: 0;
		background-color: #ffffff;
		 border-collapse:collapse;
	}	
		
	##bbs td{
		border:1px solid #dddddd;
		background-color: #ffffff;
	}
		
	#write_form{
		margin-top: 70px;
	}	
	#com_wr_bt{
	width:70px;
	    background-color: #2b90d9;
	    border: none;
	    color:#fff;
	    padding: 6px 0;
	    text-align: center;
	    text-decoration: none;
	    display: inline-block;
	    font-size: 15px;
	    margin: 4px;
	    cursor: pointer;
		border-radius:10px;
	}
	
	#answer_write tr{
		border:1px solid #eeeeee;
		
	
	}
	
	#answer_form{
		margin: 0;
		padding: 0;
	}
	#t1{
		margin: 0;
		padding: 0;
	}
	

	
</style>
</head>
<body>
	<%
		Object ob = session.getAttribute("mvo");
		BoardVO vo = null;
		List<BoardCommentVO> c_list = null;
		String cPage = (String)request.getAttribute("cPage");
		String category = (String)request.getAttribute("category");
	%>
	
	<div id="menu_bar" class="center"></div>	

	<%-- 본문  보기 영역--%>
	<div id = "bbs">
	<form method = "post" id="write_form">
		<table>
			<tbody>
				<%
					Object obj = request.getAttribute("vo");
	
					if(obj != null){
						vo = (BoardVO)obj;
						c_list = vo.getBc_list();
				%>
				<tr>
					<th>Title : </th>
					<td><%=vo.getSubject() %></td>
					<th>Date : </th>
					<td><%=vo.getWrite_date().substring(0,10) %></td>
				</tr>
				<tr>
					<th>Writer : </th>
					<td><%=vo.getBmvo().getM_name() %></td> 
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
					<a href="javascript: fDown('<%=vo.getFile_name()%>','<%=vo.getBmvo().getM_idx()%>')">
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
					<td colspan="3"><pre><%=vo.getB_content() %></pre></td>	
				</tr>
				<tr>
					<td colspan="4">
						<%
						if(ob != null){ //로그인했을 때
							BoardMemberVO mvo = (BoardMemberVO)ob;
							if(mvo.getM_idx().equals(vo.getBmvo().getM_idx())){
						%>
						<input type="button" value="수정" id="edit1" onclick="edit()"/>
						<input type="button" value="삭제" id="del1" onclick="del()"/>
						<%
							}
						}
						%>	
						<input type="button" value="목록" id="goList1" onclick="goList()"/>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</form>
	<br>
	</div>
	
	<%-- 댓글 보여주는 영역 --%>
	<div id=answer>
	<%
	if(c_list != null){
		for(BoardCommentVO cvo : c_list){
	%>
		<table>
			<tr>
				<td style="width:125px;">
					<%=cvo.getBmvo().getM_name() %><br>
					<font size="2" color="lightgray">
					<%=cvo.getWrite_date().substring(0,19) %>
					</font>
				</td>
				<td>
					<%=cvo.getC_content() %>
				</td>	
			</tr>
			
	<%
		}
	}
	%>
		</table>
	</div>


	<%-- 댓글 쓰기 영역 --%>
	<div id="answer_write">
	
		<%
		if(ob != null){
			BoardMemberVO mvo = (BoardMemberVO)ob;
		%>
		<form method="post" id="answer_form">
		<input type="hidden" name="m_idx" value="<%=mvo.getM_idx()%>"/><br/>
		<input type="hidden" name="b_idx" value="<%=vo.getB_idx()%>">
		<input type="hidden" name="cPage" value="<%=cPage%>"/>
		<input type="hidden" name="category" value="<%=category%>"/>
		<table id="t1">
			<tbody>
				<tr>
					<td style="width:125px;">
						&nbsp;<%=mvo.getM_name() %>
					</td>
					<td>	
						<textarea rows="4" cols="60" name="comm"></textarea><br/>
					</td>
					<td>
						<input type="button" value="댓글달기" id="com_wr_bt" onclick="sendComment()" /> 
					</td>
				</tr>
		</tbody>
		</table>
		</form>
		<% 
		}else{
		%>
		내용:<textarea rows="4" cols="45" onclick="goLogin('<%=vo.getB_idx()%>', '<%=cPage%>', '<%vo.getB_category();%>')" readonly="readonly">로그인이 필요합니다...</textarea><br/>
		<%
		}
		%>
	
	</div>
	
	
	<form action="Controller" name="frm" method="post">		
		<input type="hidden" name="type"/>
		<input type="hidden" name="f_name"/>
		<input type="hidden" name="m_idx"/>
		<input type="hidden" name="b_idx" value="<%=vo.getB_idx() %>">
		<input type="hidden" name="category" value="<%=category%>"/>
		<%
		if(cPage != null){
		%>
		<input type="hidden" name="cPage" value="<%=cPage%>"/>
		<%
		}
		%>
	</form>

	<script src="js/jquery-3.4.1.min.js"></script>
	<script>

	function fDown(fname,m_idx){
		document.frm.type.value = "down";
		document.frm.f_name.value = fname;
		document.frm.m_idx.value= m_idx;
		document.frm.submit();
	} 
	
	function goList(){
		document.frm.type.value = "list";
		document.frm.submit();
	}
	
	function edit(){
		var chk = confirm("수정 하시겠습니까?");
		if(chk){
			document.frm.type.value = "edit";
			document.frm.submit();
		}
	}
	
	function del(){
		var chk = confirm("삭제 하시겠습니까?");
		if(chk){
			document.frm.type.value = "delete";
			document.frm.submit();
		}
	}
	
	function goLogin(b_idx, cPage, category){
		var chk = confirm("로그인 하시겠습니까?");
		if(chk)
			location.href="Controller?type=login&b_idx="+b_idx+"&cPage="+cPage+"&category="+category+"&path=view";
	}
	
	function sendComment(){
		var frm = document.getElementById("answer_form");
		var comm = frm.comm;
		var b_idx = frm.b_idx.value;
		var m_idx = frm.m_idx.value;
		var cPage = frm.cPage.value;
		var category = frm.category.value;
		
		if(comm.value.trim() <= 0){
			alert("내용을 입력해주세요");
			comm.focus();
			return;
		}
		
		var param = "type=answer_write&comm=" + encodeURIComponent(comm.value)
		+ "&b_idx=" + encodeURIComponent(b_idx)
		+ "&m_idx=" + encodeURIComponent(m_idx)
		+ "&cPage=" + encodeURIComponent(cPage)
		+ "&category=" + encodeURIComponent(category);
		
		$.ajax({
			url : "Controller",
			type : "post",
			data : param,
			dataType: "json"
		}).done(function(data) {
			var msg = "";
			for(var i=0; i<data.length; i++){
				msg += "<span><hr>";
				msg += "<b>이름:</b>&nbsp;"+ data[i].m_name +"&nbsp;&nbsp;&nbsp;";
				msg += "<b>날짜:</b>&nbsp;"+ data[i].write_date +"<br/>";
				msg += "<b>내용:</b>&nbsp;"+ data[i].content +"<br/></span>";
			}
			
			$("#answer").html(msg);
			comm.value = "";
		}).fail(function(err) {
			console.log(err);
		});
	}

	$(document).ready(function(){
        $("#menu_bar").load("menu.jsp");
     });
	
	
	</script>
</body>
</html>