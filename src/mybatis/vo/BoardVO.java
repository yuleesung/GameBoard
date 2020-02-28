package mybatis.vo;

import java.io.Serializable;
import java.util.List;

public class BoardVO implements Serializable {

	private String b_idx, subject, b_content, file_name, ori_name, write_date, ip, hit, status, b_category, m_idx;
	
	private List<BoardCommentVO> bc_list;
	
	private BoardMemberVO bmvo;

	public String getB_idx() {
		return b_idx;
	}

	public void setB_idx(String b_idx) {
		this.b_idx = b_idx;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getB_content() {
		return b_content;
	}

	public void setB_content(String b_content) {
		this.b_content = b_content;
	}

	public String getFile_name() {
		return file_name;
	}

	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getOri_name() {
		return ori_name;
	}

	public void setOri_name(String ori_name) {
		this.ori_name = ori_name;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getHit() {
		return hit;
	}

	public void setHit(String hit) {
		this.hit = hit;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getB_category() {
		return b_category;
	}

	public void setB_category(String b_category) {
		this.b_category = b_category;
	}

	public String getM_idx() {
		return m_idx;
	}

	public void setM_idx(String m_idx) {
		this.m_idx = m_idx;
	}

	public List<BoardCommentVO> getBc_list() {
		return bc_list;
	}

	public void setBc_list(List<BoardCommentVO> bc_list) {
		this.bc_list = bc_list;
	}

	public BoardMemberVO getBmvo() {
		return bmvo;
	}

	public void setBmvo(BoardMemberVO bmvo) {
		this.bmvo = bmvo;
	}

}
