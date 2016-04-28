package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class User implements Serializable{

	private static final long serialVersionUID = -8151433569432403301L;
	private Integer userId;
	private String userName;
	private String password;
	//角色ID
	private Integer roleId;
	private Role role;
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}

	
}
