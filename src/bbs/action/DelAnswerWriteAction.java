package bbs.action;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardCommentVO;
import mybatis.vo.BoardVO;

public class DelAnswerWriteAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String c_idx = request.getParameter("c_idx");
		String b_idx = request.getParameter("b_idx");
		
		boolean chk = BbsDAO.delComment(c_idx);
		System.out.println(chk);
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
