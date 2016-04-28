package com.springmvc_mybatis.tools;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MyFilter implements Filter {

	public void destroy() {
		// TODO Auto-generated method stub

	}

	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse,FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) servletRequest;
		HttpServletResponse response = (HttpServletResponse) servletResponse;
		String url = request.getRequestURI();
		if(url.endsWith(".jsp")){
			if(!url.contains("login.jsp")){
				if(EmptyUtil.isEmpty(request.getSession().getAttribute("user"))){
	            	response.sendRedirect("login.jsp");
	            }
			}
		}else if(url.endsWith(".action")){
			if(!url.contains("user/login.action")){
	        	if(EmptyUtil.isEmpty(request.getSession().getAttribute("user"))){
	            	response.sendRedirect("../login.jsp");
	            }
	        }
			
		}
		filterChain.doFilter(request, response);
	}

	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub

	}

}
