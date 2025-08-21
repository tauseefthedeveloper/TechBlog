package com.techBlog.entities;

public class Categories {
	private int id;
	private String name;
	private String Description;
	public Categories() {

	}
	public Categories(int id, String name, String description) {
		super();
		this.id = id;
		this.name = name;
		Description = description;
	}
	public Categories(String name, String description) {
		this.name = name;
		Description = description;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return Description;
	}
	public void setDescription(String description) {
		Description = description;
	}



}
