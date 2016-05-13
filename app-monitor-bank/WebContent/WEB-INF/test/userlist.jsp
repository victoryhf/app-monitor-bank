<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<link href="bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户管理页面</title>
</head>
<body>
<script type="text/javascript">
function deleteUser(userId){
	$.ajax({
		type:'post',//请求方式 
		url:"user/deleteUser.action",//请求地址
		data:{
			userId : userId
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					location.href="user/getAllUsers.action";
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
<div>
<%@include file="/WEB-INF/test/homePage.jsp"%>
</div>
<c:if test="${success == 1}">
    <a href="user/toAddUser.action">添加用户</a>
	<c:if test="${!(empty users)}">
		<table class="table table-striped table-hover">
			<tr>
				<th>用户ID</th>
				<th>用户名</th>
				<th>角色名</th>
				<th colspan="2">操作</th>
			</tr>
			<c:forEach items="${users}" var="user" >
				<tr>
					<td>${user.userId}</td>
					<td>${user.userName}</td>
					<td>${user.role.roleName}</td>
					<td><a 
						href="user/toModifyUser.action?userId=${user.userId }"><font
							color="blue">修改</font></a></td>
					<td><a href="javascript:void(0);" onclick="deleteUser(${user.userId})">
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
