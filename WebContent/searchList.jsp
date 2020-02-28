<%@page import="mybatis.vo.BoardMemberVO"%>
<%@page import="mybatis.vo.BoardVO"%>
<%@page import="bbs.util.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link type="text/css" rel="stylesheet" href="css/list.css"/>
<link type="text/css" rel="stylesheet" href="css/footer.css"/>
</head>
<body>
<div id="wrap">	


<div id="menu_bar" class="center"></div>

	<%-- 메뉴들 와야함 --%>
<%
String search_val = (String)request.getAttribute("search_val");
%>
	<div id="bbs">
		<table id="searchlist_table">
			<caption>검색결과 : <%=search_val %></caption>
			<thead>
				<tr class="title">
					<th class = "no">번호</th>
					<th class = "category">카테고리</th>	
					<th class = "title">제목</th>
					<th class = "writer1">글쓴이</th>
					<th class = "reg">날짜</th>
					<th class = "hit">조회수</th>
				</tr>
			</thead>
			<tfoot>
				<%-- 페이징 --%>
				<tr>
					<td colspan ="6">
						<ol>
<%
						Object obj = request.getAttribute("page");
						Paging pvo = null;
						if(obj != null){
							pvo = (Paging)obj;
								
							if(pvo.getStartPage() < pvo.getPagePerBlock()){			
%>
							<li class="disable">&lt;</li>
<%		
								}else{
%>
							<li><a href="Controller?type=searchlist&cPage=<%=pvo.getNowPage()-pvo.getPagePerBlock()%>">&lt;</a></li>
<%		
							}	
							for(int i=pvo.getStartPage(); i<=pvo.getEndPage(); i++){							
								if(pvo.getNowPage() == i){
%>
							<li class="now"><%=i %></li>
<%			
								}else{
%>
							<li><a href="Controller?type=searchlist&cPage=<%=i%>&search_val=<%=search_val %>"><%=i %></a></li>
<%		
								}
						}
		
						if(pvo.getEndPage() < pvo.getTotalPage()){
%>
							<li><a href="Controller?type=searchlist&cPage=<%=pvo.getNowPage()+pvo.getPagePerBlock()%>">&gt;</a></li>	
<%		
						}else{
%>
							<li class="disable">&gt;</li>
<%		
						}
					}		
%>             
						</ol>
					</td>
				</tr>	
			</tfoot>	
			<tbody>
				<%-- 리스트 뿌려줄 곳. --%>
				<%
				BoardVO[] ar = null;
				Object ar_obj = request.getAttribute("ar");
				
				if(ar_obj != null){ 
					ar = (BoardVO[])ar_obj;
				int i = 0;							
				
				for(BoardVO vo : ar){
					int num = pvo.getTotalRecord()-((pvo.getNowPage()-1)*pvo.getNumPerPage()+i);
					String category = vo.getB_category();
					String s_category = null;
					
					switch(category) {				
					case "news":
						s_category = "뉴스";
						break;
					case "db": 
						s_category = "게임정보";
						break;
					case "free":
						s_category = "자유";
						break;
					case "qa":
						s_category = "Q&A";
						break;
					case "pc":
						s_category = "PC";
						break;
					case "ps":
						s_category = "PlayStation";
						break;
					case "ns":
						s_category = "NS";
						break;	
				}
						%>
						<tr id="search_tr">
							<td><%=num %></td>
							<td><%=s_category %></td>
							<td style="text-align: left">
								<a href="Controller?type=view&cPage=<%=pvo.getNowPage()%>&b_idx=<%=vo.getB_idx()%>&category=<%=vo.getB_category() %>">
									<%=vo.getSubject() %>
									<%
										if(vo.getBc_list().size() > 0){
									%>
										(<%=vo.getBc_list().size() %>)
									<%		
										}
									%>	
								</a>
								
								
							</td>
							<td><%=vo.getBmvo().getM_id() %></td> <%-- 게시물 작성자 아이디 --%>
							<td>
							<%
								if(vo.getWrite_date() != null)
									out.println(vo.getWrite_date().substring(0,10));
							%>	
							</td>
							<td><%=vo.getHit() %></td>
						</tr>
				<%
							++i;
						}//for의 끝
						
					}else{
				%>
						<tr>
							<td colspan="6" class="empty">
								등록된 게시물이 없습니다.
							</td>
						</tr>
				<%	
					}
				
				%>
			</tbody>
		</table>
	</div>
</div>
<div id="footer" class="footer"></div>

<script src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    $("#menu_bar").load("menu.jsp");
    $("#footer").load("footer.jsp");
 });
</script>
</body>
</html>