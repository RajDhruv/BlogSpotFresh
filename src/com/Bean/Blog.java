package com.Bean;

public class Blog {
	private String id;
	private String title;
	private String description;
	private String created_by;
	private String updated_by;
	private String created_at;
	private String updated_at;
	private String lock_version;
	public Blog() {
		super();
	}
	public Blog(String id, String title, String description, String created_by, String updated_by, String created_at,
			String updated_at, String lock_version) {
		super();
		this.id = id;
		this.title = title;
		this.description = description;
		this.created_by = created_by;
		this.updated_by = updated_by;
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.lock_version = lock_version;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getCreated_by() {
		return created_by;
	}
	public void setCreated_by(String created_by) {
		this.created_by = created_by;
	}
	public String getUpdated_by() {
		return updated_by;
	}
	public void setUpdated_by(String updated_by) {
		this.updated_by = updated_by;
	}
	public String getCreated_at() {
		return created_at;
	}
	public void setCreated_at(String created_at) {
		this.created_at = created_at;
	}
	public String getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(String updated_at) {
		this.updated_at = updated_at;
	}
	public String getLock_version() {
		return lock_version;
	}
	public void setLock_version(String lock_version) {
		this.lock_version = lock_version;
	}
	
}
