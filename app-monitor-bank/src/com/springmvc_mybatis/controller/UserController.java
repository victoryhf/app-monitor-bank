package com.springmvc_mybatis.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.Role;
import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.service.PermissionService;
import com.springmvc_mybatis.service.RoleService;
import com.springmvc_mybatis.service.UserService;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.EmptyUtil;
import com.springmvc_mybatis.tools.GlobalVariable;
import com.springmvc_mybatis.tools.ResponseJsonResult;

@Controller
@RequestMapping("/user")
public class UserController {

    private Logger logger = Logger.getLogger(this.getClass());

    @Autowired
    @Qualifier("userService")
    private UserService userService;

    @Autowired
    @Qualifier("roleService")
    private RoleService roleService;
    
    @Autowired
    @Qualifier("permissionService")
    private PermissionService permissionService;

    /**
     * 用户登录
     * 
     * @author xuqq 2016年4月20日 下午5:24:29
     * 
     * @param request
     * @param model
     * @param user
     * @return
     */
    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model, User user) {
        String failUrl = "redirect:https://sars.99bill.net/sor/app-monitor-bank/login.jsp";
        try {
            String sessionMapId = userService.login(user, request);
            model.addAttribute("sessionMapId",sessionMapId);
            return "background";
        } catch (CheckException e) {
            logger.warn(e.getMessage());
            model.addAttribute("msg", e.getMessage());
            return failUrl;
        } catch (Exception e) {
            logger.warn(e.getStackTrace());
            e.printStackTrace();
            model.addAttribute("msg", "登录失败，请重试");
            return failUrl;
        }

    }

    @RequestMapping("/logout")
    public void logout(HttpServletRequest request, HttpServletResponse response) {
        try {
            String sessionMapId = request.getParameter("sessionMapId");
            if(EmptyUtil.isNotEmpty(sessionMapId)){
                request.getSession().removeAttribute("user");
                GlobalVariable.sessionMap.remove(sessionMapId);
            }
            new ResponseJsonResult(1, "退成成功！", null, response);
        } catch (Exception e) {
            logger.warn(e.getStackTrace());
            new ResponseJsonResult(0, null, null, response);
        }

    }

    /**
     * 查询所有用户
     * 
     * @author xuqq 2016年4月26日 上午10:40:03
     * 
     * @param request
     * @param model
     * @return
     */
    @RequestMapping("/getAllUsers")
    public String getAllUsers(Model model) {
        try {
            List<User> users = userService.getAllUsers();
            model.addAttribute("users", users);
            model.addAttribute("success", 1);
        } catch (CheckException e) {
            model.addAttribute("msg", e.getMessage());
            model.addAttribute("success", 0);
            logger.warn(e);
        } catch (Exception e) {
            model.addAttribute("msg", "查询失败，请重试！");
            model.addAttribute("success", 0);
            logger.warn(e);
        }
        return "userlist";
    }

    @RequestMapping("/toAddUser")
    public String toAddUser(Model model) {
        List<Role> roles = roleService.getRoles();
        model.addAttribute("roles", roles);
        return "addUser";
    }

    /**
     * 添加用户
     * 
     * @author xuqq 2016年4月26日 上午11:06:20
     * 
     * @param request
     * @param model
     * @param user
     * @return
     */
    @RequestMapping("/addUser")
    public void addUser(HttpServletResponse response, User user) {
        try {
            userService.addUser(user);
            new ResponseJsonResult(1, "添加成功！", null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        }
    }

    /**
     * 删除用户
     * 
     * @author xuqq 2016年4月26日 下午4:40:29
     * 
     * @param request
     * @param response
     * @param user
     */
    @RequestMapping("/deleteUser")
    public void deleteUser(HttpServletRequest request,
            HttpServletResponse response, User user) {
        try {
            userService.deleteUser(user);
            new ResponseJsonResult(1, null, null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        }
    }

    /**
     * 跳转到修改用户页面
     * 
     * @author xuqq 2016年4月26日 下午4:51:30
     * 
     * @param model
     * @return
     */
    @RequestMapping("/toModifyUser")
    public String toModifyUser(Model model, User user) {
        userService.toModifyUser(user, model);
        return "modifyUser";
    }

    /**
     * 修改用户信息
     * 
     * @author xuqq 2016年4月26日 下午5:37:27
     * 
     * @param response
     * @param user
     */
    @RequestMapping("/modifyUser")
    public void modifyUser(HttpServletResponse response, User user) {
        try {
            userService.modifyUser(user);
            new ResponseJsonResult(1, "修改成功！", null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        }
    }

    @RequestMapping("/modifyPassWord")
    public void modifyPassWord(HttpServletResponse response,
            HttpServletRequest request) {
        try {
            userService.modifyUser(request);
            new ResponseJsonResult(1, "密码修改成功！", null, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, e.getMessage(), null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, "密码修改失败，请重试！", null, response);
            logger.error(e);
        }
    }
    
    @RequestMapping("checkSession")
    public void checkSession(HttpServletResponse response,HttpServletRequest request) {
        try {
            if(EmptyUtil.isEmpty(request.getParameter("sessionMapId")) ){
                throw new CheckException("缺少sessionMapId");
            }
            if(EmptyUtil.isEmpty(request.getParameter("url")) ){
                throw new CheckException("缺少sessionMapId");
            }
            User user = (User) GlobalVariable.sessionMap.get(request.getParameter("sessionMapId").toString());
            if(EmptyUtil.isEmpty(user)){
                throw new CheckException("没有session");
            }
            
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userName", user.getUserName());
            map.put("roleName", user.getRole().getRoleName());
           /* map.put("available", (user.getRole().getRolePermission() & 2));
            map.put("request", (user.getRole().getRolePermission() & 4));
            map.put("sla", (user.getRole().getRolePermission() & 8));*/
            map.put("getAllUsers", (user.getRole().getRolePermission() & 16));
            map.put("roleList", (user.getRole().getRolePermission() & 32));
            map.put("configlist", (user.getRole().getRolePermission() & 64));
            map.put("pageShowConfigList", (user.getRole().getRolePermission() & 128));
            if(!permissionService.checkPermission(request.getParameter("url").toString(), user.getRole().getRolePermission())){
                throw new CheckException("没有权限");
            }
            new ResponseJsonResult(1, null, map, response);
        } catch (CheckException e) {
            new ResponseJsonResult(0, null, null, response);
            logger.error(e);
        } catch (Exception e) {
            new ResponseJsonResult(0, null, null, response);
            logger.error(e);
        }
    }
}
