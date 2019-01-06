package com.app.dto;

import org.apache.ibatis.type.Alias;

@Alias("Searching")
public class Searching {
	private String keyWord;
	private String search;
	public String getKeyWord() {
		return keyWord;
	}
	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	@Override
	public String toString() {
		return "Searching [keyWord=" + keyWord + ", search=" + search + "]";
	}
	public Searching(String keyWord, String search) {
		super();
		this.keyWord = keyWord;
		this.search = search;
	}
	public Searching() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

}
