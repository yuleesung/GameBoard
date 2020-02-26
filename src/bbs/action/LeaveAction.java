package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;

public class LeaveAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		boolean chk = false;
		
		// session에 저장 된 로그인 정보 가져오기
		HttpSession session = request.getSession();
		BoardMemberVO mvo = (BoardMemberVO) session.getAttribute("mvo"); 
		
		String pw = request.getParameter("pw");
		String m_idx = mvo.getM_idx();
		String mvo_pw = mvo.getPw();
		
		
		if(pw.equals(mvo_pw)) {
			chk = BbsDAO.delMember(m_idx, mvo_pw);
		}
		
		request.setAttribute("leave", chk);
		
		return "/leave.jsp";
	}

}
