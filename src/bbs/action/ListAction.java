package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bbs.util.Paging;
import mybatis.dao.BbsDAO;
import mybatis.vo.BoardVO;

public class ListAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
	
				//카테고리 받아야함
				String category = request.getParameter("category");
		
				Paging page = new Paging();
				
				page.setTotalRecord(BbsDAO.getCount(category));
				
				String cPage = request.getParameter("cPage");
				
				if(cPage != null){
					int p = Integer.parseInt(cPage);
					page.setNowPage(p); 
					
					
				}else 
					page.setNowPage(page.getNowPage());
				
				BoardVO[] ar = BbsDAO.getList(
					String.valueOf(page.getBegin()), String.valueOf(page.getEnd()), category);
				
				
				request.setAttribute("ar", ar);
				request.setAttribute("page", page);
				
				return "/list.jsp";
			}
	}


