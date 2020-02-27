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

public class EditAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		String b_idx = request.getParameter("b_idx");
		String cPage = request.getParameter("cPage");
		String category = request.getParameter("category");
		
		String c_type = request.getContentType();
		ServletContext application = request.getServletContext();
		
		// 계정 아이디 얻기 위한 세션 생성
		HttpSession session = request.getSession();
		
		// 계정 mvo객체 얻기
		BoardMemberVO mvo = (BoardMemberVO) session.getAttribute("mvo");
		
		// 폴더 생성을 위한 아이디 얻기
		String id = mvo.getM_id();
		
		String path = application.getRealPath("/upload/"+id);
		
		File mkfolder = new File(path);
		if(!mkfolder.exists())
			mkfolder.mkdirs();
		
		String viewPath = "/edit.jsp";
		
		if(c_type != null && c_type.startsWith("multipart/")) {
			try {
				MultipartRequest mr = new MultipartRequest(request, path, 1024*1024*10, "utf-8", new DefaultFileRenamePolicy());
				
				cPage = mr.getParameter("cPage");
				b_idx = mr.getParameter("b_idx");
				category = mr.getParameter("category");
				
				File f = mr.getFile("file");
				String file_name = null;
				String ori_name = null;
				if(f != null) {
					file_name = f.getName();
					ori_name = mr.getOriginalFileName("file");
				}
				
				BoardVO vo = new BoardVO();
				vo.setSubject(mr.getParameter("subject"));
				vo.setFile_name(file_name);
				vo.setOri_name(ori_name);
				vo.setB_content(mr.getParameter("content"));
				vo.setB_idx(b_idx);
				
				boolean chk = BbsDAO.editPost(vo);
				
				request.setAttribute("chk", chk);
				request.setAttribute("cPage", cPage);
				request.setAttribute("b_idx", b_idx);
				request.setAttribute("category", category);
				
				viewPath = "edit";
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(c_type != null && c_type.startsWith("application")){//
			BoardVO vo = BbsDAO.viewPost(b_idx);
			request.setAttribute("vo", vo);
			request.setAttribute("category", category);
		}
		
		return viewPath;
	}

}
