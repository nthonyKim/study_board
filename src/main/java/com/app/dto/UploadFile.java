package com.app.dto;

import java.util.Arrays;
import java.util.UUID;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

@Alias("UploadFile")
public class UploadFile {
	private int fnum;
	private int bnum;
	private CommonsMultipartFile theFile [];
	private String oriName;
	private String savName;	
		
	@Override
	public String toString() {
		return "UploadFile [fnum=" + fnum + ", bnum=" + bnum + ", theFile=" + Arrays.toString(theFile) + ", oriName="
				+ oriName + ", savName=" + savName + "]";
	}
	public int getFnum() {
		return fnum;
	}
	public void setFnum(int fnum) {
		this.fnum = fnum;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public CommonsMultipartFile[] getTheFile() {
		return theFile;
	}
	public void setTheFile(CommonsMultipartFile[] theFile) {
		this.theFile = theFile;
	}
	public String getOriName() {
		return oriName;
	}
	public void setOriName(String oriName) {
		this.oriName = oriName;
	}
	public String getSavName() {
		return savName;
	}
	public void setSavName(String savName) {
		this.savName = savName;
	}
	public UploadFile(int fnum, int bnum, CommonsMultipartFile[] theFile, String oriName, String savName) {
		super();
		this.fnum = fnum;
		this.bnum = bnum;
		this.theFile = theFile;
		this.oriName = oriName;
		this.savName = savName;
	}
	public UploadFile() {
		super();
		// TODO Auto-generated constructor stub
	}

	// uuid
	public String getUuid() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}

}
