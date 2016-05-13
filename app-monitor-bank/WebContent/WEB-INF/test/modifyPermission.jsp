<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
 <head>
 <%@include file="/WEB-INF/test/base.jsp"%>
  <title>添加权限</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
 </head>
 <body>
 	<input type="hidden" id="permissionId" value="${permission. permissionId}"/>
   <table width="60%" border="1">
    <tr align="left">
     <td>权限名：  </td>   
     <td>
     	<input type="text" id="permissionName" value="${permission. permissionName}"/>
     </td>
    </tr>
    <tr align="left">
      	<td>权限值：</td>
     	<td>         
	      	<input type="text" id="permissionValue" value="${permission. permissionValue}"/>
     	</td>
    </tr>
    <tr align="left">
      	<td>权限路径：</td>
     	<td>         
	      	<input type="text" id="permissionUrl" value="${permission. permissionUrl}"/>
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
<script type="text/javascript">
	function save(){
		$("#submit").attr('disabled',true); 
		var permissionName = $("#permissionName").val();
		if($("#permissionName").val() == ""){
			alert("请填写权限名！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		var permissionValue = $("#permissionValue").val();
		if($("#permissionValue").val() == ""){
			alert("请填写权限值！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		var permissionUrl = $("#permissionUrl").val();
		if($("#permissionUrl").val() == ""){
			alert("请填写权限路径！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		var permissionId = $("#permissionId").val();
		if($("#permissionId").val() == ""){
			alert("请选择权限！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		$.ajax({
			type:'post',//请求方式 
			url:"permission/modifyPermission.action",//请求地址
			data:{
				permissionId : permissionId,
				permissionName : permissionName,
				permissionUrl : permissionUrl,
				permissionValue : permissionValue
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					if(result.success == 1){
						location.href="permission/permissionList.action";
					}else{
						$("#submit").attr('disabled',false);
						alert(result.msg);
					}
				}
			},
			error:function(errorMsg){//请求失败后回调函数
				$("#submit").attr('disabled',false);
				alert("数据加载出错");
			},
		});
	}
</script>
 