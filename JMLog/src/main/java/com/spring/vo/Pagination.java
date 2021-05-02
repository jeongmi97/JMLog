package com.spring.vo;

import org.springframework.stereotype.Repository;

@Repository
public class Pagination {

	private int listSize = 10;	// 한 페이지 당 보여줄 리스트 개수
	private int rangeSize = 10;	// 현제 페이지에 나타낼 페이지 개수
	private int page;		// 현재 페이지
	private int range;		// 현재 페이지 범위
	private int listCnt;	// 게시물 총 개수
	private int pageCnt;	// 전체 페이지 범위의 개수
	private int startPage;	// 시작번호
	private int startList;
	private int endPage;	// 끝번호
	private boolean prev;	// 이전
	private boolean next;	// 다음
	
	public int getListSize() {
		return listSize;
	}
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
	public int getRangeSize() {
		return rangeSize;
	}
	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRange() {
		return range;
	}
	public void setRange(int range) {
		this.range = range;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getStartList() {
		return startList;
	}
	public void setStartList(int startList) {
		this.startList = startList;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	
	
	
}
