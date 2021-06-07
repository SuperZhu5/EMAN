package com.entity;



public class User {
	/**
	 * 用户主键
	 */
	private String uid;
	/**
	 * 用户名
	 */
	private String uname;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 性别
	 */
	private String sex;
	/**
	 * 年龄
	 */
	private Integer age;
	
	public User() {
		
	}
	
	
	public User(String uid, String uname, String email, String password,
			String sex, Integer age) {
		super();
		this.uid = uid;
		this.uname = uname;
		this.email = email;
		this.password = password;
		this.sex = sex;
		this.age = age;
	}
	
	public void showField(){
		System.out.println("-----" + this.toString() + "-----");
		System.out.println("uid=" + this.uid);
		System.out.println("uname=" + this.uname);
		System.out.println("email=" + this.email);
		System.out.println("password=" + this.password);
		System.out.println("sex=" + this.sex);
		System.out.println("age=" + this.age);
		System.out.println("----------");
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public Integer getAge() {
		return age;
	}


	public void setAge(Integer age) {
		this.age = age;
	}


	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
