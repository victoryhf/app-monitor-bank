<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
int pageConfigId = Integer.parseInt(request.getParameter("pageConfigId"));
%>
<!DOCTYPE HTML>
<html>
 <head>
  <title>增加页面显示配置信息</title>
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
   <table width="60%" border="1">
    <tr align="left">
    <input type="hidden" id="pageConfigId" value="<%=pageConfigId %>" />
     <td>
                   网页名称             
      <input type="text" id="pageName" />
     </td>
    </tr>
    <tr align="left">
     <td>
                   每页显示图型的数量           
      <input type="text" id="perPageNumber" />
     </td>
    </tr>
    <tr align="left">
     <td>
                 每个图型显示数据条数
      <input type="text" id="perChartNumber"/>
     </td>
    </tr>
    <tr >
     <td>
      <input type="button" id="submit"  value="保存" onclick="save()"/>
      <input type="reset" value="重置"/>
     </td>
    </tr>
   </table>
  
 </body>
</html>
<script src="./jquery-1.9.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		getPageShowConfig();
	});
	function getPageShowConfig(){
		if($("#pageConfigId").val() == ""){
			alert("缺少ID");
			return false;
		}
		
		$.ajax({
			type:'post',//请求方式 
			url:"pageShowConfig/findPageShowConfigById.action",//请求地址
			data:{
				pageConfigId : $("#pageConfigId").val()
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					if(result.success == 1 && result.obj != null){
						$("#pageName").val(result.obj.pageName);
						$("#perPageNumber").val(result.obj.perPageNumber);
						$("#perChartNumber").val(result.obj.perChartNumber);
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
	function save(){
		$("#submit").attr('disabled',true); 
		var pageName = $("#pageName").val();
		var perPageNumber = $("#perPageNumber").val();
		var perChartNumber = $("#perChartNumber").val();
		var reg = /^[0-9]*$/;
		if($("#pageName").val() == ""){
			alert("请填写 网页名称！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		if(perPageNumber == ""){
			alert("每页显示图型的数量  ！");
			$("#submit").attr('disabled',false); 
			return false;
		}else if(!reg.test(perPageNumber)){
			alert("每页显示图型的数量请填写数字!");
			$("#submit").attr('disabled',false); 
			return false;
		}
		if(perChartNumber == ""){
			alert("每个图型显示数据条数  ！");
			$("#submit").attr('disabled',false); 
			return false;
		}else if(!reg.test(perChartNumber)){
			alert("每个图型显示数据条数请填写数字!");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		$.ajax({
			type:'post',//请求方式 
			url:"pageShowConfig/modifyPageShowConfig.action",//请求地址
			data:{
				pageConfigId:$("#pageConfigId").val(),
				pageName : pageName,
				perPageNumber : perPageNumber,
				perChartNumber : perChartNumber
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					if(result.success == 1){
						location.href="pageShowConfig/pageShowConfigList.action";
					}else{
						$("#submit").attr('disabled',false);
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
 