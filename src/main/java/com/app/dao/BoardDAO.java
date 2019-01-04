package com.app.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.app.dto.Board;
import com.app.dto.Comment;
import com.app.dto.Page;

@Repository
public class BoardDAO {
	@Autowired
	SqlSessionTemplate template;

	//페이징을 위한 총 데이터 갯수
	public int totalRecord() {
		int n = template.selectOne("BoardMapper.totalCount");
		return n;
	}
	
	public int totalRecordParam(HashMap<String, Object> map) {
		int n = 0;
		if(map.get("author") != null) {
			n = template.selectOne("BoardMapper.totalCountAuthor", map);	
		}else if(map.get("title") != null) {
			
		}else if(map.get("content") != null) {
			
		}
		return n;
	}
	
	public int totalRecordComment(int bnum) {
		int n = template.selectOne("BoardMapper.totalCountComment", bnum);
		return n;
	}

	public Page boardList(int currentPage) {
		Page page = new Page();
		// offset 데이터 인덱스 값
		int offset = (currentPage - 1) * page.getPerPage();
		// page에 담을 list (인덱스부터 perpage 갯수 만큼)
		List<Object> list = template.selectList("BoardMapper.boardList", null, new RowBounds(offset, page.getPerPage()));

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

	public void boardInsert(Board board) {
		int n = template.insert("BoardMapper.boardInsert", board);
	}

	public void boardUpdate(Board board) {
		int n = template.update("BoardMapper.boardUpdate", board);
	}

	public void boardDelete(int bnum) {
		int n = template.delete("BoardMapper.boardDelete", bnum);		
	}

	public Page boardList(HashMap<String, Object> map) {
		Page page = new Page();
		int currentPage = (Integer) map.get("currentPage");		
		int offset = (currentPage - 1) * page.getPerPage();
		List<Object> list = null;
		int totalCount = 0;
		
		if(map.get("author") != null) {
		list = template.selectList("BoardMapper.boardListAuthor", map, new RowBounds(offset, page.getPerPage()));
		totalCount = totalRecordParam(map);
		}else if(map.get("title") != null) {
			
		}else if(map.get("content") != null) {
			
		}

		page.setList(list);
		page.setCurrentPage(currentPage);
		page.setTotalCount(totalCount);
		return page;
	}

	public Page boardComment(int bnum, int cntCurPage) {
		Page page = new Page();	
		int offset = (cntCurPage - 1) * page.getPerPage();
		
		List<Object> list = template.selectList("BoardMapper.boardComment", bnum, new RowBounds(offset, page.getPerPage()));
		int totalCount = totalRecordComment(bnum);
		page.setList(list);
		page.setCurrentPage(cntCurPage);
		page.setTotalCount(totalCount);		
		return page;
	}

	public void commentDelete(int cnum) {
		int n = template.delete("BoardMapper.commentDelete", cnum);		
	}

	public void commentInsert(Comment cnt) {
		int n = template.insert("BoardMapper.commentInsert", cnt);		
	}

}
