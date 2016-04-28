package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class Permission implements Serializable{
	
	private static final long serialVersionUID = -3428198086355289321L;

	private Integer permissionId;
	  
	private String permissionName;
	
	private Integer permissionValue;

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

	public String getPermissionName() {
		return permissionName;
	}

	public void setPermissionName(String permissionName) {
		this.permissionName = permissionName;
	}

	public Integer getPermissionValue() {
		return permissionValue;
	}

	public void setPermissionValue(Integer permissionValue) {
		this.permissionValue = permissionValue;
	}
	
	
}
