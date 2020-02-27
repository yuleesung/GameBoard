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
	<%
		Object ob = session.getAttribute("mvo");
		BoardVO vo = null;
		List<BoardCommentVO> c_list = null;
		String cPage = (String)request.getAttribute("cPage");
		String category = (String)request.getAttribute("category");
	%>

	<%-- 본문  보기 영역--%>
	<div id = "bbs">
	<form method = "post">
		<table>
			<caption> 게시물 </caption>
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
					<td><%=vo.getWrite_date() %></td>
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
						<input type="button" value="수정" onclick="edit()"/>
						<input type="button" value="삭제" onclick="del()"/>
						<%
							}
						}
						%>	
						<input type="button" value="목록" onclick="goList()"/>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</form>
	<hr><br>
	
	<%-- 댓글 보여주는 영역 --%>
	<div id=answer>
	<%
	if(c_list != null){
		for(BoardCommentVO cvo : c_list){
	%>
			<span>
			<hr>
			<b>이름:</b>&nbsp;<%=cvo.getBmvo().getM_name() %>&nbsp;&nbsp;&nbsp;
			<b>날짜:</b>&nbsp;<%=cvo.getWrite_date() %><br/>
			<b>내용:</b>&nbsp;<%=cvo.getC_content() %><br>
			<hr>
			</span>
	<%
		}
	}
	%>
	</div>

	<hr>
	<%-- 댓글 쓰기 영역 --%>
	<form method="post" id="answer_form">
		<%
		if(ob != null){
			BoardMemberVO mvo = (BoardMemberVO)ob;
		%>
		이름:&nbsp;<%=mvo.getM_name() %><br>
		내용:<textarea rows="4" cols="55" name="comm"></textarea><br/>
		
		<input type="hidden" name="m_idx" value="<%=mvo.getM_idx()%>"/><br/>
		<input type="hidden" name="b_idx" value="<%=vo.getB_idx()%>">
		<input type="hidden" name="cPage" value="<%=cPage%>"/>
		<input type="hidden" name="category" value="<%=category%>"/>
		<input type="button" value="댓글달기" onclick="sendComment()" /> 
		<%
		}else{
		%>
		내용:<textarea rows="4" cols="55" onclick="goLogin('<%=vo.getB_idx()%>', '<%=cPage%>', '<%vo.getB_category();%>')" readonly="readonly">로그인이 필요합니다...</textarea><br/>
		<%
		}
		%>
	</form>
	
	
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
		document.frm.type.value = "edit";
		document.frm.submit();
	}
	
	function del(){
		document.frm.type.value = "delete";
		document.frm.submit();
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

	</script>
</body>
</html>