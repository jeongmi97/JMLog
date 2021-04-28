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
	
	// 유저 보드 페이지
	@GetMapping("{email:.+}")
	public ModelAndView board(@PathVariable("email")String email) {
		return ubs.userBoard(email);
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping("write")
	public void write(@ModelAttribute("post")BoardVO vo) {
		System.out.println("write 페이지 이동");
	}
	
	// 글쓰기 실행
	@PostMapping("write")
	public ModelAndView write(BoardVO vo, @ModelAttribute("login") UserVO login,RedirectAttributes ra, @RequestParam("mode")String mode) {
		return ubs.write(vo, login, ra, mode);
	}
	
	// 방명록
	@RequestMapping("{email:.+}/guestbook")
	public ModelAndView guestbook(@PathVariable("email")String email) {
		System.out.println("방병록 페이지 이동");
		ModelAndView mav = new ModelAndView("guestbook");
		return mav;
		
	}
	
	// 게시글 이동
	@GetMapping("{email:.+}/{idx}")
	public ModelAndView viewPost(@PathVariable("idx")int idx) {
		return ubs.viewPost(idx);
	}
	
	// 소개
	@GetMapping("{email:.+}/about")
	public ModelAndView about(@PathVariable("email")String email) {
		return ubs.about(email);
	}
	
	// 게시글 수정 선택 시
	@GetMapping("editPost")
	public ModelAndView editPost(@RequestParam("idx")int idx,@RequestParam("mode")String mode) {
		return ubs.editPost(idx, mode);
	}
	
	@GetMapping("delPost/{idx}")
	public ModelAndView delPost(@PathVariable("idx")int idx,@ModelAttribute("login") UserVO login) {
		return ubs.delPost(idx, login);
	}
	
}
