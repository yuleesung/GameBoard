package bbs.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mybatis.dao.BbsDAO;
import mybatis.vo.BoardMemberVO;


public class RegistryAction implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		// 회원가입 액션
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String[] s_email = request.getParameterValues("email");
		String[] s_phone = request.getParameterValues("phone");
		
		String email = makeString(s_email, "@");
		String phone = makeString(s_phone, "-");
		
		
		/*
		 * System.out.println(id); System.out.println(pw); System.out.println(name);
		 * System.out.println(email); System.out.println(phone);
		 */
		 
		
		BoardMemberVO mvo = new BoardMemberVO();
		
		mvo.setM_id(id);; mvo.setPw(pw); mvo.setM_name(name);;
		mvo.setEmail(email); mvo.setPhone(phone);
		
		boolean chk = BbsDAO.join(mvo);
		
		if(chk) { // 회원 등록이 되었다면, 개인폴더를 생성(이미지 업로드용)
			try {
				ServletContext application = request.getServletContext();
				String path = application.getRealPath("/upload/"+id);
				File f = new File(path);
				
				if(!f.exists())
					f.mkdirs();
				
				System.out.println("생성완료");
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return "Controller?type=main";
	}

	
	// 배열을 문자열로 변환시켜주는 기능 (연락처,이메일)
		private static String makeString(String[] ar, String delim) {
			StringBuffer sb = new StringBuffer();
			
			for(int i=0; i<ar.length; i++) {
				sb.append(ar[i]);
				
				if(i < ar.length-1)
					sb.append(delim);
			}
			return sb.toString();
		}
}
