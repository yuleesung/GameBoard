package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import mybatis.vo.BoardMemberVO;

public class MemberUpdate implements MidAction {

	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		BoardMemberVO mvo = (BoardMemberVO)session.getAttribute("mvo");
		
		String email = mvo.getEmail();
		String phone = mvo.getPhone();
		
		int idx = email.indexOf("@"); 
		
        String email1 = email.substring(0, idx);
        String email2 = email.substring(idx+1);

        request.setAttribute("email1", email1);
        request.setAttribute("email2", email2);
		
        
        int idx2 = phone.indexOf("-"); 
		int idx3 = phone.lastIndexOf("-");
        
        String phone1 = phone.substring(0, idx2);
        String phone2 = phone.substring(idx2+1);
        String phone3 = phone.substring(idx3+1);
        
        request.setAttribute("phone1", phone1);
        request.setAttribute("phone2", phone2);
        request.setAttribute("phone3", phone3);
        
		return "memberUpdate.jsp";
	}

}
