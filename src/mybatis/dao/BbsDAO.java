package mybatis.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import mybatis.service.FactoryService;
import mybatis.vo.BoardCommentVO;
import mybatis.vo.BoardMemberVO;
import mybatis.vo.BoardVO;

public class BbsDAO {
	
	// 회원 가입
	public static boolean join(BoardMemberVO vo) {
		boolean chk = false;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("bbs.join", vo);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.commit();
		
		return chk;
	}
	
	// 게시물 쓰기
	public static boolean writePost(BoardVO vo) {
		boolean chk = false;
			
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("bbs.writePost", vo);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.close();
			
		return chk;
	}
	
	// 댓글 쓰기
	public static boolean writeComment(BoardCommentVO vo) {
		boolean chk = false;
			
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.insert("bbs.writeComment", vo);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.close();
			
		return chk;
	}
	
	// 뉴스 게시물 수
	public static int getCount(String category) {
		SqlSession ss = FactoryService.getFactory().openSession();
		int total = ss.selectOne("bbs.getCount", category);
		ss.close();
		return total;
	}
	
	// 전체보기
	public static BoardVO[] getList(String begin, String end, String category) {
		BoardVO[] ar = null;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("begin", begin);
		map.put("end", end);
		map.put("category", category);
		
		SqlSession ss = FactoryService.getFactory().openSession();
		List<BoardVO> list = ss.selectList("bbs.getList", map);
		if(list != null && !list.isEmpty()) {
			ar = new BoardVO[list.size()];
			list.toArray(ar);
		}
		ss.close();
		
		return ar;
	}
	
	// 게시물 보기
	public static BoardVO viewPost(String b_idx) {
		SqlSession ss = FactoryService.getFactory().openSession();
		BoardVO vo = ss.selectOne("bbs.viewPost", b_idx);
		ss.close();
		return vo;
	}
	
	// 게시물 수정
	public static boolean editPost(BoardVO vo) {
		boolean chk = false;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("bbs.editPost", vo);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.close();
		
		return chk;
	}
	
	// 회원가입시 아이디 일치 검사
	public static String matchMember(String id) {
		SqlSession ss = FactoryService.getFactory().openSession();
		String vo_id = ss.selectOne("bbs.matchMember", id);
		ss.close();
		return vo_id;
	}
	
	// 회원 탈퇴
	public static boolean delMember(String m_idx, String pw) {
		boolean chk = false;
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("m_idx", m_idx);
		map.put("pw", pw);
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("bbs.delMember", map);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.commit();
		
		return chk;
	}
	
	// 게시물 삭제
	public static boolean delPost(String b_idx) {
		boolean chk = false;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("bbs.delPost", b_idx);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.close();
		
		return chk;
	}
	
	// 댓글 삭제
	public static boolean delComment(String c_idx) {
		boolean chk = false;
		
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("bbs.delComment", c_idx);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.close();
		
		return chk;
	}
	
	
	
	// 조회 수 올리는 기능 - 인자로 받은 b_idx의 게시물 hit를 증가하는 기능
	public static boolean hit(String b_idx) {
		boolean chk = false;
			
		SqlSession ss = FactoryService.getFactory().openSession();
		int cnt = ss.update("bbs.hit", b_idx);
		if(cnt > 0) {
			ss.commit();
			chk = true;
		}else {
			ss.rollback();
		}
		ss.close();
			
		return chk;
	}

}
