<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
boolean chk = (boolean)request.getAttribute("idcheck");


if(chk){
%>
	{"res":"사용 가능"}
<%
}else{
%>
	{"res":"사용 불가"}
<%
}
%>