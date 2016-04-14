/**
 * 自定义会话框
 */

var dialogNo = 0;

function showDialog(msg){
	if(typeof(msg) == "undefined"){
		msg = "";
	}
	dialogNo++;
	$(document.body).prepend("<div id=\"dialog_"+dialogNo+"\" class=\"dialog\"><span>"+msg+"</span></div>");
	return dialogNo;
}

function deleteDialog(dialogNo){
	if(typeof($("#dialog_"+dialogNo)) != "undefined"){
		$("#dialog_"+dialogNo).remove();
	}
}


var tipsNo = 0;

function showTips(msg,bt1,callBack1,bt2,callBack2){
	if(typeof(msg) == "undefined"){
		return;
	}
	tipsNo++;
	var html = "<div id=\"tips_"+tipsNo+"\" class=\"tips\">";
	html += "<div>";
	html += "<span>"+msg+"</span>";
	html += "<a href=\"javascript:void(0);\" class=\"btn1\"  onclick=\""+callBack1+"\">"+bt1+"</a>";
	html += "<a href=\"javascript:void(0);\" class=\"btn2\"  onclick=\""+callBack2+"\">"+bt2+"</a>";
	html += "</div>";
	html += "</div>";
	$(document.body).prepend(html);
	return tipsNo;
}

function deleteTips(tipsNo){
	if(typeof($("#tips_"+tipsNo)) != "undefined"){
		$("#tips_"+tipsNo).remove();
	}
}

function showPrompt(msg,time){
	if(typeof(msg) == "undefined"){
		return;
	}
	tipsNo++;
	var html = "<div id=\"prompt_"+tipsNo+"\" class=\"prompt\">";
	html += msg;
	html += "</div>";
	$(document.body).prepend(html);
	setTimeout(function(){
		$("#prompt_"+tipsNo).remove();
	},time);
}

