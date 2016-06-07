<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%   
  //页面每隔60秒自动刷新一遍        
   response.setHeader("refresh" , "60" );   
%>  
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>银行SLA监控系统</title>

</head>
<body>
<div>
<%@include file="/WEB-INF/test/homePage.jsp"%>
</div>
<!--创建一个div容器-->
<div class="no">
	欢迎来到后台管理系统！
</div>
</body>
</html>
<!-- ECharts单文件引入-->
