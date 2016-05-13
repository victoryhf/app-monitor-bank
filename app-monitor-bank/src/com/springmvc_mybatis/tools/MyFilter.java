package com.springmvc_mybatis.tools;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.service.PermissionService;

public class MyFilter implements Filter {

    private Logger logger = Logger.getLogger(this.getClass());

    private PermissionService permissionService;

    public PermissionService getPermissionService() {
        return permissionService;
    }

    public void setPermissionService(PermissionService permissionService) {
        this.permissionService = permissionService;
    }

    public void destroy() {

    }

    public void doFilter(ServletRequest servletRequest,
            ServletResponse servletResponse, FilterChain filterChain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        String url = request.getRequestURI();
        // 不用教研session
        List<String> noSessionUrl = new ArrayList<String>();
        noSessionUrl.add("/images/");
        noSessionUrl.add("/css/");
        noSessionUrl.add("/js/");
        noSessionUrl.add("/bootstrap-3.3.5-dist/");
        noSessionUrl.add("/build/");
        noSessionUrl.add("/jquery-1.9.1/");
        noSessionUrl.add("/login.jsp");
        noSessionUrl.add("/user/login.action");
        noSessionUrl.add("/user/logout.action");
        noSessionUrl.add("/banksla/getAllratio.action");
        noSessionUrl.add("/banksla/getBankRequestPage.action");
        noSessionUrl.add("/banksla/getBankslaPage.action");
        for (int i = 0; i < noSessionUrl.size(); i++) {
            if (url.contains(noSessionUrl.get(i))) {
                filterChain.doFilter(request, response);
                return;
            }
        }
        // 校验session
        if (EmptyUtil.isEmpty(request.getSession().getAttribute("user"))) {

            if (request.getHeader("x-requested-with") != null && "XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
                // 向http头添加 状态 sessionstatus
                response.setHeader("sessionstatus", "timeout");
                response.setStatus(403);
                logger.warn("ajax没有登录请求" + url + ",协议是" + request.getScheme());
                filterChain.doFilter(request, response);
                return;
            } else {
                logger.warn("没有登录请求" + url + ",协议是" + request.getScheme());
                response.sendRedirect("https://sars.99bill.net/sor/app-monitor-bank/login.jsp");
                return;
            }

        }
        System.out.println(request.getScheme()+"     "+request.getSession().getId());
        // 校验权限
        User user = (User) request.getSession().getAttribute("user");
        if (!permissionService.checkPermission(url, user.getRole().getRolePermission())) {
            if (request.getHeader("x-requested-with") != null && "XMLHttpRequest".equalsIgnoreCase(request.getHeader("x-requested-with"))) {
                // 向http头添加 状态 sessionstatus
                logger.warn("ajax没有权限请求" + url + ",协议是" + request.getScheme());
                response.setHeader("sessionstatus", "timeout");
                response.setStatus(403);
                filterChain.doFilter(request, response);
                return;
            } else {
                logger.warn("没有权限请求" + url + ",协议是" + request.getScheme());
                response.sendRedirect("https://sars.99bill.net/sor/app-monitor-bank/login.jsp");
                return;
            }
        }
        filterChain.doFilter(request, response);

    }

    public void init(FilterConfig config) throws ServletException {
        ServletContext context = config.getServletContext();
        ApplicationContext ctx = WebApplicationContextUtils
                .getWebApplicationContext(context);
        permissionService = (PermissionService) ctx
                .getBean("permissionService");
    }

}
