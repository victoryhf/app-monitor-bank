package com.springmvc_mybatis.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springmvc_mybatis.bean.Permission;
import com.springmvc_mybatis.bean.Role;
import com.springmvc_mybatis.mapper.PermissionMapper;
import com.springmvc_mybatis.mapper.RoleMapper;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.EmptyUtil;

@Service("roleService")
public class RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    /**
     * 获取所有角色
     * 
     * @author xuqq 2016年4月26日 上午10:51:48
     * 
     * @param user
     * @return
     */
    public List<Role> getRoles() {
        return roleMapper.findAll();
    }

    public void toAddRole(Model model) {
        List<Permission> permissions = permissionMapper.findAll();
        model.addAttribute("permissions", permissions);
    }

    /**
     * 添加角色
     * 
     * @author xuqq 2016年4月27日 下午1:48:08
     * 
     * @param role
     * @throws CheckException
     */
    public void addRole(Role role) throws CheckException {
        if (EmptyUtil.isEmpty(role.getRoleName())) {
            throw new CheckException("请填写角色名！");
        }

        if (EmptyUtil.isEmpty(role.getRolePermission())) {
            role.setRolePermission(0);
        }

        Role r = new Role();
        r.setRoleName(role.getRoleName());
        List<Role> roles = roleMapper.findListBycolumns(r);
        if (EmptyUtil.isNotEmpty(roles)) {
            throw new CheckException("该角色名已经存在！");
        }

        roleMapper.addRole(role);
    }

    public void toModifyRole(Role role, Model model) throws CheckException {
        if (EmptyUtil.isEmpty(role.getRoleId())) {
            throw new CheckException("请选择要修改的角色！");
        }
        role = roleMapper.findById(role.getRoleId());
        List<Permission> permissions = permissionMapper.findAll();
        List<Integer> checked = new ArrayList<Integer>();
        for (int i = 0; i < permissions.size(); i++) {
            if (role.getRolePermission() >= permissions.get(i)
                    .getPermissionValue()) {
                if ((role.getRolePermission() & permissions.get(i)
                        .getPermissionValue()) != 0) {
                    checked.add(permissions.get(i).getPermissionValue());
                }
            }
        }

        model.addAttribute("role", role);
        model.addAttribute("permissions", permissions);
        model.addAttribute("checked", checked);
    }

    public void modifyRole(Role role) throws CheckException {
        if (EmptyUtil.isEmpty(role.getRoleName())) {
            throw new CheckException("请填写角色名！");
        }

        if (EmptyUtil.isEmpty(role.getRolePermission())) {
            role.setRolePermission(0);
        }

        roleMapper.updateRole(role);
    }

    public void deleteRole(Role role) throws CheckException {
        if (EmptyUtil.isEmpty(role.getRoleId())) {
            throw new CheckException("请选择要删除的角色");
        }

        roleMapper.deleteRole(role.getRoleId());
    }

}
