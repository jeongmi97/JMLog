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
	@Autowired UserDAO dao;
	
	@RequestMapping("login")
	public void login() {
		System.out.println("login 페이지 이동");
	}
	
	@PostMapping("login")
	public ModelAndView login(UserVO vo, HttpSession session, HttpServletRequest req ,HttpServletResponse res) throws IOException {
		return us.login(vo, session, req, res);
	}
	
	@RequestMapping("logout")
	public ModelAndView logout(HttpSession session, HttpServletRequest req, HttpServletResponse res) {
		return us.logout(session, req, res);
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
	public @ResponseBody String nicknameChk(@RequestParam("nickname")String nickname) {
		String chk = us.nicknameChk(nickname);
		System.out.println("닉네임 체크 : " + chk);
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
		System.out.println("이미지 가져옴");
		return us.getProfileImg(email);
	}
	
	// 프로필 이미지 제거
	@GetMapping("delimg")
	public @ResponseBody void delimg(@RequestParam("email")String email) {
		dao.delimg(email);
	}
	
	@GetMapping("deuser")
	public @ResponseBody void deluser(@RequestParam("nickname")String nickname, HttpSession session) {
		us.deluser(nickname, session);
		
		
	}
}
