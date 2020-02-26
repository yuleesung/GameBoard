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
%>
<body>
	<div id="wrap">
		<!-- 메인 로고 이미지 시작 -->
		<div class="main_logo center">
			<span>
				<a href="Controller?type=main"><img alt="메인로고" src=""/></a>
			</span>
		</div>
		<!-- 메인 로고 끝 -->
		
		<!-- 상위 이미지, 로그인 메뉴 시작 -->
		<%
		if(obj != null){
			BoardMemberVO mvo = (BoardMemberVO)obj;
		%>
		<div class="center">
			<div class="main_bar">
				<b><%=mvo.getM_name() %>님 환영합니다!</b>&nbsp;&nbsp;
				<a href="javascript:location.href='Controller?type=logout'">LOGOUT</a>
				<input type="text" id="search_value"/>
				<input type="button" value="검색" onclick="search()"/>
			</div>
		</div>
		<%
		}else{
		%>
		<div class="center">
			<div class="main_bar">
				<a href="javascript:location.href='Controller?type=login&path=main'">LOGIN</a>
				<a href="javascript:location.href='Controller?type=registry&path=main'">Registry</a>
				<input type="text" id="search_value"/>
				<input type="button" value="검색" onclick="search()"/>
			</div>
		</div>
		<%
		}
		%>
		<div class="center">
			<div class="main_img_box">
				<span id="main_img"><img alt="메인이미지슬라이드" src=""/></span>
				<span id="left_arrow" onclick="slideImg(0)"><img alt="left_arrow" src="css/images/left_arrow.png" width="50px"/></span>
				<span id="right_arrow" onclick="slideImg(1)"><img alt="right_arrow" src="css/images/right_arrow.png" width="50px"/></span>
			</div>
		</div>
		<!-- 상위 메뉴 끝 -->
		
		<!-- include할 메뉴영역 시작 -->
		<div id="menu_bar"></div>
		<!-- include할 메뉴영역 끝 -->
		
		<!-- 중간 콘텐츠 시작 -->
		<div class="center_contents center">
			<div class="preview_contents">
				<div class="preview">
				<%
					if(obj1 != null){
						ar_pc = (BoardVO[])obj1;
				%>
					<span class="subject">
						<%=ar_pc[0].getSubject() %>
					</span><br>
					<span class="thum_img">
						<a href="" class="pre_src">
							<img alt="pc첫번째게시물이미지"
							 src=""/>
						</a>
					</span><br>
					<span class="writer"><%=ar_pc[0].getBmvo().getM_name() %></span>
					<span class="more_view">
						<a href="javascript:location.href='Controller?type=view&b_idx=<%=ar_pc[0].getB_idx()%>'">자세히보기</a>
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
				%>
					<span class="subject">
						<%=ar_ps[0].getSubject() %>
					</span><br>
					<span class="thum_img">
						<a href="" class="pre_src">
							<img alt="ps첫번째게시물이미지"
							 src=""/>
						</a>
					</span><br>
					<span class="writer"><%=ar_ps[0].getBmvo().getM_name() %></span>
					<span class="more_view">
						<a href="javascript:location.href='Controller?type=view&b_idx=<%=ar_ps[0].getB_idx()%>'">자세히보기</a>
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
				%>
					<span class="subject">
						<%=ar_ns[0].getSubject() %>
					</span><br>
					<span class="thum_img">
						<a href="" class="pre_src">
							<img alt="ns첫번째게시물이미지"
							 src=""/>
						</a>
					</span><br>
					<span class="writer"><%=ar_ns[0].getBmvo().getM_name() %></span>
					<span class="more_view">
						<a href="javascript:location.href='Controller?type=view&b_idx=<%=ar_ns[0].getB_idx()%>'">자세히보기</a>
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
							<td colspan="2"><a href="javascript:location.href='Controller?type=view&b_idx=<%=vo.getB_idx()%>'"><%=vo.getSubject() %></a></td>
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
							<td colspan="2"><a href="javascript:location.href='Controller?type=view&b_idx=<%=vo.getB_idx()%>'"><%=vo.getSubject() %></a></td>
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
							<td colspan="2"><a href="javascript:location.href='Controller?type=view&b_idx=<%=vo.getB_idx()%>'"><%=vo.getSubject() %></a></td>
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
		<div class="footer">
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
		<!-- 하단영역 끝 -->
	</div>
	<script src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
	        $("#menu_bar").load("menu.jsp");
	     });
		
		function search(){
			var search_value = document.getElementById("search_value").value;
			alert("확인용메세지, 값 : " + search_value);
		}
		
		function slideImg(val){
			if(val == 0){
				alert("이미지 배열 감소");
			}else{
				alert("이미지 배열 증가")
			}
		}
	</script>
</body>
</html>










