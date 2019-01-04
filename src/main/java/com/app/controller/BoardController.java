package com.app.controller;

import java.util.HashMap;

import javax.persistence.metamodel.SetAttribute;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.dto.Board;
import com.app.dto.Comment;
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
	public String boardView(@RequestParam int bnum, Model model,
			@RequestParam(required = false, defaultValue = "1") int cntCurPage) {
		Board board = service.boardView(bnum);
		
		//코멘트 페이지
		Page commentPage = service.boardComment(bnum, cntCurPage);
		
		model.addAttribute("board", board);
		model.addAttribute("comment", commentPage);
		return "boardView";
	}
	
	@RequestMapping("/boardWrite")
	public String boardWrite() {
		return "boardWrite";
	}
	
	@RequestMapping(value="/boardWrite", method=RequestMethod.POST)
	public String boardInsert(Board board) {			
		service.boardInsert(board);
		return "redirect:boardList";
	}
	
	@RequestMapping("/boardUpdate")
	public String boradUpdate(@RequestParam int bnum, Model model) {
		Board board = service.boardView(bnum);
		model.addAttribute("board", board);
		return "boardUpdate";	
	}
	
	@RequestMapping(value="/boardUpdate", method=RequestMethod.POST)
	public String boradUpdate(Board board) {
		service.boardUpdate(board);
		return "redirect:boardList";	
	}
	
	@RequestMapping("/boardDelete")
	public String boradDelete(@RequestParam int bnum) {
		service.boradDelete(bnum);		
		return "redirect:boardList";	
	}

	@RequestMapping("/boardSearchAuthor")
	public String boardSearchAuthor (@RequestParam String author, 
									 @RequestParam(required = false, defaultValue = "1") int currentPage, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("author", author);
		map.put("currentPage", currentPage);
		
		Page page = service.boardList(map);
		model.addAttribute("page", page);
		return "boardList";
	}
	
	@RequestMapping(value="/commentDelete", method=RequestMethod.GET)
	public @ResponseBody String commentDelete(@RequestParam String cnum) {
		service.commentDelete(Integer.parseInt(cnum));		
		return "success";
	}
	
	@RequestMapping(value="/commentInsert", method=RequestMethod.GET)
	public String commentInsert(Comment cnt, Model model) {
		System.out.println(cnt);
		int bnum = cnt.getBnum();
		service.commentInsert(cnt);
		return "redirect:boardView?bnum="+bnum;
	}
}
