package com.reply.dto;

public class ReplyDto {
	private int qareno;
	private int qano;
	private int titletab;
	private String content;
	private String retitle;
	
	public ReplyDto() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public ReplyDto(int qareno, int qano, int titletab, String retitle, String content) {
		super();
		this.qareno = qareno;
		this.qano = qano;
		this.titletab = titletab;
		this.retitle = retitle;
		this.content = content;
	}

	public int getQareno() {
		return qareno;
	}

	public void setQareno(int qareno) {
		this.qareno = qareno;
	}

	public int getQano() {
		return qano;
	}

	public void setQano(int qano) {
		this.qano = qano;
	}

	public int getTitletab() {
		return titletab;
	}

	public void setTitletab(int titletab) {
		this.titletab = titletab;
	}
	
	public String getRetitle() {
		return retitle;
	}

	public void setRetitle(String retitle) {
		this.retitle = retitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	
	
}
