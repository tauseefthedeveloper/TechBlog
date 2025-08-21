package com.techBlog.entities;

import java.sql.Timestamp;

public class RepliesOnComment {
	private int replyId;
	private int commId;
	private int UId;
	private int postId;
	private String replyMessage;
	private Timestamp rDate;
	private int parent_reply_id;
	public RepliesOnComment() {

	}
	public RepliesOnComment(int replyId, int commId, int uId, int postId, String replyMessage, Timestamp rDate,int parent_reply_id) {
		this.replyId = replyId;
		this.commId = commId;
		UId = uId;
		this.postId = postId;
		this.replyMessage = replyMessage;
		this.rDate = rDate;
		this.parent_reply_id=parent_reply_id;
	}
	public RepliesOnComment(int commId, int uId, int postId, String replyMessage, Timestamp rDate,int parent_reply_id) {
		this.commId = commId;
		UId = uId;
		this.postId = postId;
		this.replyMessage = replyMessage;
		this.rDate = rDate;
		this.parent_reply_id=parent_reply_id;
	}
	public RepliesOnComment(int commId, int uId, int postId, String replyMessage, Timestamp rDate) {
		this.commId = commId;
		UId = uId;
		this.postId = postId;
		this.replyMessage = replyMessage;
		this.rDate = rDate;
	}
	public RepliesOnComment(int commId, int uId, int postId, String replyMessage,int parent_reply_id) {
		this.commId = commId;
		UId = uId;
		this.postId = postId;
		this.replyMessage = replyMessage;
		this.parent_reply_id=parent_reply_id;
	}
	public RepliesOnComment(int commId, int uId, int postId, String replyMessage) {
		this.commId = commId;
		UId = uId;
		this.postId = postId;
		this.replyMessage = replyMessage;
	}
	public int getParent_reply_id() {
		return parent_reply_id;
	}
	public void setParent_reply_id(int parent_reply_id) {
		this.parent_reply_id = parent_reply_id;
	}
	public int getReplyId() {
		return replyId;
	}
	public void setReplyId(int replyId) {
		this.replyId = replyId;
	}
	public int getCommId() {
		return commId;
	}
	public void setCommId(int commId) {
		this.commId = commId;
	}
	public int getUId() {
		return UId;
	}
	public void setUId(int uId) {
		UId = uId;
	}
	public int getPostId() {
		return postId;
	}
	public void setPostId(int postId) {
		this.postId = postId;
	}
	public String getReplyMessage() {
		return replyMessage;
	}
	public void setReplyMessage(String replyMessage) {
		this.replyMessage = replyMessage;
	}
	public Timestamp getrDate() {
		return rDate;
	}
	public void setrDate(Timestamp rdate) {
		this.rDate = rdate;
	}


}
