package com.qna.dto;

import java.util.Date;


public class QnaDto {
	private int qano;			//문의글번호
	private int qagpno;			//그룹번호
	private int qagpsq;			//그룹번호 내 번호
	private int titletab;
	private String userid;		//아이디
	private int userno;			//회원번호
	private String qatype;		//유형
	private String qatitle;		//제목
	private String qacontent;	//내용
	private String qafaq;		//FAQ 여부 ('Y' || 'N(default)')
	private Date qareg;			//작성일자
	private String qastatus;	//답변상태	 ('Y' || 'N(default)')
		
	public QnaDto() {
		super();
	}

	public QnaDto(int qano, int qagpno, int qagpsq, int titletab, String userid, int userno, String qatype, String qatitle,
			String qacontent, String qafaq, Date qareg, String qastatus) {
		super();
		this.qano = qano;
		this.qagpno = qagpno;
		this.qagpsq = qagpsq;
		this.titletab = titletab;
		this.userid = userid;
		this.userno = userno;
		this.qatype = qatype;
		this.qatitle = qatitle;
		this.qacontent = qacontent;
		this.qafaq = qafaq;
		this.qareg = qareg;
		this.qastatus = qastatus;

	}
	
	public QnaDto(int qano, int qagpno, int qagpsq, int titletab, String qatitle, String qacontent, Date qareg) {
		this.qano = qano;
		this.qagpno = qagpno;
		this.qagpsq = qagpsq;
		this.titletab = titletab;
		this.qatitle = qatitle;
		this.qacontent = qacontent;
		this.qareg = qareg;
	}

	public int getQano() {
		return qano;
	}

	public void setQano(int qano) {
		this.qano = qano;
	}

	public int getQagpno() {
		return qagpno;
	}

	public void setQagpno(int qagpno) {
		this.qagpno = qagpno;
	}

	public int getQagpsq() {
		return qagpsq;
	}

	public void setQagpsq(int qagpsq) {
		this.qagpsq = qagpsq;
	}
	
	public int getTitletab() {
		return titletab;
	}
	
	public void setTitletab(int titletab) {
		this.titletab = titletab;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public int getUserno() {
		return userno;
	}

	public void setUserno(int userno) {
		this.userno = userno;
	}

	public String getQatype() {
		return qatype;
	}

	public void setQatype(String qatype) {
		this.qatype = qatype;
	}

	public String getQatitle() {
		return qatitle;
	}

	public void setQatitle(String qatitle) {
		this.qatitle = qatitle;
	}

	public String getQacontent() {
		return qacontent;
	}

	public void setQacontent(String qacontent) {
		this.qacontent = qacontent;
	}

	public String getQafaq() {
		return qafaq;
	}

	public void setQafaq(String qafaq) {
		this.qafaq = qafaq;
	}

	public Date getQareg() {
		return qareg;
	}

	public void setQareg(Date qareg) {
		this.qareg = qareg;
	}

	public String getQastatus() {
		return qastatus;
	}

	public void setQastatus(String qastatus) {
		this.qastatus = qastatus;
	}

}	