package com.user.dto;
import java.util.Date;
public class UserDto {
	private int userno;
	private String userid;
	private String userpw;
	private String username;
	private String usergender;
	private String userbirthdate;
	private String useremail;
	private String userphone;
	private String userzip;
	private String useraddr;
	private String role;
	private Date reg;
	private String userenabled;
	private String userwish;
	
	public UserDto() {
		super();
	}

	public UserDto(int userno, String userid, String userpw, String username, String useremail, String userphone,
			String useraddr, String role, String userenabled, String userwish) {
		super();
		this.userno = userno;
		this.userid = userid;
		this.userpw = userpw;
		this.username = username;
		this.useremail = useremail;
		this.userphone = userphone;
		this.useraddr = useraddr;
		this.role = role;
		this.userenabled = userenabled;
		this.userwish = userwish;
	}

	public UserDto(int userno, String userid, String userpw, String username, String usergender, String userbirthdate,
			String useremail, String userphone, String userzip, String useraddr, String role, Date reg,
			String userenabled, String userwish) {
		super();
		this.userno = userno;
		this.userid = userid;
		this.userpw = userpw;
		this.username = username;
		this.usergender = usergender;
		this.userbirthdate = userbirthdate;
		this.useremail = useremail;
		this.userphone = userphone;
		this.userzip = userzip;
		this.useraddr = useraddr;
		this.role = role;
		this.reg = reg;
		this.userenabled = userenabled;
		this.userwish = userwish;
	}
	
	public UserDto(String userid, String userpw, String username, String usergender, String userbirthdate,
			String useremail, String userphone, String userzip, String useraddr) {
		super();
		this.userid = userid;
		this.userpw = userpw;
		this.username = username;
		this.usergender = usergender;
		this.userbirthdate = userbirthdate;
		this.useremail = useremail;
		this.userphone = userphone;
		this.userzip = userzip;
		this.useraddr = useraddr;
	}
	public int getUserno() {
		return userno;
	}
	public void setUserno(int userno) {
		this.userno = userno;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUserpw() {
		return userpw;
	}
	public void setUserpw(String userpw) {
		this.userpw = userpw;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUsergender() {
		return usergender;
	}
	public void setUsergender(String usergender) {
		this.usergender = usergender;
	}
	public String getUserbirthdate() {
		return userbirthdate;
	}
	public void setUserbirthdate(String userbirthdate) {
		this.userbirthdate = userbirthdate;
	}
	public String getUseremail() {
		return useremail;
	}
	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}
	public String getUserphone() {
		return userphone;
	}
	public void setUserphone(String userphone) {
		this.userphone = userphone;
	}
	public String getUserzip() {
		return userzip;
	}
	public void setUserzip(String userzip) {
		this.userzip = userzip;
	}
	public String getUseraddr() {
		return useraddr;
	}
	public void setUseraddr(String useraddr) {
		this.useraddr = useraddr;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Date getReg() {
		return reg;
	}
	public void setReg(Date reg) {
		this.reg = reg;
	}
	public String getUserenabled() {
		return userenabled;
	}
	public void setUserenabled(String userenabled) {
		this.userenabled = userenabled;
	}
	public String getUserwish() {
		return userwish;
	}
	public void setUserwish(String userwish) {
		this.userwish = userwish;
	}
	
}