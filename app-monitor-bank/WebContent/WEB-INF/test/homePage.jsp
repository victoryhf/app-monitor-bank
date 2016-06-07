<%@page import="com.springmvc_mybatis.bean.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<script src="js/homePage.js"></script>
<link type="text/css" rel="stylesheet" href="css/homePage.css">
<input type="hidden" id="sessionMapId" value="${sessionMapId}">
<input type="hidden" id="url" value="<%=request.getRequestURI()%>">
	<div class="head_div">
		<div class="logo_div"></div>
		<div class="title_div"></div>
		<div class="menus_div">
			<div class="menu_div" id="menu">
				<ul>
					<li><a href="show_available_rates.jsp">专线可用率</a></li>
				</ul>
				<ul>
					<li><a href="show_request_page.jsp">专线请求数</a></li>
				</ul>
				<ul>
					<li><a href="show_sla_page.jsp">专线sla</a></li>
				</ul>
			</div>
		</div>
		<div class="user_div" id="userInfoDiv">
			<span id="currentUser">当前用户：</span>
			<span id="currentRoleName">角色：</span>
			<span><a href="javascript:void(0);" onclick="logout()" style="text-decoration: none;">退出系统</a></span>
		</div>
	</div>
