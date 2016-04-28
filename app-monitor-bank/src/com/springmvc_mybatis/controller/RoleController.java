package com.springmvc_mybatis.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.Role;
import com.springmvc_mybatis.mapper.PermissionMapper;
import com.springmvc_mybatis.service.PermissionService;
import com.springmvc_mybatis.service.RoleService;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.ResponseJsonResult;

@Controller
@RequestMapping("/role")
public class RoleController {
		
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	@Qualifier("roleService")
	private RoleService roleService;
	
	@Autowired
	@Qualifier("permissionService")
	private PermissionService permissionService;
	
	@Autowired
	private PermissionMapper permissionMapper;
	
	@RequestMapping("/roleList")
	public String roleList(Model model) {
		try {
			List<Role> roles = roleService.getRoles();
			model.addAttribute("roles", roles);
			model.addAttribute("success", 1);
		} catch (Exception e) {
			model.addAttribute("msg", "查询失败，请重试！");
			model.addAttribute("success", 0);
			logger.warn(e);
		}
		return "roleList";
	}
	
	
	@RequestMapping("/addRole")
	public void addRole(HttpServletResponse response,Role role){
		try {
			roleService.addRole(role);
			new ResponseJsonResult(1,"添加成功",null,response);
		} catch (CheckException e) {
			new ResponseJsonResult(0,e.getMessage(),null,response);
			logger.error(e);
		} catch (Exception e) {
			new ResponseJsonResult(0,e.getMessage(),null,response);
			logger.error(e);
		}
	}
	
	@RequestMapping("/deleteRole")
	public void deleteRole(HttpServletResponse response,Role role){
		try {
			roleService.deleteRole(role);
			new ResponseJsonResult(1,"删除成功！",null,response);
		} catch (CheckException e) {
			new ResponseJsonResult(0,e.getMessage(),null,response);
			logger.error(e);
		} catch (Exception e) {
			new ResponseJsonResult(0,e.getMessage(),null,response);
			logger.error(e);
		}
	}
	
	@RequestMapping("/toAddRole")
	public String toAddRole(Model model){
		roleService.toAddRole(model);
		return "addRole";
	}
	
	@RequestMapping("/toModifyRole")
	public String toModifyUser(Model model,Role role){
		try {
			roleService.toModifyRole(role, model);
		} catch (CheckException e) {
			logger.error(e);
		} catch (Exception e) {
			logger.error(e);
		}
		return "modifyRole";
	}
	
	@RequestMapping("/modifyRole")
	public void modifyRole(HttpServletResponse response,Role role){
		try {
			roleService.modifyRole(role);
			new ResponseJsonResult(1,"修改成功！",null,response);
		} catch (CheckException e) {
			new ResponseJsonResult(0,e.getMessage(),null,response);
			logger.error(e);
		} catch (Exception e) {
			new ResponseJsonResult(0,e.getMessage(),null,response);
			logger.error(e);
		}
	}
}
