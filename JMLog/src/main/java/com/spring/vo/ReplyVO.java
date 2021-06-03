package com.spring.vo;

import java.sql.Date;

public class ReplyVO {
	
	private int idx;
	private int post_num;
	private String nickname;
	private int lock_reply;
	private String comment;
	private Date reply_date;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getPost_num() {
		return post_num;
	}
	public void setPost_num(int post_num) {
		this.post_num = post_num;
	}
	public int getLock_reply() {
		return lock_reply;
	}
	public void setLock_reply(int lock_reply) {
		this.lock_reply = lock_reply;
	}
	public Date getReply_date() {
		return reply_date;
	}
	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
}
