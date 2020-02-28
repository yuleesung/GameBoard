package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;

public class LoginAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String c_type = request.getContentType(); 
		// get방식일 땐, null
		// post방식일 땐, application or encType..
		String viewPath = "/loginPage.jsp";
		
		
		String path = request.getParameter("path");
		String cPage = request.getParameter("cPage");
		String category = request.getParameter("category");
		String b_idx = request.getParameter("b_idx");
		
		if(c_type == null) { // get방식 요청
			request.setAttribute("path", path);
			request.setAttribute("cPage", cPage);
			request.setAttribute("category", category);
			request.setAttribute("b_idx", b_idx);
			
		}else if(c_type.startsWith("application")) { // post방식 요청
			// 로그인 액션
			String id = request.getParameter("id");
			String pw = request.getParameter("pw");
			
			BoardMemberVO mvo = BbsDAO.login(id, pw);
			
			HttpSession session = request.getSession();
			request.getSession(); session.setAttribute("mvo", mvo);
			
			request.setAttribute("path", path);
			request.setAttribute("cPage", cPage);
			request.setAttribute("category", category);
			request.setAttribute("b_idx", b_idx);
			
			viewPath = "/login.jsp";
		}
		
		return viewPath;
	}

}
