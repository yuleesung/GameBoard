package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bbs.util.Paging;
import mybatis.dao.BbsDAO;
import mybatis.vo.BoardVO;

public class SearchListAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		// 검색어 값 가져와서,
		String search_val = request.getParameter("search_val");
		
		// 맵퍼 호출하고, (게시물 숫자)
		int cnt = BbsDAO.getSearchAllCount(search_val);
		
		// 페이징 기법으로 셋팅
		Paging page = new Paging();
		
		page.setTotalRecord(cnt);
		
		String cPage = request.getParameter("cPage");
		
		if(cPage != null){
			int p = Integer.parseInt(cPage);
			page.setNowPage(p); 			
		}else 
			page.setNowPage(page.getNowPage());

		
		// 게시판에 나타낼 목록 받아오기
		BoardVO[] ar = BbsDAO.searchAll(String.valueOf(page.getBegin()), String.valueOf(page.getEnd()), search_val);
		
		// request에 저장
		request.setAttribute("search_val", search_val);
		request.setAttribute("ar", ar);
		request.setAttribute("cPage", cPage);
		request.setAttribute("page", page);
		
		
		return "/searchList.jsp";
	}
}
