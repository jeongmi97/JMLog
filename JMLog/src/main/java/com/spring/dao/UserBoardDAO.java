package com.spring.dao;


import com.spring.vo.BoardVO;

public interface UserBoardDAO {

	void write(BoardVO vo);

	BoardVO getPost(int postid);

}
