<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<h3><font color="red">增加失败，请重新添加</font>，3秒后为您自动跳转到新增页面</h3>
    <% 
        response.setHeader("refresh","3;URL=addconfig.jsp");
    %>
    <h3>如果没有跳转，请点击<a href="addconfig.jsp">新增配置</a>!</h3>
</body>
</html>