package com.pic.dto;

public class PicDto {
	private int boardno;
	private int picno;
	private String picname;
	private String picpath;
	
	public PicDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PicDto(int boardno, int picno, String picname, String picpath) {
		super();
		this.boardno = boardno;
		this.picno = picno;
		this.picname = picname;
		this.picpath = picpath;
	}

	public int getPicno() {
		return picno;
	}

	public void setPicno(int picno) {
		this.picno = picno;
	}

	public int getBoardno() {
		return boardno;
	}

	public void setBoardno(int boardno) {
		this.boardno = boardno;
	}

	public String getPicname() {
		return picname;
	}

	public void setPicname(String picname) {
		this.picname = picname;
	}

	public String getPicpath() {
		return picpath;
	}

	public void setPicpath(String picpath) {
		this.picpath = picpath;
	}
	
	
}
