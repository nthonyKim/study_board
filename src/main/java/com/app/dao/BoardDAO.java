package com.app.dao;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.app.dto.Board;
import com.app.dto.Comment;
import com.app.dto.Page;
import com.app.dto.Searching;
import com.app.dto.UploadFile;

@Repository
public class BoardDAO {
	@Autowired
	SqlSessionTemplate template;

	//페이징을 위한 총 데이터 갯수
	public int totalRecord() {
		int n = template.selectOne("BoardMapper.totalCount");
		return n;
	}
	
	public int totalRecordParam(Searching srh) {
		int n = 0;		
		if(srh.getSearch().equals("author")) {
			n = template.selectOne("BoardMapper.totalCountAuthor", srh);	
		}else if(srh.getSearch().equals("title")) {
			n = template.selectOne("BoardMapper.totalCountTitle", srh);	
		}else if(srh.getSearch().equals("title_content")) {
			n = template.selectOne("BoardMapper.totalCountTicon", srh);	
		}
		return n;
	}
	
	public int totalRecordComment(int bnum) {
		int n = template.selectOne("BoardMapper.totalCountComment", bnum);
		return n;
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
		int currentPage = (Integer) map.get("currentPage");		
		Searching srh = (Searching) map.get("search");
		
		Page page = new Page();
		int offset = (currentPage - 1) * page.getPerPage();
		List<Object> list = null;
		int totalCount = 0;
		
		if(srh.getKeyWord() == null || srh.getSearch() == null){
			list = template.selectList("BoardMapper.boardList", null, new RowBounds(offset, page.getPerPage()));
			totalCount = totalRecord();
		}else {
			if(srh.getSearch().equals("author")) {				
				list = template.selectList("BoardMapper.boardSearchAuthor", srh, new RowBounds(offset, page.getPerPage()));		
				totalCount = totalRecordParam(srh);				
			}else if(srh.getSearch().equals("title")) {
				list = template.selectList("BoardMapper.boardSearchTitle", srh, new RowBounds(offset, page.getPerPage()));		
				totalCount = totalRecordParam(srh);
			}else if(srh.getSearch().equals("title_content")) {
				list = template.selectList("BoardMapper.boardSearchTicon", srh, new RowBounds(offset, page.getPerPage()));		
				totalCount = totalRecordParam(srh);
			}
		}
		page.setList(list);
		page.setCurrentPage(currentPage);
		page.setTotalCount(totalCount);
		return page;
	}

	// comment paging
	public Page boardComment(int bnum, int cntCurPage) {
		Page page = new Page();	
		int offset = (cntCurPage - 1) * 24;
		
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
	
	public void fileInsert(UploadFile imgFile) {
		for (CommonsMultipartFile f : imgFile.getTheFile()) {
			String path = "F:\\programming\\upload";
			String oriName = f.getOriginalFilename();
			
			System.out.println("boardInsert       "+oriName);

			// 파일명 암호화 확장자 분리하고 Uuid 값으로 치환
			String extension = oriName.substring(oriName.lastIndexOf('.'));
			String savName = imgFile.getUuid() + extension;

			// 저장 경로 설정
			File location = new File(path, savName);
			
			imgFile.setSavName(savName);
			imgFile.setOriName(oriName);
			
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
		int n = template.insert("BoardMapper.fileInsert", imgFile);		
	}

	public List<UploadFile> fileSelect(int bnum) {
		List<UploadFile> list = template.selectList("BoardMapper.fileSelect", bnum);
		return list;
	}

	public void readCnt(int bnum) {
		int n = template.update("BoardMapper.readCnt", bnum);	
	}




}
