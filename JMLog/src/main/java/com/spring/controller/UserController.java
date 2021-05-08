package com.spring.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@PostMapping("setting/profileImg")
	public String updateProfileImg(@SessionAttribute("login")UserVO user , MultipartFile profileImg) throws IOException{
		String basePath = "profile";
		String fileName = profileImg.getOriginalFilename();
		
		if(profileImg.isEmpty()) return "redirect:/setting";
		if(fileName.equals("default.png")) {
			throw new RuntimeException("Invalid file name");
		}
		us.addProfileImg(profileImg, basePath, user);
		
		return "redirect:/member/setting";
	}
}
