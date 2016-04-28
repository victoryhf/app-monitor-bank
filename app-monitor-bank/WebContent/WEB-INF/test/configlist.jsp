<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/sor"+path+"/";
pageContext.setAttribute("basePath", basePath);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>配置信息</title>
</head>
<body>
    <a href="../addconfig.jsp">增加配置</a>
	<c:if test="${!(empty requestScope.configs)}">
		<table class="table table-striped">
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
					<td><a 
						href="./queryConfigByid.action?id=${config.id}"><font
							color="blue">修改</font></a></td>
					<td><a
						href="./deleteConfigByid.action?id=${config.id}"><font
							color="blue">删除</font></a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	
</body>
</html>
<!--引入 Bootstrap核心 文件 -->
<script src="../bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<!--引入bootstrap.min.css文档的外部样式表-->
<link href="../bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<!--引入bootstrap-responsive.min.css文档的外部样式表 -->
<link href="../bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
<!--引入bootstrap-3.3.5-dist/css/docs.css文档的外部样式表-->
<link href="../bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">