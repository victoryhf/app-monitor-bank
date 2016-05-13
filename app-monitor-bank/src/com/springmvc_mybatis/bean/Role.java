package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class Role implements Serializable {
    private static final long serialVersionUID = -2005380657740207501L;
    private Integer roleId;
    // 角色名
    private String roleName;
    // 角色权限
    private Integer rolePermission;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Integer getRolePermission() {
        return rolePermission;
    }

    public void setRolePermission(Integer rolePermission) {
        this.rolePermission = rolePermission;
    }

}
