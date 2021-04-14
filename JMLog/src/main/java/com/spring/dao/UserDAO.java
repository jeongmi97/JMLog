package com.spring.dao;

import com.spring.vo.UserVO;

public interface UserDAO {
	
	UserVO pwChk(String email);

	int join(UserVO vo);

	int emailCheck(String email);

	UserVO getUser(String nickname);

	
}
