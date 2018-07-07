package com.Bean;

public class User {
 private String usrid;
 private String first_name;
 private String last_name;
 private String user_id;
 private String password;
 private String email_id;
 private String phone_no;
 private String address;
public User() {
	super();
}
public User(String usrid, String first_name, String last_name, String user_id, String password, String email_id, String phone_no, String address) {
	super();
	this.usrid=usrid;
	this.first_name = first_name;
	this.last_name = last_name;
	this.user_id = user_id;
	this.password = password;
	this.email_id = email_id;
	this.phone_no = phone_no;
	this.address = address;
}
public String getUsrid(){
	return usrid;
}

public void setUsrid(String usrid)
{
	this.usrid=usrid;
}

public String getFirst_name() {
	return first_name;
}
public void setFirst_name(String first_name) {
	this.first_name = first_name;
}
public String getLast_name() {
	return last_name;
}
public void setLast_name(String last_name) {
	this.last_name = last_name;
}
public String getUser_id() {
	return user_id;
}
public void setUser_id(String user_id) {
	this.user_id = user_id;
}
public String getPassword() {
	return password;
}
public void setPassword(String password) {
	this.password = password;
}
public String getEmail_id() {
	return email_id;
}
public void setEmail_id(String email_id) {
	this.email_id = email_id;
}
public String getPhone_no() {
	return phone_no;
}
public void setPhone_no(String phone_no) {
	this.phone_no = phone_no;
}
public String getAddress() {
	return address;
}
public void setAddress(String address) {
	this.address = address;
}
 
}
