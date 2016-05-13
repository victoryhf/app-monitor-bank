<%@page import="java.util.List"%>
<%@page import="com.springmvc_mybatis.bean.Permission"%>
<%@page import="com.springmvc_mybatis.bean.Role"%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<link href="bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理页面</title>
</head>
<body>
<c:if test="${success == 1}">
    <a href="addPermission.jsp">添加权限</a>
	<c:if test="${!(empty permissions)}">
		<table class="table table-striped table-hover">
			<tr>
				<th>权限ID</th>
				<th>权限名</th>
				<th>权限值</th>
				<th>权限值</th>
				<th>权限路径</th>
				<th colspan="2">操作</th>
			</tr>
			<c:forEach items="${permissions}" var="permission" >
				<tr>
					<td>${permission.permissionId}</td>
					<td>${permission.permissionName}</td>
					<td>${permission.permissionValue}</td>
					<td>${permission.permissionUrl}</td>
					<td><a 
						href="permission/toModifyPermission.action?permissionId=${permission.permissionId }"><font
							color="blue">修改</font></a></td>
					<td><a href="javascript:void(0);" onclick="deletePermission(${permission.permissionId})">
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
<script type="text/javascript">
function deletePermission(permissionId){
	$.ajax({
		type:'post',//请求方式 
		url:"permission/deletePermission.action",//请求地址
		data:{
			permissionId : permissionId
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					location.href="permission/permissionList.action";
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