package com.center.dto;

import java.util.Date;

public class CenterDto {
	private int centerno;
	private String centername;
	private String userid;
	private String centeraddr;
	private String centerprice;
	private String centercategory;
	private double centergrade;
	private String centerintro;
	private String centercontent;
	private String centerophour;
	private String centerpro;
	private Date centerreg;
	
	public CenterDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CenterDto(int centerno, String centername, String userid, String centeraddr, String centerprice,
			String centercategory, double centergrade, String centerintro, String centercontent, String centerophour,
			String centerpro, Date centerreg) {
		super();
		this.centerno = centerno;
		this.centername = centername;
		this.userid = userid;
		this.centeraddr = centeraddr;
		this.centerprice = centerprice;
		this.centercategory = centercategory;
		this.centergrade = centergrade;
		this.centerintro = centerintro;
		this.centercontent = centercontent;
		this.centerophour = centerophour;
		this.centerpro = centerpro;
		this.centerreg = centerreg;
	}
	
	public CenterDto(String centername,String userid, String centeraddr, String centerprice, String centercategory,
			String centerintro, String centercontent, String centerophour, String centerpro) {
		super();
		this.centername = centername;
		this.userid = userid;
		this.centeraddr = centeraddr;
		this.centerprice = centerprice;
		this.centercategory = centercategory;
		this.centerintro = centerintro;
		this.centercontent = centercontent;
		this.centerophour = centerophour;
		this.centerpro = centerpro;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getCenterno() {
		return centerno;
	}

	public void setCenterno(int centerno) {
		this.centerno = centerno;
	}

	public String getCentername() {
		return centername;
	}

	public void setCentername(String centername) {
		this.centername = centername;
	}

	public String getCenteraddr() {
		return centeraddr;
	}

	public void setCenteraddr(String centeraddr) {
		this.centeraddr = centeraddr;
	}

	public String getCenterprice() {
		return centerprice;
	}

	public void setCenterprice(String centerprice) {
		this.centerprice = centerprice;
	}

	public String getCentercategory() {
		return centercategory;
	}

	public void setCentercategory(String centercategory) {
		this.centercategory = centercategory;
	}

	public double getCentergrade() {
		return centergrade;
	}

	public void setCentergrade(double centergrade) {
		this.centergrade = centergrade;
	}

	public String getCenterintro() {
		return centerintro;
	}

	public void setCenterintro(String centerintro) {
		this.centerintro = centerintro;
	}

	public String getCentercontent() {
		return centercontent;
	}

	public void setCentercontent(String centercontent) {
		this.centercontent = centercontent;
	}

	public String getCenterophour() {
		return centerophour;
	}

	public void setCenterophour(String centerophour) {
		this.centerophour = centerophour;
	}

	public String getCenterpro() {
		return centerpro;
	}

	public void setCenterpro(String centerpro) {
		this.centerpro = centerpro;
	}

	public Date getCenterreg() {
		return centerreg;
	}

	public void setCenterreg(Date centerreg) {
		this.centerreg = centerreg;
	}
}


