package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.service.UserBoardService;
import com.spring.vo.BoardVO;
import com.spring.vo.UserVO;

@Controller
@SessionAttributes("login")
public class UserBoardController {
	
	@Autowired UserBoardService ubs;
	
	@GetMapping("{email:.+}")
	public ModelAndView board(@PathVariable("email")String email) {
		return ubs.userBoard(email);
	}
	
	@RequestMapping("write")
	public void write() {
		System.out.println("write 페이지 이동");
	}
	
	@PostMapping("write")
	public ModelAndView write(BoardVO vo, @ModelAttribute("login") UserVO login,RedirectAttributes ra) {
		return ubs.write(vo, login, ra);
	}
	
	@RequestMapping("{nickname}/guestbook")
	public ModelAndView guestbook(@PathVariable("nickname")String nickname) {
		System.out.println("방병록 페이지 이동");
		ModelAndView mav = new ModelAndView("guestbook");
		return mav;
		
	}
	
	@RequestMapping("{email}/{title}")
	public ModelAndView viewPost(@PathVariable("email")String email, @PathVariable("title")String title, @RequestParam(value="postid")int postid) {
		return ubs.viewPost(email, title, postid);
	}
}
