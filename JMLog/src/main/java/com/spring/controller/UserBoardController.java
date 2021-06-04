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
import com.spring.vo.ReplyVO;
import com.spring.vo.UserVO;

@Controller
@SessionAttributes("login")
public class UserBoardController {
	
	@Autowired UserBoardService ubs;
	
	@RequestMapping("/")
	public ModelAndView home() {
		return ubs.home();
	}
	
	// 유저 보드 페이지
	@GetMapping("{email:.+}")
	public ModelAndView board(@PathVariable("email")String email
			, @RequestParam(required = false, defaultValue = "1") int page	// 화면에서 안넘어 왔을 때 기본값 1
			, @RequestParam(required = false, defaultValue = "1") int range
			, @RequestParam(required = false, defaultValue = "nocate")String category) {
		return ubs.userBoard(email, page, range, category);
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping("write")
	public ModelAndView write(@ModelAttribute("post")BoardVO vo, @ModelAttribute("login") UserVO login) {
		return ubs.goWrite(login);
	}
	
	// 글쓰기 실행
	@PostMapping("write")
	public ModelAndView write(BoardVO vo, @RequestParam("mode")String mode) {
		return ubs.write(vo, mode);
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
	
	// 게시글 삭제
	@GetMapping("delPost/{idx}")
	public ModelAndView delPost(@PathVariable("idx")int idx,@ModelAttribute("login") UserVO login) {
		return ubs.delPost(idx, login);
	}
	
	// 닉네임 클릭 사용한 유저보드 이동
	@GetMapping("reply/{nickname}")
	public ModelAndView board(@PathVariable("nickname")String nickname) {
		return ubs.getEmail(nickname);
	}
}
