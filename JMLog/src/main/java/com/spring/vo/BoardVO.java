package com.spring.vo;

import java.sql.Date;

public class BoardVO {
	
	private int idx;
	private String title;
	private String content;
	private Date reporting_date;
	private int hit;		// 조회수
	private String nickname;	// 작성자 이메일
	private String lock_post;	// 비밀글 설정
	private String cate;	// 카테고리
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReporting_date() {
		return reporting_date;
	}
	public void setReporting_date(Date reporting_date) {
		this.reporting_date = reporting_date;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getLock_post() {
		return lock_post;
	}
	public void setLock_post(String lock_post) {
		this.lock_post = lock_post;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	
	@Override
	public String toString() {
		return "유저보드 date : " + getReporting_date() + ", title : " + getTitle();
	}
}
