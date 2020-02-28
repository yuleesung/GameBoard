<%@page import="mybatis.vo.BoardCommentVO"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
[
<%
	Object obj = request.getAttribute("bc_list");
	BoardCommentVO[] bc_list = null;
	if(obj != null){
		bc_list = (BoardCommentVO[])obj;
		for(int i=0; i<bc_list.length; i++){
%>
	{
	"c_idx"	: "<%=bc_list[i].getC_idx() %>",
	"m_name" : "<%=bc_list[i].getBmvo().getM_name() %>", 
	"write_date" : "<%=bc_list[i].getWrite_date() %>",
	"content" : "<%=bc_list[i].getC_content() %>"
	}
<%
		if(i < bc_list.length-1)
			out.print(",");
		}
	}
%>
]