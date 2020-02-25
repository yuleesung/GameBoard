<%@page import="java.io.BufferedOutputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.BufferedInputStream"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("utf-8");

	String fname = request.getParameter("f_name");
	
	
	String path = application.getRealPath(
		"/upload/"+fname);
	
	File f = new File(path);
	
	
	if(f.exists()){
		
		byte[] buf = new byte[2048]; //바구니
		int len = -1;
		
		
		BufferedInputStream bis = null;
		FileInputStream fis = null;
		
		
		BufferedOutputStream bos = null;
		ServletOutputStream sos = null;
		
		try{
			
			response.setContentType(
				"application/x-msdownload");
			response.setHeader(
				"Content-Disposition",
				"attachment;filename="+
				new String(fname.getBytes(), "8859_1"));
			
			fis = new FileInputStream(f);
			bis = new BufferedInputStream(fis);
			
			
			out.clear();
			out = pageContext.pushBody();
			
			sos = response.getOutputStream();
			bos = new BufferedOutputStream(sos);
			
			while((len = bis.read(buf)) != -1){
				
				bos.write(buf, 0, len);
				bos.flush();
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				if(fis != null)
					fis.close();
				if(bis != null)
					bis.close();
				if(sos != null)
					sos.close();
				if(bos != null)
					bos.close();
			}catch(Exception e){}
		}
		
		
	}
%>    










