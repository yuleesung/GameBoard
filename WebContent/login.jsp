<%@page import="mybatis.vo.BoardMemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BoardMemberVO mvo = (BoardMemberVO)session.getAttribute("mvo");

if(mvo!=null){
%>
	{"res":"ok"}
<%
}else{
%>
	{"res":"no"}
<%	
}
%>