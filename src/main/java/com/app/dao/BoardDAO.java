package com.app.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dto.Board;
import com.app.dto.Page;


@Repository
public class BoardDAO {
	@Autowired
	SqlSessionTemplate template;
	
	public int totalRecord() {
		int n = template.selectOne("BoardMapper.totalCount");
		return n ; 
		}

	public Page boardList(int currentPage) {		
		Page page = new Page();
		//offset 데이터 인덱스 값
		int offset = (currentPage - 1) * page.getPerPage();
		
		//page에 담을 list (인덱스부터 perpage 갯수 만큼)
		List<Board> list = template.selectList("BoardMapper.boardList", null, new RowBounds(offset, page.getPerPage()));
		System.out.println("list:  "+list);
		
		page.setList(list); 
		page.setCurrentPage(currentPage);
		int totalCount = totalRecord();
		page.setTotalCount(totalCount);
		return page; 		
	}

	public Board boardView(int bnum) {
		Board board = template.selectOne("BoardMapper.boardView", bnum);
		return board;
	}

}
