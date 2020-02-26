package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;

public class MemberEditAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String m_id = request.getParameter("m_id");
		String m_idx = request.getParameter("m_idx");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String phone = null;
		String email = null;
		String[] par = request.getParameterValues("phone");
		String[] ear = request.getParameterValues("email");
		
		phone = par[0] + "-" + par[1] + "-" + par[2];
		email = ear[0] + "@" + ear[1];
		
		BoardMemberVO vo = new BoardMemberVO();
		
		vo.setM_idx(m_idx);
		vo.setPw(pw);
		vo.setM_name(name);
		vo.setPhone(phone);
		vo.setEmail(email);
		
		BbsDAO.updateMember(vo);
		
		//세션에 새로 저장
		BoardMemberVO mvo = BbsDAO.login(m_id, pw);
		HttpSession session = request.getSession();
		session.setAttribute("mvo", mvo);

		return "/myPage.jsp";
	}

}
