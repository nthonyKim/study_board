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
import com.app.dto.UploadFile;
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

/*	@RequestMapping("/boardSearchAuthor")
	public String boardSearchAuthor (@RequestParam String author, 
									 @RequestParam(required = false, defaultValue = "1") int currentPage, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("author", author);
		map.put("currentPage", currentPage);
		
		Page page = service.boardList(map);
		model.addAttribute("page", page);
		return "boardList";
	}*/

	@RequestMapping("/boardView")
	public String boardView(@RequestParam int bnum, Model model, @RequestParam(required = false, defaultValue = "1") int cntCurPage) {
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
		
		if (imgFile.getTheFile().length > 1) {			
			for (CommonsMultipartFile f : imgFile.getTheFile()) {
				String path = "F:\\programming\\upload";
				String oriName = f.getOriginalFilename();
				
				System.out.println(oriName);

				// 파일명 암호화 확장자 분리하고 Uuid 값으로 치환
				String extension = oriName.substring(oriName.lastIndexOf('.'));
				String savName = imgFile.getUuid() + extension;

				// 저장 경로 설정
				File location = new File(path, savName);
				
				imgFile.setSavName(savName);
				imgFile.setOriName(oriName);
				
				service.fileInsert(imgFile, board);	
				
				try {
					f.transferTo(location);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
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
		return "redirect:boardList";	
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
