<%@page import="com.springmvc_mybatis.bean.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>快钱运维监控系统</title>

<script src="js/homePage.js"></script>
<link type="text/css" rel="stylesheet" href="css/homePage.css">
</head>
<%
	User user = (User)request.getSession().getAttribute("user");
	Integer firstMenu = 0;
%>
<body>
	<div class="head_div">
		<div class="logo_div"></div>
		<div class="title_div"></div>
		<div class="menus_div">
			<div class="menu_div">
				<%
					if((user.getRole().getRolePermission() & 2) == 2){
						firstMenu = 2;
				%>
				<ul>
					<li onclick="changePage('show_available_rates.jsp')" >专线可用率</li>
				</ul>
				<%
					}
					if((user.getRole().getRolePermission() & 4) == 4){
						if(firstMenu == 0){
							firstMenu = 4;
						}
				%>
				<ul>
					<li onclick="changePage('show_request_page.jsp')">专线请求数</li>
				</ul>
				<%
					}
					if((user.getRole().getRolePermission() & 8) == 8){
						if(firstMenu == 0){
							firstMenu = 8;
						}
				%>
				<ul>
					<li onclick="changePage('show_sla_page.jsp')">专线sla</li>
				</ul>
				<%
					}
				%>
				<ul onmouseover="unfoldMenu()" onmouseout="shrinkMenu()">
					<li >更多</li>
					<li id="editInfo" style="display: none;" onclick="changePage('modifyUserInfo.jsp')">修改资料</li>
					<%
						if((user.getRole().getRolePermission() & 16) == 16){
					%>
					<li id="userManage" onclick="changePage('user/getAllUsers.action')" style="display: none;">用户管理</li>
					<%
						}
						if((user.getRole().getRolePermission() & 32) == 32){
					%>
					<li id="roleManage" style="display: none;" onclick="changePage('role/roleList.action')">角色管理</li>
					<%
						}
						if((user.getRole().getRolePermission() & 64) == 64){
					%>
					<li id="systemManage" style="display: none;" onclick="changePage('config/configlist.action')">系统配置</li>
					<%
						}
						if((user.getRole().getRolePermission() & 128) == 128){
					%>
					<li id="pageManage" style="display: none;" onclick="changePage('pageShowConfig/pageShowConfigList.action')">页面配置</li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="user_div">
			<span>当前用户：${sessionScope.user.userName}</span>
			<span>角色：${sessionScope.user.role.roleName}</span>
		</div>
	</div>
	<iframe id="ifra" style="width: 100%;height: 900px;border: none;" scrolling="auto" 
		src="<%	
				if(firstMenu == 2){
					out.print("show_available_rates.jsp");
				}else if(firstMenu == 4){
					out.print("show_request_page.jsp");
				}else if(firstMenu == 8){
					out.print("show_sla_page.jsp");
				}
		%>"
	></iframe>
</body>
</html>