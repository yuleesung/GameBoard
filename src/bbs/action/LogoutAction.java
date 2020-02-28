package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.removeAttribute("mvo");
		
		String path = request.getParameter("path");
		String cPage = request.getParameter("cPage");
		String category = request.getParameter("category");
		String b_idx = request.getParameter("b_idx");
		
		String c_type = request.getContentType();
		
		if(c_type == null) {
			request.setAttribute("path", path);
			request.setAttribute("cPage", cPage);
			request.setAttribute("category", category);
			request.setAttribute("b_idx", b_idx);
		}else if(c_type != null && c_type.startsWith("application")){
			request.setAttribute("path", path);
			request.setAttribute("cPage", cPage);
			request.setAttribute("category", category);
			request.setAttribute("b_idx", b_idx);
		}
		
		return "/Controller?type="+path;
	}

}
