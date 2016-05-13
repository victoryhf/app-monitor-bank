package com.springmvc_mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc_mybatis.bean.Permission;

//userMapper只能传入一个参数,多个的话需要注解
public interface PermissionMapper {
    // 根据条件查找
    Permission findBycolumns(Permission permission);

    // 根据条件查找集合
    List<Permission> findListBycolumns(Permission permission);

    List<Permission> findAll();

    Permission findById(@Param(value = "permissionId") Integer permissionId);

    /**
     * 根据角色权限值查询起所有权限
     * 
     * @author xuqq 2016年4月27日 上午9:28:48
     * 
     * @return
     */
    List<Permission> findAllLimitRole(
            @Param(value = "rolePerValue") Integer rolePerValue);

    int addPermission(Permission permission);

    int updatePermission(Permission permission);

    int deletePermission(@Param(value = "permissionId") Integer permissionId);
}
