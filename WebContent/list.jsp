<%@page import="mybatis.vo.BoardVO"%>
<%@page import="bbs.util.Paging"%>
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
	
	#bbs table th,#bbs table td {
	    text-align:center;
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
	
	/* paging */
	
	table tfoot ol.paging {
	    list-style:none;
	}
	
	table tfoot ol.paging li {
	    float:left;
	    margin-right:8px;
	}
	
	table tfoot ol.paging li a {
	    display:block;
	    padding:3px 7px;
	    border:1px solid #00B3DC;
	    color:#2f313e;
	    font-weight:bold;
	}
	
	table tfoot ol.paging li a:hover {
	    background:#00B3DC;
	    color:white;
	    font-weight:bold;
	}
	
	.disable {
	    padding:3px 7px;
	    border:1px solid silver;
	    color:silver;
	}
	
	.now {
	   padding:3px 7px;
	    border:1px solid #ff4aa5;
	    background:#ff4aa5;
	    color:white;
	    font-weight:bold;
	}
	
	.empty{
		height: 60px;
	}
</style>		
</head>
<body>
			
	<%-- 메뉴들 와야함 --%>
		
	<div id="bbs">
		<table>
			<caption>게시판 제목</caption>
			<thead>
				<tr class="title">
					<th class = "no">No.</th>	
					<th class = "title">title</th>
					<%
						
					%>
					<th class = "writer">writer</th> <%-- 글쓴이는 로그인 했던 ID가 와야함 --%>
					<th class = "reg">date</th>
					<th class = "hit">hit</th>
				</tr>
			</thead>
			<tfoot>
				<%-- 페이징 --%>
				<tr>
					<td colspan ="4">
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
							<li><a href="control?type=list&cPage=<%=pvo.getNowPage()-pvo.getPagePerBlock()%>">&lt;</a></li>
<%		
							}	
							for(int i=pvo.getStartPage(); i<=pvo.getEndPage(); i++){							
								if(pvo.getNowPage() == i){
%>
							<li class="now"><%=i %></li>
<%			
								}else{
%>
							<li><a href="control?type=list&cPage=<%=i%>"><%=i %></a></li>
<%		
								}
						}
		
						if(pvo.getEndPage() < pvo.getTotalPage()){
%>
							<li><a href="control?type=list&cPage=<%=pvo.getNowPage()+pvo.getPagePerBlock()%>">&gt;</a></li>	
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
					<td>
						<input type = "button" value = "글쓰기"
								onclick="">					
					</td>
				</tr>	
			</tfoot>	
			<tbody>
				<%-- 리스트 뿌려줄 곳. --%>
				<%
					BoardVO[] ar = null;
					Object ar_obj = request.getAttribute("");
					
					if(ar_obj != null){ 
						ar = (BoardVO[])ar_obj;
					int i = 0;	
					for(BoardVO vo : ar){
						int num = pvo.getTotalRecord()-
								((pvo.getNowPage()-1)*pvo.getNumPerPage()+i);	
						%>			
						<tr>
							<td><%=num %></td>
							<td style="text-align: left">
								<a href="control?type=view&cPage=<%=pvo.getNowPage()%>&b_idx=<%=vo.getB_idx()%>">
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
							<td><%=vo.getWriter() %></td>
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
							<td colspan="5" class="empty">
								등록된 게시물이 없습니다.
							</td>
						</tr>
				<%		
					}
				%>
							</tbody>
			
			
			
		
		</table>
	</div>

</body>
</html>