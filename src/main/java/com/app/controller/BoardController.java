package com.app.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.app.dto.Board;
import com.app.dto.Page;
import com.app.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	BoardService service;

	@RequestMapping("/boardList")
	public String boardList(@RequestParam(required = false, defaultValue = "1") int currentPage, Model model) {
		Page page = service.boardList(currentPage);
		model.addAttribute("page", page);
		return "boardList";
	}

	@RequestMapping("/boardView")
	public String boardView(@RequestParam int bnum, Model model) {
		Board board = service.boardView(bnum);
		model.addAttribute("board", board);
		return "boardView";
	}
	
	@RequestMapping("/boardWrite")
	public String boardWrite() {
		return "boardWrite";
	}
}
