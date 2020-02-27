<%@page import="mybatis.vo.BoardMemberVO"%>
<%@page import="mybatis.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link type="text/css" rel="stylesheet" href="css/main.css">

</head>
<%
	Object obj1 = request.getAttribute("ar_pc"); 
	Object obj2 = request.getAttribute("ar_ps"); 
	Object obj3 = request.getAttribute("ar_ns"); 
	BoardVO[] ar_pc = null;
	BoardVO[] ar_ps = null;
	BoardVO[] ar_ns = null;
	
	Object obj = session.getAttribute("mvo");
	
	String pc_content = null;
	String ps_content = null;
	String ns_content = null;
%>
<body bgcolor="#f7f7f7" onload="setImage()">
	<div id="wrap">
		
		<!-- include할 메뉴영역 시작 -->
		<div id="menu_bar" class="center"></div>
		<!-- include할 메뉴영역 끝 -->
		
		<!-- 메인 이미지 슬라이드 시작 -->
		<div class="main_img_box center">
			<span id="main_img"><img id="main_slide_img" alt="메인이미지슬라이드" src="css/images/main_slide_image_1.png"/></span>
			<span id="left_arrow" onclick="slideImg(0)"><img alt="left_arrow" src="css/images/left_arrow.png" width="50px"/></span>
			<span id="right_arrow" onclick="slideImg(1)"><img alt="right_arrow" src="css/images/right_arrow.png" width="50px"/></span>
		</div>
		<!-- 메인 이미지 끝 -->
		
		<!-- 중간 콘텐츠 시작 -->
		<div class="center_contents center">
			<div class="preview_contents">
				<div class="preview">
				<%
					if(obj1 != null){
						ar_pc = (BoardVO[])obj1;
						pc_content = ar_pc[0].getB_content();
				%>
					<span class="subject">
						<%=ar_pc[0].getSubject() %>
					</span><br>
					<span class="thum_img">
						<a href="" class="pre_src" id="pc_pre_content">
							<img id="pc_pre_image" alt="pc첫번째게시물이미지"
							 src="" class="pre_img"/>
						</a>
					</span><br>
					<span class="writer"><%=ar_pc[0].getBmvo().getM_name() %></span>
					<span class="more_view">
						<a href="javascript:location.href='Controller?type=view&b_idx=<%=ar_pc[0].getB_idx()%>&category=pc'">자세히보기</a>
					</span>
				<%
					}else{
				%>
					<span>게시물이 없습니다!</span>
				<%
					}
				%>
				</div>
				<div class="preview">
				<%
					if(obj2 != null){
						ar_ps = (BoardVO[])obj2;
						ps_content = ar_ps[0].getB_content();
				%>
					<span class="subject">
						<%=ar_ps[0].getSubject() %>
					</span><br>
					<span class="thum_img">
						<a href="" class="pre_src" id="ps_pre_content">
							<img id="ps_pre_image" alt="ps첫번째게시물이미지"
							 src="" class="pre_img"/>
						</a>
					</span><br>
					<span class="writer"><%=ar_ps[0].getBmvo().getM_name() %></span>
					<span class="more_view">
						<a href="javascript:location.href='Controller?type=view&b_idx=<%=ar_ps[0].getB_idx()%>&category=ps'">자세히보기</a>
					</span>
				<%
					}else{
				%>
					<span>게시물이 없습니다!</span>
				<%
					}
				%>
				</div>
				<div class="preview">
				<%
					if(obj3 != null){
						ar_ns = (BoardVO[])obj3;
						ns_content = ar_ns[0].getB_content();
				%>
					<span class="subject">
						<%=ar_ns[0].getSubject() %>
					</span><br>
					<span class="thum_img">
						<a href="" class="pre_src" id="ns_pre_content">
							<img id="ns_pre_image" alt="ns첫번째게시물이미지"
							 src="" class="pre_img"/>
						</a>
					</span><br>
					<span class="writer"><%=ar_ns[0].getBmvo().getM_name() %></span>
					<span class="more_view">
						<a href="javascript:location.href='Controller?type=view&b_idx=<%=ar_ns[0].getB_idx()%>&category=ns'">자세히보기</a>
					</span>
				<%
					}else{
				%>
					<span>게시물이 없습니다!</span>
				<%
					}
				%>
				</div>
				<div class="fclear"></div>
			</div>
			<div class="main_boards">
				<!-- 공지사항 -->
				<table class="board">
					<thead>
						<th>PC</th>
						<td><a href="javascript:location.href='Controller?type=list&category=pc'">더보기</a></td>
					</thead>
					<tbody>
						<%
						if(ar_pc != null){
							for(BoardVO vo : ar_pc){
						%>
						<tr>
							<td colspan="2"><a href="javascript:location.href='Controller?type=view&b_idx=<%=vo.getB_idx()%>&category=pc'"><%=vo.getSubject() %></a></td>
						</tr>
						<%
							}
						}
						%>
					</tbody>
				</table>
				<table class="board">
					<thead>
						<th>PlayStation</th>
						<td><a href="javascript:location.href='Controller?type=list&category=ps'">더보기</a></td>
					</thead>
					<tbody>
						<%
						if(ar_ps != null){
							for(BoardVO vo : ar_ps){
						%>
						<tr>
							<td colspan="2"><a href="javascript:location.href='Controller?type=view&b_idx=<%=vo.getB_idx()%>&category=ps'"><%=vo.getSubject() %></a></td>
						</tr>
						<%
							}
						}
						%>
					</tbody>
				</table>
				<table class="board">
					<thead>
						<th>NintendoSwitch</th>
						<td><a href="javascript:location.href='Controller?type=list&category=ns'">더보기</a></td>
					</thead>
					<tbody>
						<%
						if(ar_ns != null){
							for(BoardVO vo : ar_ns){
						%>
						<tr>
							<td colspan="2"><a href="javascript:location.href='Controller?type=view&b_idx=<%=vo.getB_idx()%>&category=ns'"><%=vo.getSubject() %></a></td>
						</tr>
						<%
							}
						}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 중간 콘텐츠 끝 -->
		
		
		<!-- 하단영역 시작 -->
		<div id="footer" class="footer"></div>
		<!-- 하단영역 끝 -->
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
	        $("#menu_bar").load("menu.jsp");
	        $("#footer").load("footer.jsp");
	     });
		
		function search(){
			var search_value = document.getElementById("search_value").value;
			alert("확인용메세지, 값 : " + search_value);
		}
		
		function slideImg(val){
			
			var img = document.getElementById("main_slide_img");
			
			var img_src = new Array();
			img_src[0] = "css/images/main_slide_image_1.png";
			img_src[1] = "css/images/main_slide_image_2.jpg";
			img_src[2] = "css/images/main_slide_image_3.png";
			
			var i=0;
			
			var src = img.src.substring(img.src.indexOf("css"), img.src.length);
			
			for(var j=0; j<img_src.length; j++){
				
				if(img_src[j] == src){
					i = j;
					break;
				}
			}
			
			if(val == 0){
				i--;
				if(i < 0)
					i = img_src.length-1;
			}else{
				i++;
				if(i > img_src.length-1)
					i = 0;
			}
			img.src = img_src[i];
		}
		
		function goLogin(){
			location.href="Controller?type=login&path=main";
		}
		
		function setImage(){
			var pc_content = '<%=pc_content%>'
			var ps_content = '<%=ps_content%>'
			var ns_content = '<%=ns_content%>'
			
			var i1 = pc_content.indexOf("img");
			if(i1 >= 0){
				pc_content = pc_content.substring(i1, pc_content.length);
				var i2 = pc_content.indexOf("\"");
				pc_content = pc_content.substring(i2 + 1, pc_content.length);
				var i3 = pc_content.indexOf("\"");
				pc_content = pc_content.substring(0, i3);
				
				document.getElementById("pc_pre_image").src = pc_content;
			}else{
				$("#pc_pre_content").html(pc_content);
			}
			
			i1 = ps_content.indexOf("img");
			if(i1 >= 0){
				ps_content = ps_content.substring(i1, ps_content.length);
				i2 = ps_content.indexOf("\"");
				ps_content = ps_content.substring(i2 + 1, ps_content.length);
				i3 = ps_content.indexOf("\"");
				ps_content = ps_content.substring(0, i3);
				
				document.getElementById("ps_pre_image").src = ps_content;
			}else{
				$("#ps_pre_content").html(ps_content);
			}
			
			i1 = ns_content.indexOf("img");
			if(i1 >= 0){
				ns_content = ns_content.substring(i1, ns_content.length);
				i2 = ns_content.indexOf("\"");
				ns_content = ns_content.substring(i2 + 1, ns_content.length);
				i3 = ns_content.indexOf("\"");
				ns_content = ns_content.substring(0, i3);
				
				document.getElementById("ns_pre_image").src = ns_content;
			}else{
				$("#ns_pre_content").html(ns_content);
			}
		}
	</script>
</body>
</html>










