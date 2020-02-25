<%@page import="mybatis.vo.BoardVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main</title>
<link type="text/css" rel="stylesheet" href="main.css">
</head>
<%
	Object obj1 = request.getAttribute("ar_pc"); 
	Object obj2 = request.getAttribute("ar_ps"); 
	Object obj3 = request.getAttribute("ar_ns"); 
	BoardVO[] ar_pc = null;
	BoardVO[] ar_ps = null;
	BoardVO[] ar_ns = null;
%>
<body>
	<div id="wrap">
		<!-- 상위 이미지, 로그인 메뉴 시작 -->
		<div class="center">
			<h1>게임정보게시판</h1>
			<div class="main_bar">
				<a href="">LOGIN</a>
				<a href="">Registry</a>
				<input type="text" id="search_value"/>
				<input type="button" value="검색" onclick="search()"/>
			</div>
			<div class="main_img">
				<img alt="메인이미지슬라이드" src=""/>
			</div>
		</div>
		<!-- 상위 메뉴 끝 -->
		
		<!-- include할 메뉴영역 시작 -->
		<div class="header center">
			<ul class="gnb">
				<li><a href=""><span class="menu m01">뉴스</span></a></li>
				<li><a href=""><span class="menu m02">게임정보</span></a></li>
				<li><a href=""><span class="menu m03">자유게시판</span></a></li>
				<li><a href=""><span class="menu m04">Q&A</span></a></li>
			</ul>
		</div>
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
					<span class="writer"><%=ar_pc[0].getWriter() %></span>
					<span class="more_view">
						<a href="javascript:location.href='control?type=view&b_idx=<%=ar_pc[0].getB_idx()%>'">자세히보기</a>
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
					<span class="writer"><%=ar_ps[0].getWriter() %></span>
					<span class="more_view">
						<a href="javascript:location.href='control?type=view&b_idx=<%=ar_ps[0].getB_idx()%>'">자세히보기</a>
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
					<span class="writer"><%=ar_ns[0].getWriter() %></span>
					<span class="more_view">
						<a href="javascript:location.href='control?type=view&b_idx=<%=ar_ns[0].getB_idx()%>'">자세히보기</a>
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
						<th><a href="javascript:location.href='control?type=list&category=pc'">더보기</a></th>
					</thead>
					<tbody>
						<%
						if(ar_pc != null){
							for(BoardVO vo : ar_pc){
						%>
						<tr>
							<td colspan="2"><a href="javascript:location.href='control?type=view&b_idx=<%=vo.getB_idx()%>'"><%=vo.getSubject() %></a></td>
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
						<th><a href="javascript:location.href='control?type=list&category=ps'">더보기</a></th>
					</thead>
					<tbody>
						<%
						if(ar_ps != null){
							for(BoardVO vo : ar_ps){
						%>
						<tr>
							<td colspan="2"><a href="javascript:location.href='control?type=view&b_idx=<%=vo.getB_idx()%>'"><%=vo.getSubject() %></a></td>
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
						<th><a href="javascript:location.href='control?type=list&category=ns'">더보기</a></th>
					</thead>
					<tbody>
						<%
						if(ar_ns != null){
							for(BoardVO vo : ar_ns){
						%>
						<tr>
							<td colspan="2"><a href="javascript:location.href='control?type=view&b_idx=<%=vo.getB_idx()%>'"><%=vo.getSubject() %></a></td>
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
	<script type="text/javascript">
		function search(){
			var search_value = document.getElementById("search_value").value;
			alert("확인용메세지, 값 : " + search_value);
		}
	</script>
</body>
</html>










