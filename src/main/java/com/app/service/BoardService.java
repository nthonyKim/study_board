package com.app.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.BoardDAO;
import com.app.dto.Board;
import com.app.dto.Comment;
import com.app.dto.Page;

@Service
public class BoardService {	
	@Autowired
	BoardDAO dao;

	public Page boardList(int currentPage) {
		Page page = dao.boardList(currentPage);
		return page;
	}

	public Board boardView(int bnum) {
		Board board = dao.boardView(bnum);
		return board;
	}

	public void boardInsert(Board board) {
		dao.boardInsert(board);		
	}

	public void boardUpdate(Board board) {
		dao.boardUpdate(board);
	}

	public void boradDelete(int bnum) {
		dao.boardDelete(bnum);		
	}

	public Page boardList(HashMap<String, Object> map) {
		Page page = dao.boardList(map);
		return page;
	}

	public Page boardComment(int bnum, int cntCurPage) {
		Page page = dao.boardComment(bnum, cntCurPage);
		return page;
	}

	public void commentDelete(int cnum) {
		dao.commentDelete(cnum);		
	}

	public void commentInsert(Comment cnt) {
		dao.commentInsert(cnt);		
	}
	

}
