package com.springmvc_mybatis.tools;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.service.PermissionService;

public class MyFilter implements Filter {
	
	private PermissionService permissionService;
	
	public PermissionService getPermissionService() {
		return permissionService;
	}

	public void setPermissionService(PermissionService permissionService) {
		this.permissionService = permissionService;
	}

	public void destroy() {

	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		String url = request.getRequestURI();
		if(url.endsWith(".jsp")){
			if(!url.contains("login.jsp")){
				if(EmptyUtil.isEmpty(request.getSession().getAttribute("user"))){
	            	response.sendRedirect("login.jsp");
	            }else {
					User user = (User) request.getSession().getAttribute("user");
					if(!permissionService.checkPermission(url, user.getRole().getRolePermission())){
						response.sendRedirect("login.jsp");
					}else {
						request.getSession().setAttribute("user", request.getSession().getAttribute("user"));
					}
					
				}
			}
		}else if(url.endsWith(".action")){
			if(!url.contains("user/login.action")){
	        	if(EmptyUtil.isEmpty(request.getSession().getAttribute("user"))){
	            	response.sendRedirect("../login.jsp");
	            }else {
					User user = (User) request.getSession().getAttribute("user");
					if(!permissionService.checkPermission(url, user.getRole().getRolePermission())){
						response.sendRedirect("../login.jsp");
					}else {
						request.getSession().setAttribute("user", request.getSession().getAttribute("user"));
					}
				}
	        }
			
		}
		filterChain.doFilter(request, response);
	}

	public void init(FilterConfig config) throws ServletException {
		ServletContext context = config.getServletContext();  
        ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(context);  
        permissionService = (PermissionService) ctx.getBean("permissionService");  
	}

}
