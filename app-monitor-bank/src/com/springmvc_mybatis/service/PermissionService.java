package com.springmvc_mybatis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc_mybatis.bean.Permission;
import com.springmvc_mybatis.mapper.PermissionMapper;
import com.springmvc_mybatis.tools.EmptyUtil;

@Service("permissionService")
public class PermissionService {
	
	@Autowired
	private PermissionMapper permissionMapper;
	
	/**
	 * 检测用户有没该路径的权限
	 * @author xuqq   2016年4月28日    下午3:13:53
	 *
	 * @param url
	 * @param rolePermission
	 * @return
	 */
	public boolean checkPermission(String url,Integer rolePermission){
		
		List<Permission> permissions = permissionMapper.findAll();
		
		Permission perm = null;
		
		for (Permission permission : permissions) {
			if(url.contains(permission.getPermissionUrl())){
				perm = permission;
			}
		}
		if(EmptyUtil.isEmpty(perm)){
			return true;
		}else {
			if((rolePermission & perm.getPermissionValue()) == perm.getPermissionValue()){
				return true;
			}
		}
		return false;
	}
}
