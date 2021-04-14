package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dao.UserBoardDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.UserVO;

@Service
public class UserBoardService {

	@Autowired UserBoardDAO dao;
	
	public ModelAndView write(BoardVO vo, UserVO login, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView("redirect:/"+login.getEmail()+"/"+vo.getTitle());
		
		vo.setEmail(login.getEmail());
		dao.write(vo);
		ra.addAttribute("postid",vo.getIdx());
		
		return mav;
	}

	public ModelAndView viewPost(String email, String title, int postid) {
		ModelAndView mav = new ModelAndView("viewPost");
		
		BoardVO post = dao.getPost(postid);
		
		mav.addObject("post",post);
		
		return mav;
	}

}
