package com.Bean;

public class Like {
	private String id;
	private String like_type;
	private String node_id;
	private String created_by;
	private String created_at;
	private String lock_version;
	public Like() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Like(String id, String like_type, String node_id, String created_by, String created_at,
			String lock_version) {
		super();
		this.id = id;
		this.like_type = like_type;
		this.node_id = node_id;
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
	public String getLike_type() {
		return like_type;
	}
	public void setLike_type(String like_type) {
		this.like_type = like_type;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
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
