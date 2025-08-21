package com.techBlog.entities;

import java.sql.Timestamp;

public class Posts {
	private int Pid;
	private String title;
	private String content;
	private String code;
	private Timestamp date;
	private String pic;
	private int catId;
	private int userId;


	public Posts() {

	}

	public Posts(int pid, String title, String content, String code, Timestamp date, String pic,int catId,int userId) {
		super();
		Pid = pid;
		this.title = title;
		this.content = content;
		this.code = code;
		this.date = date;
		this.pic = pic;
		this.catId=catId;
		this.userId=userId;
	}

	public Posts(String title, String content, String code, Timestamp date, String pic,int catId,int userId) {
		this.title = title;
		this.content = content;
		this.code = code;
		this.date = date;
		this.pic = pic;
		this.catId=catId;
		this.userId=userId;
	}

	public int getPid() {
		return Pid;
	}
	public void setPid(int pid) {
		Pid = pid;
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
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}

	public int getCatId() {
		return catId;
	}

	public void setCatId(int catId) {
		this.catId = catId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}



}
