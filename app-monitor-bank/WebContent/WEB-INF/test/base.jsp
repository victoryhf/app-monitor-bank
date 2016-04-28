<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<base href="<%=basePath%>">

<script src="jquery-1.9.1/jquery.min.js"></script>
<!--引入 Bootstrap核心 文件 -->
<script src="bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<!--引入bootstrap.min.css文档的外部样式表-->
<link href="bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<!--引入bootstrap-responsive.min.css文档的外部样式表 -->
<link href="bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
<!--引入bootstrap-3.3.5-dist/css/docs.css文档的外部样式表-->
<link href="bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">
