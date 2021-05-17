package com.spring.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.service.UserService;
import com.spring.vo.UserVO;

@Controller
public class UserController {
	
	@Autowired UserService us;
	
	@RequestMapping("login")
	public void login() {
		System.out.println("login 페이지 이동");
	}
	
	@PostMapping("login")
	public ModelAndView login(UserVO vo, HttpSession session) {
		return us.login(vo, session);
	}
	
	@RequestMapping("join")
	public void join() {
		System.out.println("join 페이지 이동");
	}
	
	@PostMapping("join")
	public ModelAndView join(UserVO vo) {
		return us.join(vo);
	}
	
	@GetMapping("emailCheck")
	public @ResponseBody int emailCheck(@RequestParam("email")String email) {
		int chk = us.emailCheck(email);
		return chk;
	}
	
	@GetMapping("setting")
	public ModelAndView setting(HttpSession session) {
		return us.setting(session);
	}
	
	@GetMapping("setting/category")
	public ModelAndView category(HttpSession session) {
		return us.category(session);
	}
	
	@GetMapping("nicknameChk")
	public @ResponseBody int nicknameChk(@RequestParam("nickname")String nickname) {
		int chk = us.nicknameChk(nickname);
		return chk;
	}
	
	// 프로필 수정
	@PostMapping("setting")
	public ModelAndView updateProfileImg(MultipartHttpServletRequest req){
		System.out.println("img : " + req.getFile("profileimg"));
		System.out.println("email : " + req.getParameter("email"));
		return us.settingUser(req);
	}
	
	// 프로필 이미지 가져오기
	@RequestMapping("{email:.+}/getProfileImg")
	public ResponseEntity<byte[]> getProfileImg(@PathVariable("email")String email){
		return us.getProfileImg(email);
	}
	
	// 카테고리 설정
	@PostMapping("setting/category")
	public ModelAndView setCategory(HttpServletRequest req) {
		return us.setCategory(req);
	}
	
	@GetMapping("setting/category/delCategory")
	public @ResponseBody String delCate(@RequestParam("idx")int idx) {
		try {
			us.delCate(idx);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
}
