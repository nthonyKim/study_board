package com.app.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.dao.BoardDAO;
import com.app.dto.Page;

@Service
public class BoardService {	
	@Autowired
	BoardDAO dao;

	public Page boardList(int currentPage) {
		Page page = dao.boardList(currentPage);
		return page;
	}
	

}
