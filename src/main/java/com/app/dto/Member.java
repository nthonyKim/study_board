package com.app.dto;

import org.apache.ibatis.type.Alias;

@Alias("Member")
public class Member {

	private String userid;
	private String passwd;
	private String username;
	
	
	
	public Member(String userid, String passwd, String username) {
		super();
		this.userid = userid;
		this.passwd = passwd;
		this.username = username;
	}



	@Override
	public String toString() {
		return "Member [userid=" + userid + ", passwd=" + passwd + ", username=" + username + "]";
	}



	public String getUserid() {
		return userid;
	}



	public void setUserid(String userid) {
		this.userid = userid;
	}



	public String getPasswd() {
		return passwd;
	}



	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
}
