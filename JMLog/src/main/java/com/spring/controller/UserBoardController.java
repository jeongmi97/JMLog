package com.spring.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

import com.spring.service.UserBoardService;
import com.spring.vo.BoardVO;
import com.spring.vo.GuestbookVO;
import com.spring.vo.UserVO;

@Controller
@SessionAttributes("login")
public class UserBoardController {
	
	@Autowired UserBoardService ubs;
	
	// 기본 홈 페이지(인기순)
	@GetMapping(value= {"/","/home"})
	public ModelAndView home(@RequestParam(required = false, defaultValue = "1") int page	// 화면에서 안넘어 왔을 때 기본값 1
							, @RequestParam(required = false, defaultValue = "1") int range) {
		return ubs.home(page, range);
	}
	
	// 홈 페이지(최신순)
	@GetMapping("newlist")
	public ModelAndView newlist(@RequestParam(required = false, defaultValue = "1") int page	// 화면에서 안넘어 왔을 때 기본값 1
							, @RequestParam(required = false, defaultValue = "1") int range) {
		return ubs.newlist(page, range);
	}
	
	// 유저 보드 페이지
	@GetMapping("{nickname}")
	public ModelAndView board(@PathVariable("nickname")String nickname
			, HttpSession session
			, @RequestParam(required = false, defaultValue = "1") int page	// 화면에서 안넘어 왔을 때 기본값 1
			, @RequestParam(required = false, defaultValue = "1") int range
			, @RequestParam(required = false, defaultValue = "nocate")String category) {
		return ubs.userBoard(nickname, session, page, range, category);
	}
	
	// 글쓰기 페이지 이동
	@RequestMapping("write")
	public ModelAndView write(@ModelAttribute("post")BoardVO vo, @ModelAttribute("login") UserVO login) {
		return ubs.goWrite(login);
	}
	
	// 글쓰기 실행
	@PostMapping("write")
	public ModelAndView write(BoardVO vo, @RequestParam("mode")String mode, @ModelAttribute("login") UserVO login) throws Exception {
		return ubs.write(vo, mode, login);
	}
	
	// 방명록
	@RequestMapping("{nickname}/guestbook")
	public ModelAndView guestbook(@PathVariable("nickname")String nickname) {
		return ubs.guestbook(nickname);
		
	}
	
	// 방명록 작성
	@PostMapping("{nickname}/guestbook")
	public ModelAndView inserguest(GuestbookVO vo) throws Exception {
		return ubs.insertguest(vo);
	}
	
	// 방명록 수정
	@PostMapping("{nickname}/guestbook/update")
	public ModelAndView updateguest(GuestbookVO vo) throws Exception {
		return ubs.updateguest(vo);
	}
	
	// 게시글 이동
	@GetMapping("{nickname}/{idx}")
	public ModelAndView viewPost(@PathVariable("idx")int idx) {
		return ubs.viewPost(idx);
	}
	
	// 소개글 이동
	@GetMapping("{nickname}/about")
	public ModelAndView about(@PathVariable("nickname")String nickname) {
		return ubs.about(nickname);
	}
	
	// 소개글 작성
	@PostMapping("{nickname}/about")
	public ModelAndView about(BoardVO vo) throws Exception {
		return ubs.writeAbout(vo);
	}
	
	// 소개글 수정
	@PostMapping("{nickname}/about/update")
	public ModelAndView updateAbout(BoardVO vo) throws Exception {
		return ubs.updateAbout(vo);
	}
	
	// 게시글 수정 선택 시
	@GetMapping("editPost")
	public ModelAndView editPost(@RequestParam("idx")int idx,@RequestParam("mode")String mode, @ModelAttribute("login") UserVO login) {
		return ubs.editPost(idx, mode, login);
	}
	
	// 게시글 삭제
	@GetMapping("delPost/{idx}")
	public ModelAndView delPost(@PathVariable("idx")int idx,@ModelAttribute("login") UserVO login) throws Exception {
		return ubs.delPost(idx, login);
	}
	
	// 카테고리 설정
	@PostMapping(value="setting/category")
	public ModelAndView setCategory(HttpServletRequest req) {
		return ubs.setCategory(req);
	}
	
}
