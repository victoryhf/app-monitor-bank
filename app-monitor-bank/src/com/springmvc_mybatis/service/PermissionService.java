package com.springmvc_mybatis.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc_mybatis.mapper.PermissionMapper;

@Service("permissionService")
public class PermissionService {
	
	@Autowired
	private PermissionMapper permissionMapper;
	
}
