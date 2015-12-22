<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">

.do{background: #F0F0F0;}

</style>
</head>
<%   
  //页面每隔60秒自动刷新一遍        
   response.setHeader("refresh" , "60" );   
%>   

<body>

<iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://192.168.165.71:8080/app-monitor-bank/ratio.jsp"></iframe>
<iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://192.168.165.71:8080/app-monitor-bank/sla.jsp"></iframe>
<iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://192.168.165.71:8080/app-monitor-bank/rrbar.jsp"></iframe>
</body>
</html>