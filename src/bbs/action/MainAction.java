package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardVO;

public class MainAction implements MidAction {
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		BoardVO[] ar_pc = BbsDAO.getList("1", "3", "pc"); 
		BoardVO[] ar_ps = BbsDAO.getList("1", "3", "ps"); 
		BoardVO[] ar_ns = BbsDAO.getList("1", "3", "ns"); 
		
		request.setAttribute("ar_pc", ar_pc);
		request.setAttribute("ar_ps", ar_ps);
		request.setAttribute("ar_ns", ar_ns);
		
		return "/main.jsp";
	}
}
