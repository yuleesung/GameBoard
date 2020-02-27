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
				String s_category = null; 
				
				switch(category) {
				
					case "news":
						s_category = "뉴스";
						break;
					case "db": 
						s_category = "게임정보";
						break;
					case "free":
						s_category = "자유";
						break;
					case "qa":
						s_category = "Q&A";
						break;
					case "pc":
						s_category = "PC";
						break;
					case "ps":
						s_category = "PlayStation";
						break;
					case "ns":
						s_category = "Nintendo Switch";
						break;	
				}
				
				Paging page = new Paging();
				
				page.setTotalRecord(BbsDAO.getCount(category));
				
				String cPage = request.getParameter("cPage");
				
				if(cPage != null){
					int p = Integer.parseInt(cPage);
					page.setNowPage(p); 
					
				}else 
					page.setNowPage(page.getNowPage());
				//
				BoardVO[] ar = BbsDAO.getList(
					String.valueOf(page.getBegin()), String.valueOf(page.getEnd()), category);
				
				request.setAttribute("category", category);
				request.setAttribute("s_category", s_category);
				request.setAttribute("ar", ar);
				request.setAttribute("cPage", cPage);
				request.setAttribute("page", page);
				
				return "/list.jsp";
			}
	}


