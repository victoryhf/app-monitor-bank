<%@page import="java.util.List"%>
<%@page import="com.springmvc_mybatis.bean.Permission"%>
<%@page import="com.springmvc_mybatis.bean.Role"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>角色管理页面</title>
</head>
<body>
<c:if test="${success == 1}">
    <a href="role/toAddRole.action">添加角色</a>
	<c:if test="${!(empty roles)}">
		<table class="table table-striped">
			<tr>
				<th>角色ID</th>
				<th>角色名</th>
				<th>权限值</th>
				<th colspan="2">操作</th>
			</tr>
			<c:forEach items="${roles}" var="role" >
				<tr>
					<td>${role.roleId}</td>
					<td>${role.roleName}</td>
					<td>${role.rolePermission}</td>
					<td><a 
						href="role/toModifyRole.action?roleId=${role.roleId }"><font
							color="blue">修改</font></a></td>
					<td><a href="javascript:void(0);" onclick="deleteRole(${role.roleId})">
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
function deleteRole(roleId){
	$.ajax({
		type:'post',//请求方式 
		url:"role/deleteRole.action",//请求地址
		data:{
			roleId : roleId
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					location.href="role/roleList.action";
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