package bbs.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;
import mybatis.vo.BoardVO;

public class WriteAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		// 파라미터 받기
		String category = request.getParameter("category");
		String cPage = request.getParameter("cPage");
		
		// 파라미터들 request에 저장
		request.setAttribute("category", category);
		request.setAttribute("cPage", cPage);
		
		String c_type = request.getContentType();
		
		String viewPath = "/write.jsp";
		
		ServletContext application = request.getServletContext();
		HttpSession session = request.getSession();
		BoardMemberVO mvo = (BoardMemberVO) session.getAttribute("mvo");
		
		// 아이디 추출
		String id = mvo.getM_id();
		
		// 절대경로 생성
		String path = application.getRealPath("/upload/"+id);
		
		// 각 아이디 당 upload폴더 안에 id이름으로 폴더 생성
		File mkfolder = new File(path);
		if(!mkfolder.exists())
			mkfolder.mkdirs();
		
		if(c_type != null && c_type.startsWith("multipart/")) {
			try {	
				MultipartRequest mr = new MultipartRequest(request, path, 1024*1024*10, "utf-8", new DefaultFileRenamePolicy());
				
				// 카테고리 받기
				String mr_category = mr.getParameter("category");
				String mr_cPage = mr.getParameter("cPage");
				
				File f = mr.getFile("file");
				String file_name = "";
				String ori_name = "";
				if(f != null) {
					file_name = f.getName();
					ori_name = mr.getOriginalFileName("file");
				}
				
				BoardVO vo = new BoardVO();
				vo.setSubject(mr.getParameter("subject"));
				vo.setB_content(mr.getParameter("content"));
				vo.setFile_name(file_name);
				vo.setOri_name(ori_name);
				vo.setIp(request.getRemoteAddr());
				vo.setB_category(mr_category);
				vo.setM_idx(mvo.getM_idx());
				
				boolean chk = BbsDAO.writePost(vo);
				
				viewPath = "write";
				
				request.setAttribute("chk", chk);
				request.setAttribute("category", mr_category);
				request.setAttribute("cPage", mr_cPage);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return viewPath;
	}

}
