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
<link type="text/css" rel="stylesheet" href="css/view.css">
<link type="text/css" rel="stylesheet" href="css/main.css">
<link type="text/css" rel="stylesheet" href="css/menu.css">
<link rel="stylesheet" href="css/footer.css"/>


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
					<th>제목 : </th>
					<td><%=vo.getSubject() %></td>
					<th>날짜 : </th>
					<td><%=vo.getWrite_date().substring(0,10) %></td>
				</tr>
				<tr>
					<th>글쓴이  :  </th>
					<td><%=vo.getBmvo().getM_name() %></td> 
					<th>조회수 : </th>
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
					<th>내용 : </th>
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
	<table id=answer_table>
		<tbody>
	<%
	if(c_list != null){
		int i=0;
		for(BoardCommentVO cvo : c_list){
	%>
				<tr>
					<td style="width:125px;">
						<input type="hidden" name="c_idx" id="c_idx<%=i %>" value="<%=cvo.getC_idx()%>">
						<%=cvo.getBmvo().getM_name() %><br>
						<font size="2" color="lightgray">
						<%=cvo.getWrite_date().substring(0,19) %>
						</font>
					</td>
					<td style="width:400px;">
						<%=cvo.getC_content() %>
					</td>	
					<td>
					<%if(ob != null){ 
						BoardMemberVO mvo = (BoardMemberVO)ob;
						if(mvo.getM_idx().equals(cvo.getM_idx())){
					%>
						<a href="javascript:cEdit(<%=i %>)">[수정]</a>
						<a href="javascript:cDel(<%=i %>)">[삭제]</a>
					<%	}
					} %>
					</td>
				</tr>
	<%
			i++;
		}
	}
	%>
			</tbody>
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
					<td style="width:411px;">	
						<textarea id="comm" rows="4" cols="57" name="comm"></textarea><br/>
					</td>
					<td style="width:85px;">
						<input type="button" value="댓글달기" id="com_wr_bt" onclick="sendComment()" /> 
					</td>
				</tr>
		</tbody>
		</table>
		</form>
		<% 
		}else{
		%>
		<table>
			<tr>
				<td style="width:125px;">
				</td>			
				<td>
					<textarea rows="4" cols="48" onclick="goLogin('<%=vo.getB_idx()%>', '<%=cPage%>', '<%vo.getB_category();%>')" readonly="readonly">로그인이 필요합니다...</textarea><br/>
				</td>
			</tr>	
		</table>
				<%
		}
		%>
	

	
	</div>
	<div id="footer" class="footer"></div> 
	
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
		}else{
		%>
		<input type="hidden" name="cPage" value="1"/>
		<%} %>
	</form>

	

	<script src="js/jquery-3.4.1.min.js"></script>
	<script>
	var b_idx = frm.b_idx.value;
	var m_idx = frm.m_idx.value;
	var cPage = frm.cPage.value;
	var category = frm.category.value;
	var td = "";
	
	$("#footer").load("footer.jsp");
	
	
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
	
	function goLogin(){
        location.href="Controller?type=login&path=main";
     }
	
	function sendComment(){
		var frm = document.getElementById("answer_form");
		var comm = frm.comm;
		b_idx = frm.b_idx.value;
		m_idx = frm.m_idx.value;
		cPage = frm.cPage.value;
		category = frm.category.value;
		
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
				msg += "<tr>";
				msg += "<td style='width:125px;'>";
				msg += "<input type='hidden' name='c_idx' id='c_idx"+i+"' value='"+data[i].c_idx+"'/>"+ data[i].m_name +"<br/>";
				msg += "<font size='2' color='lightgray'>"+ data[i].write_date.substring(0,19) +"</font></td>";
				msg += "<td style ='width:400px;'>"+data[i].content +"</td>";
				msg += "<td><a href='javascript:cEdit("+i+")'>[수정]</a> <a href='javascript:cDel("+i+")'>[삭제]</a></td>"
				msg += "</tr>";
				
			}
			$("#answer_table>tbody").html(msg);
			
			comm.value = "";
		}).fail(function(err) {
			console.log(err);
		});
	}

	$(document).ready(function(){
        $("#menu_bar").load("menu.jsp");
     });
	
	
	$("#cDel").bind("click", function() {
			location.href="Controller?";	
		
	});
	

	function cEdit(cnt){
		//var chk = confirm("수정 하시겠습니까?");
		
        var tr = document.getElementById("answer_table").children[0].children[cnt].children[1];
        var tr1 = document.getElementById("answer_table").children[0].children[cnt].children[2];
        
        td = tr.innerText;
        tr.innerHTML = "<textarea id='c_comm"+cnt+"' cols='53'>"+td+"</textarea>";
        document.getElementById("c_comm"+cnt).select();
        tr1.innerHTML = "<a href='javascript:cEdit_save("+cnt+")'>[저장]</a> <a href='javascript:cEdit_cancel("+cnt+")'>[취소]</a>";
	}
	
	function cEdit_save(cnt, td) {
		var chk = confirm("수정하시겠습니까?");
		
		if(chk){
			var c_content = $("#c_comm"+cnt).val().trim();
			var c_idx = $("#c_idx"+cnt).val();
			
			var param = "type=edit_answer_write&c_content=" + encodeURIComponent(c_content)
			+ "&b_idx=" + encodeURIComponent(b_idx)
			+ "&m_idx=" + encodeURIComponent(m_idx)
			+ "&cPage=" + encodeURIComponent(cPage)
			+ "&category=" + encodeURIComponent(category)
			+ "&c_idx="+ encodeURIComponent(c_idx);
			
			$.ajax({
				url : "Controller",
				type : "post",
				data : param,
				dataType: "json"
			}).done(function(data) {
				
				var msg = "";
				
				for(var i=0; i<data.length; i++){
					msg += "<tr>";
					msg += "<td style='width:125px;'>";
					msg += "<input type='hidden' name='c_idx' id='c_idx"+i+"' value='"+data[i].c_idx+"'/>"+ data[i].m_name +"<br/>";
					msg += "<font size='2' color='lightgray'>"+ data[i].write_date.substring(0,19) +"</font></td>";
					msg += "<td style ='width:400px;'>"+data[i].content +"</td>";
					msg += "<td><a href='javascript:cEdit("+i+")'>[수정]</a> <a href='javascript:cDel("+i+")'>[삭제]</a></td>"
					msg += "</tr>";
					
				}
				$("#answer_table>tbody").html(msg);
				
			}).fail(function(err) {
				console.log(err);
			});
		}
	}
	
	function cEdit_cancel(cnt) {
		document.getElementById("answer_table").children[0].children[cnt].children[1].innerText = td;
		document.getElementById("answer_table").children[0].children[cnt].children[2].innerHTML = 
			"<a href='javascript:cEdit("+cnt+")'>[수정]</a> <a href='javascript:cDel("+cnt+")'>[삭제]</a></td>";
	}
	
	function cDel(cnt){
		
		var chk = confirm("삭제하시겠습니까?");
		
		if(chk){
			var c_idx = $("#c_idx"+cnt).val();
			
			var param = "type=del_answer_write&c_idx="+ encodeURIComponent(c_idx)+"&b_idx="+encodeURIComponent(b_idx);
			
			$.ajax({
				url : "Controller",
				type : "post",
				data : param,
				dataType: "json"
			}).done(function(data) {
				
				var msg = "";
				
				for(var i=0; i<data.length; i++){
					msg += "<tr>";
					msg += "<td style='width:125px;'>";
					msg += "<input type='hidden' name='c_idx' id='c_idx"+i+"' value='"+data[i].c_idx+"'/>"+ data[i].m_name +"<br/>";
					msg += "<font size='2' color='lightgray'>"+ data[i].write_date.substring(0,19) +"</font></td>";
					msg += "<td style ='width:400px;'>"+data[i].content +"</td>";
					msg += "<td><a href='javascript:cEdit("+i+")'>[수정]</a> <a href='javascript:cDel()'>[삭제]</a></td>"
					msg += "</tr>";
					
				}
				$("#answer_table>tbody").html(msg);
				
			}).fail(function(err) {
				console.log(err);
			});
		}
		
	}
	
	function goLogin(){
		location.href="Controller?type=login&path=view&cPage="+cPage+"&b_idx="+b_idx+"&category="+category;
	}
	function goLogout(){
		location.href="Controller?type=logout&path=view&cPage="+cPage+"&b_idx="+b_idx+"&category="+category;
	}
	
	</script>
</body>
</html>