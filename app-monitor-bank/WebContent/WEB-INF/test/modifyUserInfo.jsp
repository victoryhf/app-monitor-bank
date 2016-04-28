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
     <td>
        	 原始密码：     
      <input type="password" id="oldPassword"/>
     </td>
    </tr>
    <tr align="left">
     <td>
        	 新密码：     
      <input type="password" id="newPassword" />
     </td>
    </tr>
    <tr align="left">
     <td>
        	 确认密码：     
      <input type="password" id="confirm" />
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
		var oldPwd = $("#oldPassword").val();
		var newPwd = $("#newPassword").val();
		var confirm = $("#confirm").val();
		if($("#oldPassword").val() == ""){
			alert("请填写原始密码！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		if($("#newPassword").val() == ""){
			alert("请填写新密码！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		if($("#confirm").val() == ""){
			alert("请填写确认密码！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		if(newPwd != confirm){
			alert("两次密码不一致！");
			$("#submit").attr('disabled',false); 
			return false;
		}
		
		$.ajax({
			type:'post',//请求方式 
			url:"user/modifyPassWord.action",//请求地址
			data:{
				oldPwd : oldPwd,
				newPwd : newPwd
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					if(result.success == 1){
						alert(result.msg);
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
 