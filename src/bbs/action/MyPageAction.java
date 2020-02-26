package bbs.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyPageAction implements MidAction{
	@Override
	public String execute(HttpServletRequest request, HttpServletResponse response) {
		return "myPage";
	}
}
