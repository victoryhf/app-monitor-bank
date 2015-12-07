<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配置信息</title>
</head>
<body>
   
	<input type="button" value="增加配置" onclick="location.href='${basePath}addconfig.jsp'" />
	<c:if test="${!(empty requestScope.configs)}">
		<table border="1" cellpadding="10" cellspacing="0">
			<tr>
				<th>id</th>
				<th>银行专线号</th>
				<th>专线名称</th>
				<th>响应SLA阀值</th>
				<th>专线可用率阀值</th>
				<th>最大超时时间</th>
				<th>是否读取状态</th>
				<th>告警信息订阅人</th>
				<th colspan="2">操作</th>
			</tr>
			<c:forEach items="${requestScope.configs }" var="config" >
				<tr>
					<td>${config.id}</td>
					<td>${config.bankid}</td>
					<td>${config.bankname}</td>
					<td>${config.sla_threshold}</td>
					<td>${config.available_ratio_threshold}</td>
					<td>${config.max_beyond_time}</td>
					<td>${config.rstatus}</td>
					<td>${config.mail_to}</td>
					<td><a onclick="return false"
						href="${pageContext.request.contextPath}/config/modify.action?id=${config.bankid}"><font
							color="blue">修改</font></a></td>
					<td><a onclick="return false"
						href="${pageContext.request.contextPath}/config/delete/${config.bankid}.action"><font
							color="blue">删除</font></a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
</body>
</html>