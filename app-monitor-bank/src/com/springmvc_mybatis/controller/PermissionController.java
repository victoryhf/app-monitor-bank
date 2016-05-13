package com.springmvc_mybatis.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.Permission;
import com.springmvc_mybatis.mapper.PermissionMapper;
import com.springmvc_mybatis.service.PermissionService;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.ResponseJsonResult;

@Controller
@RequestMapping("/permission")
public class PermissionController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    @Qualifier("permissionService")
    private PermissionService permissionService;

    @Autowired
    private PermissionMapper permissionMapper;

    @RequestMapping("/permissionList")
    public String permissionList(Model model) {
        try {
            List<Permission> permissions = permissionService.getPermissions();
            model.addAttribute("permissions", permissions);
            model.addAttribute("success", 1);
        } catch (Exception e) {
            model.addAttribute("msg", "查询失败，请重试！");
            model.addAttribute("success", 0);
            logger.warn(e);
        }
        return "permissionList";
    }

    @RequestMapping("/addPermission")
    public void addPermission(HttpServletResponse response,
            Permission permission) {
        try {
            permissionService.addPermission(permission);
            new ResponseJsonResult(1, "添加成功", null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        }
    }

    @RequestMapping("/deletePermission")
    public void deletePermission(HttpServletResponse response,
            Permission permission) {
        try {
            permissionService.deletePermission(permission);
            new ResponseJsonResult(1, "删除成功！", null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        }
    }

    @RequestMapping("/toModifyPermission")
    public String toModifyUser(Model model, Permission permission) {
        try {
            permissionService.toModifyPermission(permission, model);
        } catch (CheckException e) {
            logger.error(e);
        } catch (Exception e) {
            logger.error(e);
        }
        return "modifyPermission";
    }

    @RequestMapping("/modifyPermission")
    public void modifyPermission(HttpServletResponse response,
            Permission permission) {
        try {
            permissionService.modifyPermission(permission);
            new ResponseJsonResult(1, "修改成功！", null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        }
    }
}
