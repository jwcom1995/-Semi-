package com.used.dto;

import java.util.Date;

public class UsedDto {
	
	private int usedno;
	private String usedtitle;
	private String userid;
	private int userno;
	private String usedaddr;
	private String usedprice;
	private String usedcategory;
	private String usedcenternm;
	private String usedcontent;
	private Date usedreg;
	private String usedstatus;
	
	public UsedDto() {
		super();
		// TODO Auto-generated constructor stub
	}


	public UsedDto(int usedno, String usedtitle, String userid, int userno, String usedaddr, String usedprice,
			String usedcategory, String usedcenternm, String usedcontent, Date usedreg, String usedstatus) {
		super();
		this.usedno = usedno;
		this.usedtitle = usedtitle;
		this.userid = userid;
		this.userno = userno;
		this.usedaddr = usedaddr;
		this.usedprice = usedprice;
		this.usedcategory = usedcategory;
		this.usedcenternm = usedcenternm;
		this.usedcontent = usedcontent;
		this.usedreg = usedreg;
		this.usedstatus = usedstatus;
	}



	public int getUsedno() {
		return usedno;
	}

	public void setUsedno(int usedno) {
		this.usedno = usedno;
	}

	public String getUsedtitle() {
		return usedtitle;
	}

	public void setUsedtitle(String usedtitle) {
		this.usedtitle = usedtitle;
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

	public String getUsedaddr() {
		return usedaddr;
	}

	public void setUsedaddr(String usedaddr) {
		this.usedaddr = usedaddr;
	}

	public String getUsedprice() {
		return usedprice;
	}

	public void setUsedprice(String usedprice) {
		this.usedprice = usedprice;
	}

	public String getUsedcategory() {
		return usedcategory;
	}

	public void setUsedcategory(String usedcategory) {
		this.usedcategory = usedcategory;
	}

	public String getUsedcenternm() {
		return usedcenternm;
	}

	public void setUsedcenternm(String usedcenternm) {
		this.usedcenternm = usedcenternm;
	}

	public String getUsedcontent() {
		return usedcontent;
	}

	public void setUsedcontent(String usedcontent) {
		this.usedcontent = usedcontent;
	}

	public Date getUsedreg() {
		return usedreg;
	}

	public void setUsedreg(Date usedreg) {
		this.usedreg = usedreg;
	}

	public String getUsedstatus() {
		return usedstatus;
	}

	public void setUsedstatus(String usedstatus) {
		this.usedstatus = usedstatus;
	}
	
	
}
