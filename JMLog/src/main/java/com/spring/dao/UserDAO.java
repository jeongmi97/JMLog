package com.spring.dao;

import com.spring.vo.UserVO;

public interface UserDAO {
	
	UserVO pwChk(UserVO vo);

	int join(UserVO vo);

	int emailCheck(String email);

	UserVO getUser(String nickname);

	
}
