package bbs.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardVO;

public class ViewAction implements	MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		

			
		
		String cPage = request.getParameter("cPage");
		String b_idx = request.getParameter("b_idx");

		
		BoardVO vo = BbsDAO.viewPost(b_idx);
		
		HttpSession session = request.getSession();
		
		
		Object obj = session.getAttribute("read_bbs");
		
		if(vo != null){
			boolean chk = false;
			List<BoardVO> list = null;
			 
			if(obj == null){
				list = new ArrayList<BoardVO>();
				session.setAttribute("read_bbs", list);
			}else{
				list = (List<BoardVO>)obj;
				
				for(BoardVO r_vo : list){
					if(b_idx.equals(r_vo.getB_idx())){
						chk = true;
						break;
					}
				}
			}
			
			if(!chk){
				
				int hit = Integer.parseInt(vo.getHit());
				++hit;
				
				vo.setHit(String.valueOf(hit)); 
				
				
				BbsDAO.hit(b_idx);
				
				
				list.add(vo);
			}
			request.setAttribute("vo", vo);
			request.setAttribute("cPage", cPage);
		}
		return "/view.jsp";
		
	}
		
	}


