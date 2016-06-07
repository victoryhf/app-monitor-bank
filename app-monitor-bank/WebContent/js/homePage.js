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
	var sessionMapId = getCookie("app-monitor-bank-sessionMapId");
	if(sessionMapId == null || sessionMapId == ""){
		location.href="login.jsp";
	}
	var date = new Date(); 
    date.setTime(date.getTime() - 24 * 60 * 60 * 1000); 
    document.cookie = sessionMapId + "=a; expires=" + date.toGMTString(); 
	$.ajax({
		type:'post',//请求方式 
		url:"user/logout.action",//请求地址
		data:{
			sessionMapId : sessionMapId
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

function Setcookie (name, value){ 
    //设置名称为name,值为value的Cookie
    var expdate = new Date();   //初始化时间
    expdate.setTime(expdate.getTime() + 60 * 60 * 1000);   //时间
    document.cookie = name+"="+value+";expires="+expdate.toGMTString()+";path=/";
}

function getCookie(c_name){
	if (document.cookie.length > 0) {
		var c_start = document.cookie.indexOf(c_name + "=")
		if (c_start != -1) {
			c_start = c_start + c_name.length + 1
			c_end = document.cookie.indexOf(";", c_start)
			if (c_end == -1)
				c_end = document.cookie.length
			return unescape(document.cookie.substring(c_start, c_end))
		}
	}
	return null;
}

$(function(){
	var sessionMapId = null;
	var url = $("#url").val();
	if(url.indexOf("show_available_rates") > 0 
			|| url.indexOf("show_request_page") > 0
			|| url.indexOf("show_sla_page") > 0){
		$("#userInfoDiv").hide();
		return;
	}
	var dialogNo = showDialog("正在验证权限，请稍候！");
	if($("#sessionMapId").val() != ""){
		Setcookie ("app-monitor-bank-sessionMapId", $("#sessionMapId").val());
		sessionMapId = $("#sessionMapId").val();
	}else{
		sessionMapId = getCookie("app-monitor-bank-sessionMapId");
	}
	if(sessionMapId == null){
		alert("请登录！");
		location.href="https://sars.99bill.net/sor/app-monitor-bank/login.jsp";
		return;
	}
	
	$.ajax({
		type:'post',//请求方式 
		url:"user/checkSession.action",//请求地址
		data:{
			sessionMapId : sessionMapId,
			url : $("#url").val()
		},//请求数据类型 
		dataType:"json",//请求返回的数据类型
		success:function(result){//请求成功后回调函数
			if(result){
				if(result.success == 1){
					$("#currentUser").html("当前用户："+result.obj.userName);
					$("#currentRoleName").html("当前用户："+result.obj.roleName);
					$("#menu").html("<ul><li id=\"editInfo\"><a href=\"modifyUserInfo.jsp\">修改资料</a></li></ul>");
					if(parseInt(result.obj.getAllUsers) == 16){
						$("#menu").append("<ul><li id=\"userManage\" onclick=\"changePage('user/getAllUsers.action')\" >用户管理</li></ul>");
					}
					if(parseInt(result.obj.roleList) == 32){
						$("#menu").append("<ul><li id=\"roleManage\" onclick=\"changePage('role/roleList.action')\">角色管理</li></ul>");
					}
					if(parseInt(result.obj.configlist) == 64){
						$("#menu").append("<ul><li id=\"systemManage\" onclick=\"changePage('config/configlist.action')\">系统配置</li></ul>");
					}
					if(parseInt(result.obj.pageShowConfigList) == 128){
						$("#menu").append("<ul><li id=\"pageManage\" onclick=\"changePage('pageShowConfig/pageShowConfigList.action')\">页面配置</li></ul>");
					}
				}else{
					location.href="https://sars.99bill.net/sor/app-monitor-bank/login.jsp";
				}
				deleteDialog(dialogNo);
			}
		},
		error:function(errorMsg){//请求失败后回调函数
			location.href="https://sars.99bill.net/sor/app-monitor-bank/login.jsp";
		},
	});
});