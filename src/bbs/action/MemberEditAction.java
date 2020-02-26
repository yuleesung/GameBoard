package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;

public class MemberEditAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String phone = null;
		String email = null;
		String[] par = request.getParameterValues("phone");
		String[] ear = request.getParameterValues("email");
		
		phone = par[0] + "-" + par[1] + "-" + par[2];
		email = ear[0] + "@" + ear[1];
		
		BoardMemberVO vo = new BoardMemberVO();
		
		vo.setPw(pw);
		vo.setM_name(name);
		vo.setPhone(phone);
		vo.setEmail(email);
		
		BbsDAO.updateMember(vo);

		return "/myPage.jsp";
	}

}
