package com.wish.dto;

public class WishDto {

	private String loginid;
	private int titleno;
	private String useyn;
	private String type;
	private String usedtitle;
	
	public WishDto() {
		super();
	}

	public WishDto(String loginid, int titleno, String useyn, String type, String usedtitle) {
		super();
		this.loginid = loginid;
		this.titleno = titleno;
		this.useyn = useyn;
		this.type = type;
		this.usedtitle = usedtitle;
	}

	public String getLoginid() {
		return loginid;
	}

	public void setLoginid(String loginid) {
		this.loginid = loginid;
	}

	public int getTitleno() {
		return titleno;
	}

	public void setTitleno(int titleno) {
		this.titleno = titleno;
	}

	public String getUseyn() {
		return useyn;
	}

	public void setUseyn(String useyn) {
		this.useyn = useyn;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getUsedtitle() {
		return usedtitle;
	}

	public void setUsedtitle(String usedtitle) {
		this.usedtitle = usedtitle;
	}

	

	

	

	
}
