package com.spring.vo;

import java.util.Date;

public class BoardVO {
	
	private int idx;
	private String title;
	private String content;
	private Date reporting_date;
	private int hit;
	private String email;
	private int lock_post;
	private String cate;
	
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getLock_post() {
		return lock_post;
	}
	public void setLock_post(int lock_post) {
		this.lock_post = lock_post;
	}
	public String getCate() {
		return cate;
	}
	public void setCate(String cate) {
		this.cate = cate;
	}
	
	
}
