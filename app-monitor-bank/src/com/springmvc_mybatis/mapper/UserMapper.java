package com.springmvc_mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc_mybatis.bean.User;

//userMapper只能传入一个参数,多个的话需要注解
public interface UserMapper {

	//value 必须与Bean 属性一致！
	User login(@Param(value = "name") String name,
			@Param(value = "password") String password);

	List<User> getAllUsers();
}
