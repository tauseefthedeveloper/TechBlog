package com.techBlog.entities;

import java.sql.Timestamp;

public class Comments {
	private int commentId;
	private int userId;
	private int postId;
	private String commentMessage;
	private Timestamp rDate;
	public Comments() {

	}
	public Comments(int commentId, int userId, int postId, String commentMessage,Timestamp rDate) {
		super();
		this.commentId = commentId;
		this.userId = userId;
		this.postId = postId;
		this.commentMessage = commentMessage;
		this.rDate=rDate;
	}
	public Comments(int userId, int postId, String commentMessage,Timestamp rDate) {
		super();
		this.userId = userId;
		this.postId = postId;
		this.commentMessage = commentMessage;
		this.rDate=rDate;
	}
	public Comments(int userId, int postId, String commentMessage) {
		super();
		this.userId = userId;
		this.postId = postId;
		this.commentMessage = commentMessage;
	}
	public Timestamp getrDate() {
		return rDate;
	}
	public void setrDate(Timestamp rDate) {
		this.rDate = rDate;
	}
	public int getCommentId() {
		return commentId;
	}
	public void setCommentId(int commentId) {
		this.commentId = commentId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getCommentMessage() {
		return commentMessage;
	}
	public void setCommentMessage(String commentMessage) {
		this.commentMessage = commentMessage;
	}


}
