package com.spring.dao;

import java.util.List;

import com.spring.vo.BoardVO;
import com.spring.vo.UserVO;

public interface UserDAO {
	
	UserVO userChk(String email);

	int join(UserVO vo);

	int emailCheck(String email);

	List<BoardVO> userBoardList(String email);

	int listAll(String email);


}
