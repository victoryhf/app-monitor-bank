<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

  <head>
   <link href="<%=path%>/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="<%=path%>/bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
   <link href="<%=path%>/bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">
   <script src="<%=path%>/jquery-1.9.1/jquery.min.js"></script>
   <script src="<%=path%>/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
  </head>


<body>
<div class="container-fluid">
    <div class="row-fluid">
      <div class="span4"  >
        <iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" id="rowLeft"src="http://localhost:8080/app-monitor-bank/ratio.jsp"></iframe>
      </div>
    
      <div class="span4"  >
        <iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" id="rowMiddle"src="http://localhost:8080/app-monitor-bank/sla.jsp"></iframe>
      </div>
    
      <div class="span4" >
        <iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://localhost:8080/app-monitor-bank/rrbar.jsp"></iframe>
      </div>
    
  </div>
</div>

</body>
</html>

