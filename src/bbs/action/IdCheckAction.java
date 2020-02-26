package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;


public class IdCheckAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		Boolean chk = false;	
		String s_id = null;
		
		String id = request.getParameter("id");
		s_id = BbsDAO.matchMember(id);
		
		if(s_id == null) {
			chk = true;
			request.setAttribute("idcheck", chk);
		}else {
			request.setAttribute("idcheck", chk);
		}
		
		return "/idcheck.jsp";
	}

}
