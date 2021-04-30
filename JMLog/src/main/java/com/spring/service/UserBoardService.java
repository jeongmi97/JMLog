package com.spring.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dao.UserBoardDAO;
import com.spring.dao.UserDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.ReplyVO;
import com.spring.vo.UserVO;

@Service
public class UserBoardService {

	@Autowired UserBoardDAO dao;
	@Autowired UserDAO udao;
	
	// 유저 블로그로 이동
		public ModelAndView userBoard(String email) {
			ModelAndView mav = new ModelAndView("userBoard");
		
			System.out.println("넘어온 이메일 : " + email);
			
			mav.addObject("user", udao.userChk(email));
			mav.addObject("uBoard",dao.userBoardList(email));
			System.out.println(dao.userBoardList(email).get(0).toString());
			return mav;
		}
	
	// 글 쓰기
	public ModelAndView write(BoardVO vo, UserVO login, RedirectAttributes ra, String mode) {
		ModelAndView mav = new ModelAndView();
		
		int postNum = 0;
		
		if(mode.equals("edit")) {
			dao.updatePost(vo);
			postNum = vo.getIdx();
		}else {
			vo.setEmail(login.getEmail());	// 입력폼에서 이메일 받게 수정하기~~~~~~~
			dao.write(vo);
			postNum = dao.getPostnum(login.getEmail());
		}
		
		mav.setViewName("redirect:/"+vo.getEmail()+"/"+postNum);
		
		return mav;
	}

	// 게시글 이동
	public ModelAndView viewPost(int idx) {
		ModelAndView mav = new ModelAndView("viewPost");
		
		mav.addObject("post",dao.getPost(idx));
		mav.addObject("reply",dao.getReply(idx));
		
		return mav;
	}

	// 소개
	public ModelAndView about(String email) {
		ModelAndView mav = new ModelAndView("about");
		
		return mav;
	}

	// 게시글 수정
	public ModelAndView editPost(int idx, String mode) {
		ModelAndView mav = new ModelAndView("write");
		
		BoardVO post = dao.getPost(idx);
		mav.addObject("post",post);
		mav.addObject("mode", mode);
		
		return mav;
	}

	// 게시글 삭제
	public ModelAndView delPost(int idx, UserVO login) {
		ModelAndView mav = new ModelAndView("redirect:/"+login.getEmail());
		
		dao.delPostReply(idx);
		dao.delPost(idx);	// 외래키 on delete 해결하기
		
		return mav;
	}

	// 댓글 작성
	public void saveReply(ReplyVO reply) {
		dao.saveReply(reply);
	}

	// 댓글 삭제
	public void delReply(int idx) {
		dao.delReply(idx);
	}
	
	// 댓글 인덱스 가져오기
	public int getReplyIdx(String nickname) {
		return dao.getReplyIdx(nickname);
	}

	// 댓글 수정
	public void updateReply(ReplyVO reply) {
		System.out.println("댓글 번호 : "+reply.getIdx()+"댓글 수정 내용 : " + reply.getComment());
		dao.updateReply(reply);
	}

}
