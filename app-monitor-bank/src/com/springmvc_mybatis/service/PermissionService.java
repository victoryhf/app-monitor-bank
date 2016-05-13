package com.springmvc_mybatis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springmvc_mybatis.bean.Permission;
import com.springmvc_mybatis.mapper.PermissionMapper;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.EmptyUtil;

@Service("permissionService")
public class PermissionService {

    @Autowired
    private PermissionMapper permissionMapper;

    /**
     * 检测用户有没该路径的权限
     * 
     * @author xuqq 2016年4月28日 下午3:13:53
     * 
     * @param url
     * @param rolePermission
     * @return
     */
    public boolean checkPermission(String url, Integer rolePermission) {

        List<Permission> permissions = permissionMapper.findAll();

        Permission perm = null;

        for (Permission permission : permissions) {
            if (url.contains(permission.getPermissionUrl())) {
                perm = permission;
            }
        }
        if (EmptyUtil.isEmpty(perm)) {
            return true;
        } else {
            if ((rolePermission & perm.getPermissionValue()) == perm
                    .getPermissionValue()) {
                return true;
            }
        }
        return false;
    }

    public List<Permission> getPermissions() {
        return permissionMapper.findAll();
    }

    public void addPermission(Permission permission) throws CheckException {
        if (EmptyUtil.isEmpty(permission.getPermissionName())) {
            throw new CheckException("请填写权限名！");
        }
        if (EmptyUtil.isEmpty(permission.getPermissionValue())) {
            throw new CheckException("请填写权限值！");
        }
        if (EmptyUtil.isEmpty(permission.getPermissionUrl())) {
            throw new CheckException("请填写权限路径！");
        }

        permissionMapper.addPermission(permission);
    }

    public void toModifyPermission(Permission permission, Model model)
            throws CheckException {
        if (EmptyUtil.isEmpty(permission.getPermissionId())) {
            throw new CheckException("请选择要修改的权限！");
        }

        permission = permissionMapper.findById(permission.getPermissionId());
        model.addAttribute("permission", permission);
    }

    public void modifyPermission(Permission permission) throws CheckException {
        if (EmptyUtil.isEmpty(permission.getPermissionName())) {
            throw new CheckException("请填写权限名！");
        }
        if (EmptyUtil.isEmpty(permission.getPermissionValue())) {
            throw new CheckException("请填写权限值！");
        }
        if (EmptyUtil.isEmpty(permission.getPermissionUrl())) {
            throw new CheckException("请填写权限路径！");
        }
        if (EmptyUtil.isEmpty(permission.getPermissionId())) {
            throw new CheckException("请选择要修改的权限！");
        }
        permissionMapper.updatePermission(permission);
    }

    public void deletePermission(Permission permission) throws CheckException {
        if (EmptyUtil.isEmpty(permission.getPermissionId())) {
            throw new CheckException("请选择要删除的角色");
        }

        permissionMapper.deletePermission(permission.getPermissionId());
    }

}
