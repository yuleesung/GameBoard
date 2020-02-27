package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardVO;

public class DeleteAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		String b_idx = request.getParameter("b_idx");
		String cPage = request.getParameter("cPage");
		String category = request.getParameter("category");
		
		BbsDAO.delPost(b_idx);
		
		BoardVO vo = BbsDAO.viewPost(b_idx);
		
		request.setAttribute("cPage", cPage);
		request.setAttribute("category", category);
		
		return "/Controller?type=list&cPage="+cPage+"&b_idx="+b_idx;
	}

}
