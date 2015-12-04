<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 <head>
  <title>增加配置信息</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
  <!--
 <link rel="stylesheet" type="text/css" href="styles.css">
 -->
 </head>
 <body>
  <form action="UserRegister" name="form" mothod="post"
   onsubmit="return checkForm(this)">
   <table width="60%" border="1">
    <tr align="left">
     <td>
                   银行专线号：
      <input type="text" name="bankid">
     </td>
    </tr>
    <tr align="left">
     <td>
                 专线名称：
      <input type="text" name="bankname">
     </td>
    </tr>
    <tr align="left">
     <td>
                 响应SLA阀值：
      <input type="text" name="sla_threshold">
     </td>
    </tr>
    <tr align="left">
     <td>
                 专线可用率阀值：
      <input type="text" name="available_ratio_threshold">
     </td>
    </tr>
    <tr align="left">
     <td>
               最大超时时间:
      <input type="text" name="max_beyond_time">
     </td>
    </tr>
    <tr align="left">
     <td>
              是否读取状态:
      <input type="text" name="rstatus">
     </td>
    </tr>
    <tr align="left">
     <td>
             告警信息订阅人：
      <input type="text" name="mail_to">
     </td>
    </tr>
    
    <tr align="center">
     <td>
      <input type="submit" value="注册" onclick="false">
     </td>
    </tr>
   </table>
  </form>
  

 </body>
</html>
 