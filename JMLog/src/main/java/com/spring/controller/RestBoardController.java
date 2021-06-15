package com.spring.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.spring.service.UserBoardService;
import com.spring.vo.ReplyVO;

@RestController
public class RestBoardController {
	
	@Autowired UserBoardService ubs;
	
	// 댓글 저장
	@PostMapping(value="{nickname}/{idx}/saveReply")
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
	@GetMapping(value="{nickname}/{idx}/delReply")
	public String delReply(@RequestParam("idx")int idx) {
		try {
			ubs.delReply(idx);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
	
	// 댓글 수정
	@PostMapping(value="{nickname}/{idx}/updateReply")
	public int updateReply(@RequestBody ReplyVO reply) {
		try {
			ubs.updateReply(reply);
			return reply.getIdx();
		}catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	// 카테고리 삭제
	@PostMapping(value="setting/category/delCategory")
	public String delCate(@RequestParam Map<String, Object> param) {
		try {
			ubs.delCate(param);
			return "ok";
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
	}
	
	// 카테고리 수정
	@PostMapping(value="setting/category/updateCategory")
	public String updateCate(@RequestParam Map<String, Object> param) {
		try {
			ubs.updateCate(param);
			return (String) param.get("catename");
		}catch (Exception e) {
			e.printStackTrace();
			return "false";
		}
		
	}
	
	// 방명록 삭제
	@GetMapping(value="{nickname}/guestbook/delGuest")
	public void delGuest(@RequestParam("idx")int idx) {
		try {
			ubs.delGuest(idx);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
}
