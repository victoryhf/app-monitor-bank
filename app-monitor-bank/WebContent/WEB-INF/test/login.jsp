<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<title>快钱运维监控系统</title>

<link type="text/css" rel="stylesheet" href="css/login.css">
</head>
<body>
	<div class="head_div">
		<div class="head_image">
			<img class="logo_img" src="images/logo.gif"/>
			<img class="logo_text_img" src="images/logo_text.gif"/>
			<span>银行sla监控系统</span>
		</div>
		<div class="bottom_img"></div>
	</div>
	<div class="main">
		<div class="main_title">建议使用IE8, Firefox4.0, Chrome15.0及以上版本。</div>
		<div class="login_img">
			<div class="login_div">
			<form action="user/login.action" method="post">
				用&nbsp;&nbsp;户：<input type="text" name="userName"><br/>
				密&nbsp;&nbsp;码：<input type="password" name="password"><br/>
				<%
				request.setCharacterEncoding("UTF8");
					if(request.getParameter("msg") != null){
				%>
				<span class="tips"><%= request.getParameter("msg")%></span><br/>
				<%
					}
				%>
				<input type="submit" class="login_button" value="登录" name="Submit">
				<input type="reset" class="login_button" value="取消" name="Submit2">
			</form>
				
			</div>			
		</div>
	</div>
	<div class="footer">
		快钱版权所有2004-2011
	</div>
</body>
</html>