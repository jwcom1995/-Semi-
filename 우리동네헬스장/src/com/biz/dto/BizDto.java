package com.biz.dto;

import java.sql.Date;

public class BizDto {
	private int bizno;
	private int userno;
	private String usernm;
	private String biznm;
	private String bizaddr;
	private String bizcategory;
	private String bizcontent;
	private String bizpic;
	private Date bizreg;
	private String bizstatus;
	public BizDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	public BizDto(int bizno, int userno, String usernm, String biznm, String bizaddr, String bizcategory,
			String bizcontent, String bizpic, Date bizreg, String bizstatus) {
		super();
		this.bizno = bizno;
		this.userno = userno;
		this.usernm = usernm;
		this.biznm = biznm;
		this.bizaddr = bizaddr;
		this.bizcategory = bizcategory;
		this.bizcontent = bizcontent;
		this.bizpic = bizpic;
		this.bizreg = bizreg;
		this.bizstatus = bizstatus;
	}



	public BizDto(int userno,String usernm, String biznm, String bizaddr, String bizcategory,
			String bizcontent, String bizpic) {
		super();
		this.userno = userno;
		this.usernm = usernm;
		this.biznm = biznm;
		this.bizaddr = bizaddr;
		this.bizcategory = bizcategory;
		this.bizcontent = bizcontent;
		this.bizpic = bizpic;
	}
	
	public Date getBizreg() {
		return bizreg;
	}



	public void setBizreg(Date bizreg) {
		this.bizreg = bizreg;
	}



	public String getBizstatus() {
		return bizstatus;
	}



	public void setBizstatus(String bizstatus) {
		this.bizstatus = bizstatus;
	}



	public int getBizno() {
		return bizno;
	}
	public void setBizno(int bizno) {
		this.bizno = bizno;
	}
	public int getUserno() {
		return userno;
	}
	public void setUserno(int userno) {
		this.userno = userno;
	}
	public String getUsernm() {
		return usernm;
	}
	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}
	public String getBiznm() {
		return biznm;
	}
	public void setBiznm(String biznm) {
		this.biznm = biznm;
	}
	public String getBizaddr() {
		return bizaddr;
	}
	public void setBizaddr(String bizaddr) {
		this.bizaddr = bizaddr;
	}
	public String getBizcategory() {
		return bizcategory;
	}
	public void setBizcategory(String bizcategory) {
		this.bizcategory = bizcategory;
	}
	public String getBizcontent() {
		return bizcontent;
	}
	public void setBizcontent(String bizcontent) {
		this.bizcontent = bizcontent;
	}
	public String getBizpic() {
		return bizpic;
	}
	public void setBizpic(String bizpic) {
		this.bizpic = bizpic;
	}
	
	
}
