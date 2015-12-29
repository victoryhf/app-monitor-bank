<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>银行SLA监控系统</title>
<style type="text/css">
.title_left{
	height:25px;
	font:16px Arial,Verdana,"微软雅黑";
	color:#0060a6;
	background-color:inherit;
	text-decoration:none;
	text-align:right;
	padding:0;
}
.title_left span{
	height:25px;
	font:16px Arial,Verdana,"微软雅黑";
	color:#0060a6;
	background-color:inherit;
	text-decoration:none;
	text-align:center;
	text-transform:uppercase;
	float:left;
	padding-top:4px;
}

#topMain{
	width:100%;
	height:60px;
}
#topContainer{
	width:auto;
	min-width:1240px;
	padding:0px 0 0px 0;
	margin:0 auto;
}

#top{
	width:98%;
	margin:0 auto;
	padding:0 auto;
	height:100px;
}
#top img.logo{
	display:block;
	width:104px;
	height:58px;
	margin:0px 10px 0 0;
	float:left;
}
.systitle{
	width:280px;
	height:43px;
	float:left;
	margin:10px 0 0 0px;
	padding:10px 0 0 0;
	font-size:26px;
	text-align:left;
	line-height:25px;
	color:#3F3F3F;
	background-color:inherit;
	background:url(/app-monitor-bank/images/systitle.png) left top no-repeat;
}

#bodyTopMain{
	width:auto;
	min-width:1260px;
	height:3px;
	background:url(/app-monitor-bank/images/body_top_bg.gif) 0 0 repeat-x #39A09B;
	color:#C5F6F2;
	padding:auto;
	z-index: 100;
}

.do{background: #F0F0F0;}
</style>
</head>
<%   
  //页面每隔60秒自动刷新一遍        
   response.setHeader("refresh" , "60" );   
%>   

<body>
<div id="topMain">
   <div id ="topContainer">
       <div id ="top">
            <img src="/app-monitor-bank/images/logo.gif" alt="foot step" width="79" height="44" class="logo">
            <div class="systitle"></div>
       </div>
    </div>
</div>
<div id="bodyTopMain"></div>

<div style="margin:8px 0px 0px 0px;">
<iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://localhost:8080/app-monitor-bank/ratio.jsp"></iframe>
<iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://localhost:8080/app-monitor-bank/sla.jsp"></iframe>
<iframe name="banksla" width="440" height="210" frameborder="0" scrolling="no" class="do" marginheight="0" marginwidth="0" src="http://localhost:8080/app-monitor-bank/rrbar.jsp"></iframe>
</div>
</body>
</html>