package com.app.controller;

import java.io.File;
import java.io.FileInputStream;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@RequestMapping("/")
	public String home() {		
		return "redirect:boardList";
	}
	
	
	@RequestMapping("/boardList")
	public String boardList(@RequestParam(required = false, defaultValue = "1") int currentPage, HttpSession session, Searching search) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("currentPage", currentPage);
		map.put("search", search);
		
		Page page = service.boardList(map);
		session.removeAttribute("board");
		session.removeAttribute("page");
		session.removeAttribute("searching");
		
		session.setAttribute("page", page);
		session.setAttribute("searching", search);
		return "boardList";
	}

	@RequestMapping("/boardView")
	public ModelAndView boardView(@RequestParam(required = false, defaultValue = "1") int cntCurPage, @RequestParam int bnum) {
		Board board = service.boardView(bnum);
		//코멘트 페이지
		Page commentPage = service.boardComment(bnum, cntCurPage);
		//첨부파일 데이터
		List<UploadFile> list = service.fileSelect(bnum);
		System.out.println(list);
		
		ModelAndView mav = new ModelAndView();		
		mav.addObject("board", board);
		mav.addObject("comment", commentPage);
		mav.addObject("file", list);
		mav.setViewName("boardView");
		return mav;
	}
		
	// board 기본 C U D
	@RequestMapping("/loginCheck/boardWrite")
	public String boardInsert() {
		return "redirect:../boardWriteForm";
	}

	@RequestMapping(value = "/loginCheck/boardWrite", method = RequestMethod.POST)
	public String boardInsert(UploadFile imgFile, Board board) {
		CommonsMultipartFile chk = imgFile.getTheFile()[0];
		System.out.println(chk.getOriginalFilename());
		System.out.println(board);
		if (chk.getOriginalFilename() != "" ) {		
			service.fileInsert(imgFile, board);				
		}else {
			service.boardInsert(board);			
		}
		return "redirect:../boardList";
	}
	
	@RequestMapping("/loginCheck/boardUpdate")
	public String boradUpdate(@RequestParam int bnum, HttpSession session) {
		Board board = service.boardView(bnum);
		session.setAttribute("board", board);
		System.out.println(board);
		return "redirect:../boardUpdateForm";
	}
	
	@RequestMapping(value="/loginCheck/boardUpdate", method=RequestMethod.POST)
	public String boradUpdate(Board board) {
		service.boardUpdate(board);
		System.out.println(board);
		return "redirect:../boardView?bnum=" + board.getBnum();
	}

	@RequestMapping("/loginCheck/boardDelete")
	public String boradDelete(@RequestParam int bnum) {
		service.boradDelete(bnum);		
		return "redirect:../boardList";	
	}
	
	// comment 기본 C D
	@RequestMapping(value="/loginCheck/commentDelete", method=RequestMethod.GET)
	public @ResponseBody String commentDelete(@RequestParam String cnum) {
		service.commentDelete(Integer.parseInt(cnum));		
		return "success";
	}
	
	@RequestMapping(value="/loginCheck/commentInsert", method=RequestMethod.POST)
	public String commentInsert(Comment cnt, Model model) {
		int bnum = cnt.getBnum();
		service.commentInsert(cnt);
		return "redirect:../boardView?bnum="+bnum;
	}
	
/*	@RequestMapping("/fileDown")
	public String fileDown(@RequestParam String fileName){		
		File file = new File("F:\\programming\\upload", fileName);
		String filePath = file.getPath();
		
		byte b[] = new byte[4096];
		FileInputStream in = new FileInputStream(filePath);

	
		
		return "boardView";	
	}*/
}
