package com.springmvc_mybatis.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springmvc_mybatis.bean.Role;
import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.mapper.RoleMapper;
import com.springmvc_mybatis.mapper.UserMapper;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.EmptyUtil;
import com.springmvc_mybatis.tools.GlobalVariable;

@Service("userService")
public class UserService {
    @Autowired
    private UserMapper usermapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    @Qualifier("roleService")
    private RoleService roleService;

    /**
     * 用户登录
     * 
     * @author xuqq 2016年4月20日 下午5:24:18
     * 
     * @param user
     * @param request
     * @throws CheckException
     */
    public String login(User user, HttpServletRequest request)
            throws CheckException {
        if (EmptyUtil.isEmpty(user.getUserName())) {
            throw new CheckException("请填写用户名！");
        }

        if (EmptyUtil.isEmpty(user.getPassword())) {
            throw new CheckException("请填写用户名！");
        }

        User userLogin = usermapper.login(user.getUserName(),
                user.getPassword());
        if (EmptyUtil.isEmpty(userLogin)) {
            throw new CheckException("用户名或密码错误！");
        }

        user = userLogin;
        user.setPassword(null);
        if (EmptyUtil.isNotEmpty(user.getRoleId())) {
            user.getRole();
        }
        String nowTime = String.valueOf(new Date().getTime());
        Integer rand = (int) (Math.random()*10000);
        String sessionMapId = nowTime+rand.toString();
        GlobalVariable.sessionMap.put(sessionMapId, user);
        //request.getSession().setAttribute("user", user);
        return sessionMapId;
    }

    /**
     * 获取所有用户信息
     * 
     * @author xuqq 2016年4月26日 上午10:07:43
     * 
     * @param request
     * @return
     * @throws CheckException
     */
    public List<User> getAllUsers() throws CheckException {
        List<User> users = usermapper.getAllUsers();
        for (int i = 0; i < users.size(); i++) {
            if (EmptyUtil.isNotEmpty(users.get(i).getRoleId())) {
                users.get(i).getRole();
            }
        }
        return users;
    }

    /**
     * 添加用户
     * 
     * @author xuqq 2016年4月26日 上午11:20:59
     * 
     * @param request
     * @param user
     * @throws CheckException
     */
    public void addUser(User user) throws CheckException {

        if (EmptyUtil.isEmpty(user.getUserName())) {
            throw new CheckException("请填写用户名！");
        }

        User u = new User();
        u.setUserName(user.getUserName());

        User resultUser = usermapper.findByColumns(user);
        if (EmptyUtil.isNotEmpty(resultUser)) {
            throw new CheckException("该用户名已经存在！");
        }

        if (EmptyUtil.isEmpty(user.getRoleId())) {
            throw new CheckException("请选择用户角色！");
        }

        Role role = roleMapper.findById(user.getRoleId());
        if (EmptyUtil.isEmpty(role)) {
            throw new CheckException("您选择的用户角色不存在！");
        }

        user.setPassword("123456");

        usermapper.addUser(user);
    }

    /**
     * 删除用户
     * 
     * @author xuqq 2016年4月26日 下午4:33:22
     * 
     * @param user
     * @throws CheckException
     */
    public void deleteUser(User user) throws CheckException {
        if (EmptyUtil.isEmpty(user.getUserId())) {
            throw new CheckException("请选择用户！");
        }
        usermapper.deleteUser(user.getUserId());
    }

    /**
     * 跳转到修改用户界面
     * 
     * @author xuqq 2016年4月26日 下午5:37:45
     * 
     * @param user
     * @param model
     */
    public void toModifyUser(User user, Model model) {
        try {
            if (EmptyUtil.isEmpty(user.getUserId())) {

                throw new CheckException("请选择用户！");
            }
            user = usermapper.findByColumns(user);
            if (EmptyUtil.isEmpty(user.getUserName())) {
                throw new CheckException("该用户不存在！");
            }
            List<Role> roles = roleService.getRoles();
            model.addAttribute("roles", roles);
            model.addAttribute("user", user);
        } catch (CheckException e) {
            model.addAttribute("msg", e.getMessage());
        } catch (Exception e) {
            model.addAttribute("msg", "查询失败，请重试！");
        }
    }

    /**
     * 修改用户
     * 
     * @author xuqq 2016年4月26日 下午5:39:42
     * 
     * @param user
     * @throws CheckException
     */
    public void modifyUser(User user) throws CheckException {
        if (EmptyUtil.isEmpty(user.getUserName())) {
            throw new CheckException("请填写用户名！");
        }
        if (EmptyUtil.isEmpty(user.getRoleId())) {
            throw new CheckException("请选择用户角色！");
        }
        if (EmptyUtil.isEmpty(user.getUserId())) {
            throw new CheckException("请选择用户！");
        }

        usermapper.updateUser(user);
    }

    public void modifyUser(HttpServletRequest request) throws CheckException {
        if(EmptyUtil.isEmpty(request.getParameter("sessionMapId"))){
            throw new CheckException("请先登录！");
        }
        User user = (User) GlobalVariable.sessionMap.get(request.getParameter("sessionMapId").toString());
        if (EmptyUtil.isEmpty(user)) {
            throw new CheckException("请先登录！");
        }
        String oldPwd = request.getParameter("oldPwd");
        String newPwd = request.getParameter("newPwd");
        
        if (EmptyUtil.isEmpty(oldPwd)) {
            throw new CheckException("请填写原始密码！");
        }
        if (EmptyUtil.isEmpty(newPwd)) {
            throw new CheckException("请填写新密码！");
        }

        User u = usermapper.findById(user.getUserId());

        if (EmptyUtil.isEmpty(u)) {
            throw new CheckException("该用户不存在！");
        }

        if (!u.getPassword().equals(oldPwd)) {
            throw new CheckException("原始密码不正确！");
        }

        usermapper.updatePassword(u.getUserId(), newPwd);
    }
}
