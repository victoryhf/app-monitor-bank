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
<title>页面显示配置信息</title>
</head>
<body>
<c:if test="${success == 1}">
    <a href="../addPageShowConfig.jsp">增加页面显示配置</a>
	<c:if test="${!(empty pageShowConfigList)}">
		<table border="1" cellpadding="10" cellspacing="0">
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
						href="../modifyPageShowConfig.jsp?pageConfigId=${config.pageConfigId}"><font
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
<script src="../jquery-1.9.1/jquery.min.js"></script>
<script type="text/javascript">
function deleteageShowConfig(pageConfigId){
	$.ajax({
		type:'post',//请求方式 
		url:"deletePageShowConfig.action",//请求地址
		data:{
			pageConfigId : pageConfigId
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					location.href="pageShowConfigList.action";
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