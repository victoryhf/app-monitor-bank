package com.springmvc_mybatis.tools;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SystemInterceptor extends  HandlerInterceptorAdapter{
	
	//不用session的路径
	private List<String> noSessionUrlList;
	
	public List<String> getNoSessionUrlList() {
		return noSessionUrlList;
	}

	public void setNoSessionUrlList(List<String> noSessionUrlList) {
		this.noSessionUrlList = noSessionUrlList;
	}

	@Override
	public boolean preHandle(HttpServletRequest request,HttpServletResponse response, Object handler) throws Exception {
		request.setCharacterEncoding("UTF-8");  
        response.setCharacterEncoding("UTF-8");  
        response.setContentType("text/html;charset=UTF-8"); 
        String url = request.getRequestURI();
        System.out.println(url);
        if(!url.contains("user/login.action")){
        	if(EmptyUtil.isEmpty(request.getSession().getAttribute("user"))){
            	response.sendRedirect("../login.jsp");
            }
        }
		return super.preHandle(request, response, handler);
	}

	
}
