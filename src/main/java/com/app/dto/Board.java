package com.app.dto;

import org.apache.ibatis.type.Alias;

@Alias("Board")
public class Board {
	
	private int bnum;
	private String title ;
	private String author;
	private String content;
	private String imgName; 
	private int readcnt ;
	private String pub;
	private String regdate ;
	
	
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
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
	public String getImgName() {
		return imgName;
	}
	public void setImgName(String imgName) {
		this.imgName = imgName;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public String getPub() {
		return pub;
	}
	public void setPub(String pub) {
		this.pub = pub;
	}
	public String getRegdate() {
		return regdate;
	}
	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "Board [bnum=" + bnum + ", title=" + title + ", author=" + author + ", content=" + content + ", imgName="
				+ imgName + ", readcnt=" + readcnt + ", pub=" + pub + ", regdate=" + regdate + "]";
	}
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Board(int bnum, String title, String author, String content, String imgName, int readcnt, String pub,
			String regdate) {
		super();
		this.bnum = bnum;
		this.title = title;
		this.author = author;
		this.content = content;
		this.imgName = imgName;
		this.readcnt = readcnt;
		this.pub = pub;
		this.regdate = regdate;
	}
	
	
}
