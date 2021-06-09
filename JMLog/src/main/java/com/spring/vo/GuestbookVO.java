package com.spring.vo;

import java.sql.Date;

public class GuestbookVO {
	private int idx;
	private String email;
	private String nickname;
	private String content;
	private Date guest_date;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getGuest_date() {
		return guest_date;
	}
	public void setGuest_date(Date guest_date) {
		this.guest_date = guest_date;
	}
	
	
}
