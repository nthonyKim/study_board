package com.app.dto;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("Page")
public class Page {
	
	List<Board> list;
	int currentPage;
	int perPage = 12;
	int totalCount;
	
	public List<Board> getList() {
		return list;
	}
	public void setList(List<Board> list) {
		this.list = list;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPerPage() {
		return perPage;
	}
	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	@Override
	public String toString() {
		return "Page [list=" + list + ", currentPage=" + currentPage + ", perPage=" + perPage + ", totalCount="
				+ totalCount + "]";
	}
	public Page(List<Board> list, int currentPage, int perPage, int totalCount) {
		super();
		this.list = list;
		this.currentPage = currentPage;
		this.perPage = perPage;
		this.totalCount = totalCount;
	}
	public Page() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	
}
