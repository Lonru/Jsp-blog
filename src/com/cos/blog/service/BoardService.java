package com.cos.blog.service;

import java.util.List;

import com.cos.blog.domain.board.Board;
import com.cos.blog.domain.board.BoardDao;
import com.cos.blog.domain.board.dto.DetailRespDto;
import com.cos.blog.domain.board.dto.SaveReqDto;

public class BoardService {

	private BoardDao boardDao;
	
	public BoardService() {
		boardDao = new BoardDao();
	}
	public int 글삭제(int id) {
		return boardDao.deleteById(id);
	}
	public DetailRespDto 글상세보기(int id) {
		//조회수 업데이트
		int result = boardDao.updateReadCount(id);
		if(result ==1) {
			return boardDao.findById(id);
		}else 
			return null;
	}
	public  int 글개수(String keyword) {
		return boardDao.count(keyword);
	}
	
	public int 글쓰기(SaveReqDto dto) {
		return boardDao.save(dto);
	}
	
	public List<Board> 글목록보기(String searchword,int page){
		return boardDao.findAll(searchword,page);
	}

}