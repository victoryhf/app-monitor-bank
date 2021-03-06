<%@ page language="java" import="java.util.*" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<html>
 <head>
  <%@include file="/WEB-INF/test/base.jsp"%>
  <title>修改配置信息</title>
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
 <div>
<%@include file="/WEB-INF/test/homePage.jsp"%>
</div>
  <form action="config/updateConfigByid.action" name="form" method="post">
  <input type="hidden" id="id" name="id" value=${config.id} />
  <c:if test="${!(empty requestScope.config)}">
   <table width="60%" border="1">
    <tr align="left">
     <td>
                   银行专线号：
      <input type="text" name="bankid" value="${config.bankid}" />
     </td>
    </tr>
    <tr align="left">
     <td>
                 专线名称：
      <input type="text" name="bankname" value="${config.bankname}" />
     </td>
    </tr>
    <tr align="left">
     <td>
                 响应SLA阀值：
      <input type="text" name="sla_threshold" value="${config.sla_threshold}" />
     </td>
    </tr>
    <tr align="left">
     <td>
                 专线可用率阀值：
      <input type="text" name="available_ratio_threshold" value="${config.available_ratio_threshold}" />
     </td>
    </tr>
    <tr align="left">
     <td>
               最大超时时间:
      <input type="text" name="max_beyond_time" value="${config.max_beyond_time}" />
     </td>
    </tr>
    <tr align="left">
     <td>
              是否读取状态:
      <input type="text" name="rstatus" value="${config.rstatus}" />
     </td>
    </tr>
    <tr align="left">
     <td>
             告警信息订阅人：
      <input type="text" name="mail_to" value="${config.mail_to}" />
     </td>
    </tr>
    <tr align="left">
     <td>
             是否发送告警邮件：
      <input type="text" name="isSendAlarmMail" value="${config.isSendAlarmMail}" />
     </td>
    </tr>
    <tr align="left">
     <td>
             一段时间内最高低于阀值次数：
      <input type="text" name="number" value="${config.number}" />
     </td>
    </tr>
    <tr align="left">
     <td>
             请求数的阀值：
      <input type="text" name="request" value="${config.request}" />
     </td>
    </tr>
    <tr align="left">
     <td>
             重要程度：
      <input type="text" name="importantLevel" value="${config.importantLevel}" />
     </td>
    </tr>
    <tr align="left">
     <td style="line-height: 100px;height: 100px;">
             解决方案：
      <textarea name="solution" style="height: 150px;width: 500px;">${config.solution}</textarea>
     </td>
    </tr>
    
    <tr >
     <td>
      <input type="submit" value="修改" />
      <input type="reset" value="重置"/>
     </td>
    </tr>
   </table>
   </c:if>
  </form>
  
 </body>
</html>
 