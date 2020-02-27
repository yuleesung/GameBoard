<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String cPath = (String) request.getAttribute("cPath");
	String fname = (String) request.getAttribute("fname");
%>

{
	"url":"<%=cPath %>/editor_img/<%=fname %>"

}