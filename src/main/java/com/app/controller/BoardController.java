package com.app.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.persistence.metamodel.SetAttribute;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.app.dto.Board;
import com.app.dto.Comment;
import com.app.dto.Page;
import com.app.dto.Searching;
import com.app.dto.UploadFile;
import com.app.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	BoardService service;

	@RequestMapping("/boardList")
	public String boardList(@RequestParam(required = false, defaultValue = "1") int currentPage, HttpSession session, Searching search) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("search", search);
		
		Page page = service.boardList(map);
		session.setAttribute("page", page);
		session.setAttribute("searching", search);
		return "boardList";
	}

	@RequestMapping("/boardView")
	public String boardView(@RequestParam(required = false, defaultValue = "1") int cntCurPage, @RequestParam int bnum, Model model) {
		Board board = service.boardView(bnum);
		
		//코멘트 페이지
		Page commentPage = service.boardComment(bnum, cntCurPage);
		//첨부파일 데이터
		List<UploadFile> list = service.fileSelect(bnum);
		System.out.println(list);
		
		model.addAttribute("board", board);
		model.addAttribute("comment", commentPage);
		model.addAttribute("file", list);
		return "boardView";
	}
		
	// board 기본 C U D
	@RequestMapping("/boardWrite")
	public String boardInsert() {
		return "boardWrite";
	}

	@RequestMapping(value = "/boardWrite", method = RequestMethod.POST)
	public String boardInsert(UploadFile imgFile, Board board) {
		CommonsMultipartFile chk = imgFile.getTheFile()[0];
		System.out.println(chk);
		System.out.println(board);
		if (chk.getOriginalFilename() != "" ) {		
			service.fileInsert(imgFile, board);				
		}else {
			service.boardInsert(board);			
		}
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
		System.out.println(board);
		return "redirect:boardView?bnum="+board.getBnum();
	}
	
	@RequestMapping("/boardDelete")
	public String boradDelete(@RequestParam int bnum) {
		service.boradDelete(bnum);		
		return "redirect:boardList";	
	}
	
	// comment 기본 C D
	@RequestMapping(value="/commentDelete", method=RequestMethod.GET)
	public @ResponseBody String commentDelete(@RequestParam String cnum) {
		service.commentDelete(Integer.parseInt(cnum));		
		return "success";
	}
	
	@RequestMapping(value="/commentInsert", method=RequestMethod.GET)
	public String commentInsert(Comment cnt, Model model) {
		int bnum = cnt.getBnum();
		service.commentInsert(cnt);
		return "redirect:boardView?bnum="+bnum;
	}
}
