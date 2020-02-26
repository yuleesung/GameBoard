<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
boolean chk = (boolean)request.getAttribute("leave");

if(chk){
%>
	{"res":"탈퇴 성공"}
<%	
}else{
%>
	{"res":"다시 입력"}
<%	
}
%>