package com.spring.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.dao.UserDAO;
import com.spring.service.UserService;
import com.spring.vo.CategoryVO;
import com.spring.vo.UserVO;

@Controller
public class UserController {
	
	@Autowired UserService us;
	
	// 로그인 페이지 이동
	@RequestMapping("login")
	public void login() {
	}
	
	// 로그인 기능 실행
	@PostMapping("login")
	public ModelAndView login(UserVO vo, HttpSession session, HttpServletRequest req ,HttpServletResponse res) throws IOException {
		return us.login(vo, session, req, res);
	}
	
	// 로그아웃 기능 실행
	@RequestMapping("logout")
	public ModelAndView logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		return us.logout(session, req, res);
	}
	
	// 회원가입 페이지 이동
	@RequestMapping("join")
	public void join() {
	}
	
	// 회원가입 기능 실행
	@PostMapping("join")
	public ModelAndView join(UserVO vo) {
		return us.join(vo);
	}
	
	// 유저 설정 페이지 이동
	@GetMapping("setting")
	public ModelAndView setting(HttpSession session) {
		return us.setting(session);
	}
	
	// 유저 카테고리 설정 페이지 이동
	@GetMapping("setting/category")
	public ModelAndView category(HttpSession session) {
		return us.category(session);
	}
	
	// 프로필 수정
	@PostMapping("setting")
	public ModelAndView updateProfileImg(MultipartHttpServletRequest req){
		return us.settingUser(req);
	}
	
	// 프로필 이미지 가져오기
	@RequestMapping("{email:.+}/getProfileImg")
	public ResponseEntity<byte[]> getProfileImg(@PathVariable("email")String email){
		return us.getProfileImg(email);
	}
	
}
