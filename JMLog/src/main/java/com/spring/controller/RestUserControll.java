package com.spring.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.dao.UserDAO;
import com.spring.service.UserService;

@RestController
public class RestUserControll {
	@Autowired UserService us;
	@Autowired UserDAO dao;
	
	// 이메일 중복 확인 
	@GetMapping("emailCheck")
	public int emailCheck(@RequestParam("email")String email) {
		int chk = us.emailCheck(email);
		return chk;
	}
	
	// 닉네임 중복 체크
	@GetMapping("nicknameChk")
	public String nicknameChk(@RequestParam("nickname")String nickname) {
		String chk = us.nicknameChk(nickname);
		return chk;
	}
	
	// 프로필 이미지 제거
	@GetMapping("delimg")
	public void delimg(@RequestParam("email")String email) {
		dao.delimg(email);
	}
	
	// 회원 탈퇴 기능 실행
	@GetMapping("deluser")
	public void deluser(@RequestParam("nickname")String nickname, HttpSession session) {
		us.deluser(nickname, session);
	}
}
