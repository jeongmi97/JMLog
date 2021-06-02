package com.spring.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.dao.UserBoardDAO;
import com.spring.dao.UserDAO;
import com.spring.vo.BoardVO;
import com.spring.vo.Pagination;
import com.spring.vo.ReplyVO;
import com.spring.vo.UserVO;

@Service
public class UserBoardService {

	@Autowired UserBoardDAO dao;
	@Autowired UserDAO udao;
	
	// 유저 블로그로 이동
		public ModelAndView userBoard(String email,int page, int range, String category) {
			ModelAndView mav = new ModelAndView("userBoard");
		
			System.out.println("넘어온 이메일 : " + email);
			
			int listCnt = dao.getBoardListCnt(email);	// 계정 전체 게시글 개수
			
			if(!category.equals("nocate")) {
				HashMap<String, Object> param = new HashMap<String, Object>();
				param.put("email", email);
				param.put("cate", category);
				listCnt = dao.getCateBoardList(param);
			}
				
			System.out.println("listCnt: " + listCnt + "page&range : " + page + "&" + range);
			
			// 페이징 정보 셋팅
			Pagination pagination = new Pagination();	
			pagination.setPage(page); pagination.setRange(range); pagination.setListCnt(listCnt);
			pagination.setPageCnt((int)Math.ceil((double)(listCnt)/(double)pagination.getListSize()));	// 총 개시물 개수/10(올림)
			System.out.println("pagecnt : " + pagination.getPageCnt());
			pagination.setStartPage((range-1) * pagination.getRangeSize() + 1);	// 시작 페이지
			pagination.setStartList((page-1) * pagination.getListSize());
			pagination.setEndPage(range * pagination.getRangeSize()); 			// 끝 페이지
			pagination.setPrev(range == 1 ? false : true);
			pagination.setNext(pagination.getEndPage() > pagination.getPageCnt() ? false : true);
			System.out.println("endPage&pageCnt : " + pagination.getEndPage() + "," + pagination.getPageCnt());
			if(pagination.getEndPage() > pagination.getPageCnt()) {
				pagination.setEndPage(pagination.getPageCnt());
				pagination.setNext(false);
			}
			
			HashMap<String, Object> param = new HashMap<String, Object>();	// 해당 계정의 포스트 10개씩 가져오기 위해 param 설정
			param.put("email", email);
			param.put("cate", category);
			param.put("startList", pagination.getStartList());
			
			mav.addObject("category", dao.getCategory(email));	// 유저 카테고리 정보 가져오기
			mav.addObject("user", udao.userChk(email));			// 계정 정보 넣기
			
			if(category.equals("nocate"))
				mav.addObject("uBoard",dao.userBoardList(param));	// 이메일, 10
			else
				mav.addObject("uBoard",dao.cateBoardList(param));	// 카테고리 별 보드 리스트
			
			mav.addObject("pagination",pagination);
			mav.addObject("nowCate", category);
			
			return mav;
		}
		
	// 글쓰기 페이지 이동
	public ModelAndView goWrite(UserVO login) {
		ModelAndView mav = new ModelAndView("write");
		
		mav.addObject("category", dao.getCategory(login.getEmail()));	// 글 생성 시 카테고리 선택을 위한 유저별 카테고리 넘김
		
		return mav;
	}
	
	// 글 쓰기
	public ModelAndView write(BoardVO vo, String mode) {
		ModelAndView mav = new ModelAndView();
		
		int postNum = 0;
		
		if(vo.getLock_post() != "y") vo.setLock_post("n");	// 비공개 체크 안했을 때 비공개 n 세팅
		
		if(mode.equals("edit")) {	// 게시물 수정모드일 때
			dao.updatePost(vo);		// 게시물 수정
			postNum = vo.getIdx();	// 수정한 게시물 번호
		}else {						// 새로운 게시물 생성 시
			dao.write(vo);			// 게시물 insert
			postNum = dao.getPostnum(vo.getEmail());	// 작성한 게시물 번호
		}
		
		if(vo.getCate() != "nocate") {
			HashMap<String, Object>param = new HashMap<String, Object>();
			param.put("email", vo.getEmail());
			param.put("cate", vo.getCate());
			int cateCnt = dao.getCateCnt(param);
			param.put("catecnt", cateCnt);
			dao.updateCateCnt(param);
		}
		
		mav.setViewName("redirect:/"+vo.getEmail()+"/"+postNum);	// 작성자 이메일/작성(수정)한 게시물번호로 이동
		
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

	// 닉네임 이용 해 유저보드 이동
	public ModelAndView getEmail(String nickname) {
		ModelAndView mav = new ModelAndView();
		
		String email = dao.getEmail(nickname);
		mav.setViewName("redirect:/"+email);
		
		return mav;
	}

}
