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
		// 로그인 액션
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		BoardMemberVO mvo = BbsDAO.login(id, pw);
		
		/*
		 * if(mvo!=null) { // 접속성공 시, 멤버정보 세션에 저장 후 메인화면으로 이동 HttpSession session =
		 * request.getSession(); session.setAttribute("mvo", mvo); }
		 */
		
		return "/login.jsp";
	}

}
