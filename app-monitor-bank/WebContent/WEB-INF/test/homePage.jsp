<%@page import="com.springmvc_mybatis.bean.User"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<script src="js/homePage.js"></script>
<link type="text/css" rel="stylesheet" href="css/homePage.css">
<%
	
	User user = (User)request.getSession().getAttribute("user");
	Integer firstMenu = 0;
%>
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
					<li><a href="show_available_rates.jsp">专线可用率</a></li>
				</ul>
				<%
					}
					if((user.getRole().getRolePermission() & 4) == 4){
						if(firstMenu == 0){
							firstMenu = 4;
						}
				%>
				<ul>
					<li><a href="show_request_page.jsp">专线请求数</a></li>
				</ul>
				<%
					}
					if((user.getRole().getRolePermission() & 8) == 8){
						if(firstMenu == 0){
							firstMenu = 8;
						}
				%>
				<ul>
					<li><a href="show_sla_page.jsp">专线sla</a></li>
				</ul>
				<%
					}
				%>
				<ul onmouseover="unfoldMenu()" onmouseout="shrinkMenu()">
					<li >更多</li>
					<li id="editInfo" style="display: none;"><a href="modifyUserInfo.jsp">修改资料</a></li>
					<%
						if((user.getRole().getRolePermission() & 16) == 16){
					%>
					<li id="userManage" style="display: none;"><a href="user/getAllUsers.action">用户管理</a></li>
					<%
						}
						if((user.getRole().getRolePermission() & 32) == 32){
					%>
					<li id="roleManage" style="display: none;"><a href="role/roleList.action">角色管理</a></li>
					<%
						}
						if((user.getRole().getRolePermission() & 64) == 64){
					%>
					<li id="systemManage" style="display: none;"><a href="config/configlist.action">系统配置</a></li>
					<%
						}
						if((user.getRole().getRolePermission() & 128) == 128){
					%>
					<li id="pageManage" style="display: none;"><a href="pageShowConfig/pageShowConfigList.action">页面配置</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="user_div">
			<span>当前用户：${sessionScope.user.userName}</span>
			<span>角色：${sessionScope.user.role.roleName}</span>
			<span><a href="javascript:void(0);" onclick="logout()" style="text-decoration: none;">退出系统</a></span>
		</div>
	</div>
	<%-- <iframe id="ifra" style="width: 100%;height: 900px;border: none;" scrolling="auto" 
		src="<%	
				if(firstMenu == 2){
					out.print("show_available_rates.jsp");
				}else if(firstMenu == 4){
					out.print("show_request_page.jsp");
				}else if(firstMenu == 8){
					out.print("show_sla_page.jsp");
				}
		%>"
	></iframe> --%>
