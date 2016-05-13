<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<link href="bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>页面显示配置信息</title>
</head>
<body>
<div>
<%@include file="/WEB-INF/test/homePage.jsp"%>
</div>
<c:if test="${success == 1}">
    <a href="addPageShowConfig.jsp">增加页面显示配置</a>
	<c:if test="${!(empty pageShowConfigList)}">
		<table class="table table-striped table-hover">
			<tr>
				<th>配置的页面名称</th>
				<th>每页显示图型的数量</th>
				<th>每个图型显示数据条数</th>
				<th colspan="2">操作</th>
			</tr>
			<c:forEach items="${pageShowConfigList }" var="config" >
				<tr>
					<td>${config.pageName}</td>
					<td>${config.perPageNumber}</td>
					<td>${config.perChartNumber}</td>
					<td><a 
						href="modifyPageShowConfig.jsp?pageConfigId=${config.pageConfigId}"><font
							color="blue">修改</font></a></td>
					<td><a href="javascript:void(0);" onclick="deleteageShowConfig(${config.pageConfigId})">
					<font
							color="blue">删除</font></a></td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
</c:if>
<input type="hidden" id="msg" value="${msg}">
</body>
</html>
<script src="jquery-1.9.1/jquery.min.js"></script>
<!--引入 Bootstrap核心 文件 -->
<script src="bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<!--引入bootstrap.min.css文档的外部样式表-->
<link href="bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<!--引入bootstrap-responsive.min.css文档的外部样式表 -->
<link href="bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
<!--引入bootstrap-3.3.5-dist/css/docs.css文档的外部样式表-->
<link href="bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">
<script type="text/javascript">
function deleteageShowConfig(pageConfigId){
	$.ajax({
		type:'post',//请求方式 
		url:"pageShowConfig/deletePageShowConfig.action",//请求地址
		data:{
			pageConfigId : pageConfigId
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					location.href="pageShowConfig/pageShowConfigList.action";
				}else{
					alert(result.msg);
				}
			}
		},
		error:function(errorMsg){//请求失败后回调函数
			alert("数据加载出错");
		},
	});
	
}
</script>