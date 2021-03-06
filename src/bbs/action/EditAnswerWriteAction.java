package bbs.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardCommentVO;
import mybatis.vo.BoardVO;

public class EditAnswerWriteAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String content = request.getParameter("c_content");
		String ip = request.getRemoteAddr();
		String b_idx = request.getParameter("b_idx");
		String m_idx = request.getParameter("m_idx");
		String c_idx = request.getParameter("c_idx");
		
		BoardCommentVO vo = new BoardCommentVO();
		
		vo.setB_idx(b_idx);
		vo.setC_content(content);
		vo.setIp(ip);
		vo.setM_idx(m_idx);
		vo.setC_idx(c_idx);
		
		boolean chk = BbsDAO.updateComment(vo);
		
		BoardVO bvo = BbsDAO.viewPost(b_idx);
		List<BoardCommentVO> list = bvo.getBc_list();
		BoardCommentVO[] bc_list = null;
		if(!list.isEmpty()) {
			bc_list = new BoardCommentVO[list.size()];
			list.toArray(bc_list);
		}
		
		request.setAttribute("bc_list", bc_list);
		
		return "answer_write.jsp";
	}

}
