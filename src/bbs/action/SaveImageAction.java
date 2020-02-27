package bbs.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class SaveImageAction implements MidAction{

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		ServletContext application = request.getServletContext();
		String path = application.getRealPath("/editor_img");
		
		File filepath = new File(path);
		if(!filepath.exists()) {
			filepath.mkdirs();
		}
		// System.out.println(path);
		MultipartRequest mr = null;
		try {
			mr = new MultipartRequest(request, path, 1024*1024*10, "utf-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			e.printStackTrace();
		}
		File f = mr.getFile("upload");
		String fname = null;
		if(f != null) {
			fname = f.getName();
		}
		//System.out.println(fname);
		
		request.setAttribute("cPath", request.getContextPath());
		request.setAttribute("fname", fname);
		
		return "/saveImage.jsp";
	}

}
