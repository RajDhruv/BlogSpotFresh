package com.Bean;

public class Comment {
	private String id;
	private String description;
	private String blog_id;
	private String created_by;
	private String created_at;
	private String lock_version;
	public Comment() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Comment(String id, String description, String blog_id, String created_by, String created_at,
			String lock_version) {
		super();
		this.id = id;
		this.description = description;
		this.blog_id = blog_id;
		this.created_by = created_by;
		this.created_at = created_at;
		this.lock_version = lock_version;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getBlog_id() {
		return blog_id;
	}
	public void setBlog_id(String blog_id) {
		this.blog_id = blog_id;
	}
	public String getCreated_by() {
		return created_by;
	}
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getLock_version() {
		return lock_version;
	}
	public void setLock_version(String lock_version) {
		this.lock_version = lock_version;
	}
	
}
