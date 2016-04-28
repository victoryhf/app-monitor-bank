package com.springmvc_mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc_mybatis.bean.Role;

//userMapper只能传入一个参数,多个的话需要注解
public interface RoleMapper {
	//根据条件查找
	Role findBycolumns(Role role);
	
	//根据条件查找集合
	List<Role> findListBycolumns(Role role);
	
	Role findById(@Param(value = "roleId") Integer roleId);
	
	List<Role> findAll();
	
	int addRole(Role role);
	
	int updateRole(Role role);
	
	int deleteRole(@Param(value = "roleId") Integer roleId);
}
