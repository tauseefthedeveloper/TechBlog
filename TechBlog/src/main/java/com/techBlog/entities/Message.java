package com.techBlog.entities;

public class Message {
	private String content;
	private String type;
	private String cssType;
	public Message(String content, String type, String cssType) {
		this.content = content;
		this.type = type;
		this.cssType = cssType;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCssType() {
		return cssType;
	}
	public void setCssType(String cssType) {
		this.cssType = cssType;
	}


}
