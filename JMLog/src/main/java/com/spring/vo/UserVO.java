package com.spring.vo;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class UserVO {
	
	private String email;
	private String pw;
	private String nickname;
	private Date reservedate;
	private byte[] profileimg;
	private String imgtype;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public Date getReservedate() {
		return reservedate;
	}
	public void setReservedate(Date reservedate) {
		this.reservedate = reservedate;
	}
	public byte[] getProfileimg() {
		return profileimg;
	}
	public void setProfileimg(byte[] profileimg) {
		this.profileimg = profileimg;
	}
	public String getImgtype() {
		return imgtype;
	}
	public void setImgtype(String imgtype) {
		this.imgtype = imgtype;
	}
	
}
