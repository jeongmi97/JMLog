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
	private int startPage;	
	private int startList;
	private int endPage;
	private boolean prev;
	private boolean next;
	
	public int getRangeSize() {
		return rangeSize;
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
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getStartList() {
		return startList;
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
	
	public void pageinfo(int page, int range, int listCnt) {
		System.out.println("pageinfo들어옴");
		this.page = page;
		this.range = range;
		this.listCnt = listCnt;
		
		// 전체 페이지 수
		this.pageCnt = (int)Math.ceil(listCnt/listSize);	// 게시물 개수 / 10
		
		// 시작 페이지
		this.startPage = (range-1) * rangeSize + 1;
		
		// 끝 페이지
		this.endPage = range * rangeSize;
		System.out.println("range*rangeSize= " + endPage);
		System.out.println("endPage : " + getEndPage());
		
		// 게시판 시작번호
		this.startList = (page-1) * listSize;
		
		// 이전 버튼 상태
		this.prev = range == 1 ? false : true;	// 1페이지 일 때 비활성화
		
		// 다음 버튼 상태
		this.next = endPage > pageCnt ? false : true;	// 
		if(this.endPage > this.pageCnt) {	// 마지막 번호 > 총 페이지 개수
			this.endPage = this.pageCnt;	// 마지막 번호 = 마지막 번호
			this.next = false;				// 다음 버튼 비활성화
		}
	}



	
}
