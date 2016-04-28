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
	$("#ifra").attr("src",url);
}