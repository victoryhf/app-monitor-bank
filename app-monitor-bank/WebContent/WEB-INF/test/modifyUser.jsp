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
     <td><input type="hidden" value="${user.userId}" id="userId">
        	 用户名：     
      <input type="text" id="userName" value="${user.userName}" />
     </td>
    </tr>
    <tr align="left">
     <td>
                   用户角色：           
      <select id="roleId">
      	<c:forEach items="${roles}" var="role">
      		<option value="${role.roleId}"  <c:if test="${user.roleId == role.roleId}">selected="selected"</c:if>>
      			${role.roleName}
      		</option>
      	</c:forEach>
      </select>
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
		var userName = $("#userName").val();
		var roleId = $("#roleId").val();
		var userId = $("#userId").val();
		if($("#userName").val() == ""){
			alert("请填写用户名！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		if($("#roleId").val() == ""){
			alert("请选择用户角色！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		$.ajax({
			type:'post',//请求方式 
			url:"user/modifyUser.action",//请求地址
			data:{
				userName : userName,
				roleId : roleId,
				userId : userId
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					if(result.success == 1){
						location.href="user/getAllUsers.action";
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
 