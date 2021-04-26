package com.spring.dao;

import java.util.List;

import com.spring.vo.BoardVO;

public interface UserBoardDAO {

	void write(BoardVO vo);

	BoardVO getPost(int postid);
	
	List<BoardVO> userBoardList(String email);
	

}
