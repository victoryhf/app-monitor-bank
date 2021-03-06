<%@page import="com.springmvc_mybatis.bean.AutoLoadCfg"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
WebApplicationContext wac = (WebApplicationContext) RequestContextUtils
.getWebApplicationContext(pageContext.getRequest(),
		pageContext.getServletContext());
AutoLoadCfg acfg = (AutoLoadCfg) wac.getBean("cfg");

%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%=acfg.getValue("00010001") %>
	<c:if test="${empty requestScope.users }">
		<font color="red">没有员工信息！</font>
	</c:if>
	<c:if test="${!(empty requestScope.users)}">
		<table border="1" cellpadding="10" cellspacing="0">
			<tr>
				<th>Num</th>
				<th>Id</th>
				<th>Name</th>
				<th>Password</th>
				<th>Create_Time</th>
				<th colspan="2">OP</th>
			</tr>
			<c:forEach items="${requestScope.users }" var="user" varStatus="s">
				<tr>
					<td>${s.count}</td>
					<td>${user.id}</td>
					<td>${user.name }</td>
					<td>${user.password}</td>
					<td><fmt:formatDate value="${user.time}" pattern="yyyy-MM-dd" />
					</td>
					<td><a onclick="return false"
						href="${pageContext.request.contextPath}/user/save.action?id=${user.id}"><font
							color="blue">edit</font></a></td>
					<td><a onclick="return false"
						href="${pageContext.request.contextPath}/user/delete/${user.id}.action"><font
							color="blue">delete</font></a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
	<br>
	<a href="${pageContext.request.contextPath}">goto login</a>
</body>
</html>