package com.springmvc_mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc_mybatis.bean.User;

//userMapper只能传入一个参数,多个的话需要注解
public interface UserMapper {

    // value 必须与Bean 属性一致！
    User login(@Param(value = "userName") String userName,
            @Param(value = "password") String password);

    List<User> getAllUsers();

    Integer addUser(User user);

    User findByColumns(User user);

    User findById(@Param(value = "userId") Integer userId);

    List<User> findAllByColumns(User user);

    int deleteUser(@Param(value = "userId") Integer userId);

    int updateUser(User user);

    int updatePassword(@Param(value = "userId") Integer userId,
            @Param(value = "password") String password);
}
