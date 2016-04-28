<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
 <head>
 <%@include file="/WEB-INF/test/base.jsp"%>
  <title>添加用户信息</title>
  <meta http-equiv="pragma" content="no-cache">
  <meta http-equiv="cache-control" content="no-cache">
  <meta http-equiv="expires" content="0">
  <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
  <meta http-equiv="description" content="This is my page">
 </head>
 <body>
   <table width="60%" border="1">
    <tr align="left">
     <td><input type="hidden" value="${role.roleId}" id="roleId">
        	 用户名：  </td>   
     <td>
     	<input type="text" id="roleName" value="${role.roleName}" />
     </td>
    </tr>
    <tr align="left">
      	<td>用户权限：</td>
     	<td>         
	      	<c:forEach items="${permissions}" var="permission">
	      		<input name="perm" type="checkbox" 	
	      		<c:forEach items="${checked}" var="c">
		      		<c:if test="${permission.permissionValue == c}">
		      			checked="checked"
		      		</c:if>
		      	</c:forEach>
	      		value="${permission.permissionValue}">${permission.permissionName}<br/>
	      	</c:forEach>
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
		var roleName = $("#roleName").val();
		var roleId = $("#roleId").val();
		if($("#roleName").val() == ""){
			alert("请填写角色名！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		if($("#roleId").val() == ""){
			alert("缺少角色ID！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		var rolePermission = 0;
		$('input[name="perm"]:checked').each(function(){
			rolePermission += parseInt($(this).val());
		}); 
		
		$.ajax({
			type:'post',//请求方式 
			url:"role/modifyRole.action",//请求地址
			data:{
				roleId : roleId,				
				roleName : roleName,
				rolePermission : rolePermission
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					if(result.success == 1){
						location.href="role/roleList.action";
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
 