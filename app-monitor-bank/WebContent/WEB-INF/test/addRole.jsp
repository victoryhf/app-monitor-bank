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
 <div>
<%@include file="/WEB-INF/test/homePage.jsp"%>
</div>
   <table width="60%" border="1">
    <tr align="left">
     <td>角色名：  </td>   
     <td>
     	<input type="text" id="roleName"/>
     </td>
    </tr>
    <tr align="left">
      	<td>用户权限：</td>
     	<td>         
	      	<c:forEach items="${permissions}" var="permission">
	      		<input name="perm" type="checkbox" value="${permission.permissionValue}">${permission.permissionName}<br/>
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
		if($("#roleName").val() == ""){
			alert("请填写角色名！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		var rolePermission = 0;
		$('input[name="perm"]:checked').each(function(){
			rolePermission += parseInt($(this).val());
		}); 
		
		$.ajax({
			type:'post',//请求方式 
			url:"role/addRole.action",//请求地址
			data:{
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
 