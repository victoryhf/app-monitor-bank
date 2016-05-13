//展开子菜单
function unfoldMenu(){
	$("#userManage").css("display","");
	$("#editInfo").css("display","");
	$("#roleManage").css("display","");
	$("#permissionManage").css("display","");
	$("#systemManage").css("display","");
	$("#pageManage").css("display","");
}

//收缩子菜单
function shrinkMenu(){
	$("#userManage").css("display","none");
	$("#editInfo").css("display","none");
	$("#roleManage").css("display","none");
	$("#permissionManage").css("display","none");
	$("#systemManage").css("display","none");
	$("#pageManage").css("display","none");
}

function changePage(url){
	//$("#ifra").attr("src",url);
	location.href=url;
}

function logout(){
	$.ajax({
		type:'post',//请求方式 
		url:"user/logout.action",//请求地址
		data:{
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					location.href="login.jsp";
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