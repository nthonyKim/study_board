package com.app.dto;

import org.apache.ibatis.type.Alias;

@Alias("Comment")
public class Comment {
	private int cnum;
	private int bnum;
	private String author;
	private String content;
	private String regdate;
	private int parent;
	
	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRegdate() {
		return regdate;
	}
	public Comment(int cnum, int bnum, String author, String content, String regdate, int parent) {
		super();
		this.cnum = cnum;
		this.bnum = bnum;
		this.author = author;
		this.content = content;
		this.regdate = regdate;
		this.parent = parent;
	}
	@Override
	public String toString() {
		return "Comment [cnum=" + cnum + ", bnum=" + bnum + ", author=" + author + ", content=" + content + ", regdate="
				+ regdate + ", parent=" + parent + "]";
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
}
