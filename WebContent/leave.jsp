<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
boolean chk = (boolean)request.getAttribute("leave");

if(chk){
	session.removeAttribute("mvo");
%>
	{"res":"ok"}
<%	
}else{
%>
	{"res":"no"}
<%	
}
%>