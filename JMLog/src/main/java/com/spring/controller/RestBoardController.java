package com.spring.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.spring.service.UserBoardService;
import com.spring.vo.BoardVO;
import com.spring.vo.CategoryVO;
import com.spring.vo.ReplyVO;

@RestController
public class RestBoardController {
	
	@Autowired UserBoardService ubs;
	
	// 댓글 저장
	@PostMapping(value="{email}/{idx}/saveReply")
	public int saveReply(@RequestBody ReplyVO reply) {
		try {
			ubs.saveReply(reply);
			int idx = ubs.getReplyIdx(reply.getNickname());
			return idx;
		}catch(Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	// 댓글 삭제
	@GetMapping(value="{email}/{idx}/delReply")
	public String delReply(@RequestParam("idx")int idx) {
		System.out.println("들어옴");
		try {
			ubs.delReply(idx);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
	
	// 댓글 수정
	@PostMapping(value="{email}/{idx}/updateReply")
	public int updateReply(@RequestBody ReplyVO reply) {
		System.out.println("수정 들어옴");
		try {
			ubs.updateReply(reply);
			return reply.getIdx();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	// 카테고리 삭제
	@GetMapping(value="setting/category/delCategory")
	public String delCate(@RequestParam("idx")int idx) {
		try {
			ubs.delCate(idx);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
	
	// 카테고리 수정
	@GetMapping(value="setting/category/updateCategory")
	public String updateCate(@RequestParam("oldcate")String oldcate,@RequestParam("idx")int idx, @RequestParam("catename")String catename,@RequestParam("email")String email) {
		try {
			ubs.updateCate(oldcate,idx,catename,email);
			return catename;
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
		
	}
		
	// 스크롤 페이징
	@GetMapping(value="home/getBoardList")
	public List<BoardVO> getBoardList(@RequestParam("page")int page){
		System.out.println("page ::: " + page);
		try {
			return ubs.getBoardList(page);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
}
