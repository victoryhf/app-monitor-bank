<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!--获取Path路径-->    
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%   
  //页面每隔60秒自动刷新一遍        
  response.setHeader("refresh" , "60" );  
%>  
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>银行SLA监控系统</title>

<!-- ECharts单文件引入-->
<script src="./build/dist/echarts.js"></script>
<!--引入Jquery核心文件-->
<script src="./jquery-1.9.1/jquery.min.js"></script>
<!--引入 Bootstrap核心 文件 -->
<script src="./bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<!--引入bootstrap.min.css文档的外部样式表-->
<link href="./bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<!--引入bootstrap-responsive.min.css文档的外部样式表 -->
<link href="./bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
<!--引入bootstrap-3.3.5-dist/css/docs.css文档的外部样式表-->
<link href="./bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">
<link href="./css/top.css" rel="stylesheet">
<style type="text/css">
	#main{
		width: 100%;
		position: relative;
	}
	.list{
		width: 33.33%;
		height: 300px;
		display: inline-block;
	}
	#pageContain{
		width: 100%;
		text-align: center;
		position: relative;
	}
	#title{
		width: 100%;
		text-align: center;
		
	}
	
	#title p{
		font-size: 28px;
	}
</style>
</head>
<body>

<input type="hidden" value="1" id="curPage">
<!--设置页面top并引入指定的Css样式-->
<div id="topMain">
	<div id="topContainer">
		<div id="top">
			<img src="https://sars.99bill.net/sor/app-monitor-bank/images/logo.gif" alt="foot step" width="79" height="44" class="logo">
			<div class="systitle"></div>
		</div>
	</div>
</div>
<div id="bodyTopMain"></div>
<div id="title">
	<p>银行专线sla曲线图</p>
	<span>周期=1分钟&nbsp;&nbsp;&nbsp;&nbsp;
	<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd"/> 
	
	</span>
	
</div>
<div id="main">
	
</div>
<div id="pageContain"></div>

<script type="text/javascript">
    var curPage = parseInt($("#curPage").val());
    var pageSize = 18;
    var countPage = 1;
    
    $(function(){
    	loadCharts(curPage);
    });
    
    function loadCharts(cur){
    	curPage = cur;
    	//配置ECharts路径 
    	require.config({paths:{echarts:'./build/dist/'}});
    	
    	//使用ECharts图表库并按需加载折线图和柱状图后进入drawEcharts初始化方法
    	require(['echarts','echarts/chart/line'],drawEcharts);
    }
	
	
	
	//执行drawEcharts所有option初始化方法
    function drawEcharts(ec){
		//使用Jquery-Ajax获取所需数据
		$.ajax({
			type:'post',//请求方式 
			async:false,//设置为同步请求
			url:"banksla/getBankslaPage.action",//请求地址
			data:{
				curPage : curPage,
				pageSize : pageSize
			},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					//生成分页标签
					curPage = result.curPage;
					countPage = result.countPage;
					$("#curPage").val(curPage);
					createPagination();
					
					var bankslaPage = result.bankslaPage;
					var leg = new Array();
					var xTimeArr = new Array();
					
					var seriesArr = new Array();
					var map = {};
					var slaThresholdMap = {};
					for (var i = 0; i < bankslaPage.length; i++) {
						if(xTimeArr.indexOf(bankslaPage[i].time) < 0){
							xTimeArr[xTimeArr.length] = bankslaPage[i].time;
						}
						
						var a = new Array();
						if(typeof(map[bankslaPage[i].bank_name]) != "undefined"){
							a = map[bankslaPage[i].bank_name];
						}else{
							if(typeof(map["length"]) == "undefined"){
								map["length"] = 1;
							}else{
								map["length"]++;
							}
						}
						slaThresholdMap[bankslaPage[i].bank_name] = bankslaPage[0].sla_threshold;
						a[a.length] = bankslaPage[i].average_sla;
						map[bankslaPage[i].bank_name] = a;
					}
					
					var listHtml = "";
					var k = 1;
					for (var key in map) {
						if(k % 2 == 0){
							listHtml += "<div class=\"list\" id=\"list"+k/2+"\"></div>";
						}else if(k == map.length){
							listHtml += "<div class=\"list\" id=\"list"+(k+1)/2+"\"></div>";
						}
						k++;
					}
					$("#main").html(listHtml);
					var index = 1;
					for(var key in map){
						if(key == 'length'){
							continue;
						}
						var legName = key+"   "+xTimeArr[xTimeArr.length-1]+"分sla"+map[key][map[key].length-1]+"ms    阀值"+slaThresholdMap[key]+"ms";
						var seriesData = {
								name:legName,//系列名称
								type:'line',//图表类型
								clickable:true,//数据图形是否可点击
					            data:map[key],//数据
					            markLine : {
					                data : [
					                    [
											{name: '标注线起点', value: slaThresholdMap[key], xAxis: xTimeArr[0], yAxis: slaThresholdMap[key]},
											{name: '标注线终点', xAxis: xTimeArr[xTimeArr.length-1], yAxis: slaThresholdMap[key]}
										]
					                ]
					            }
						};
						seriesArr[seriesArr.length] = seriesData;
						
						leg[leg.length] = legName;
						if(index % 2 == 0){
							drawratio(ec,leg,xTimeArr,seriesArr,index/2);
							seriesArr = new Array();
							leg = new Array();
						}else if(index == map.length){
							drawratio(ec,leg,xTimeArr,seriesArr,(index+1)/2);
							seriesArr = new Array();
							leg = new Array();
						}
						index++;
					}
				} 
				
			},
			error:function(errorMsg){//请求失败后回调函数
				alert("数据加载出错");
			    //设置ECharts过渡控制
				myChart.hideLoading();
			},
		});
		
	}
	
	function drawratio(ec,leg,xTimeArr,seriesArr,index){
		// 基于准备好的容器,初始化echarts图表
		myChart = ec.init(document.getElementById('list'+index));
		var option={
				/* title:{//标题
					text:'专线可用率',//主标题文本
					x:'center',//水平安放位置
					y:'top',//垂直安放位置
					padding:8,//标题内边距
					textStyle:{//文字样式
						fontSize:20,//字号
						fontWeight:'bolder',//粗细
						align:'center',//水平对齐方式
					},
				}, */
				legend:{//图例
					x:'center',//水平安放位置
					y:'265px',//垂直安放位置
					itemWidth:18,//图例图形宽度
					itemHeight:12,//图例图形高度
					padding:[0,0,0,0],//图例内边距
					itemGap:5,//每个图例间隔
					selectedMode:false,//图例开关选择模式
					textStyle:{//文字样式
						fontSize:'10',//字号
					},
					data:leg,//图例内容数组
					orient:'vertical',
				},
				
				grid:{//直角坐标系内绘图网格
					x:'10%',//左上角横坐标    
					y:10,//左上角纵坐标
					height:'230px',//网格高度
					width:'80%',//网格宽度 
				},
				
				xAxis:[{//横坐标轴
					type:'category',//坐标轴类型
					boundaryGap:false,//类目起始和结束两端空白策略
					data:xTimeArr,//类目列表
				}],
				
				yAxis:[{//纵坐标轴
					type:'value',//坐标轴类型
					axisLabel:{//坐标轴文本标签
						formatter:'{value}ms',
					},
				}],
				
				series:seriesArr
				
		};
		
		//为echarts对象加载数据 
		myChart.setOption(option);
	}
	
	//生成分页码
	function createPagination(){
		var html = "<ul class=\"pagination\">";
		if(countPage != 1 && curPage != 1){
			html += "<li id = \"lastPage\"><a href=\"javascript:void(0);\" onclick = \"changePage('last')\">上一页</a></li>";
		}
		
		for (var i = 1; i <= countPage; i++) {
			if(curPage == i){
				html += "<li id = \"page"+i+"\" class=\"active\"><a href=\"javascript:void(0);\" onclick=\"loadCharts("+i+")\">"+i+"</a></li>";
			}else{
				html += "<li id = \"page"+i+"\"><a href=\"javascript:void(0);\" onclick=\"loadCharts("+i+")\">"+i+"</a></li>";
			}
		}
		if(countPage != 1 && curPage != countPage){
			html += "<li id=\"nextPage\"><a href=\"javascript:void(0);\" onclick=\"changePage('next')\">下一页</a></li>";
		}
		html += "</ul>";
		$("#pageContain").html(html);
	}
	
	function changePage(operate){
		if(operate == 'next'){
			loadCharts(curPage+1);
		}
		if(operate == 'last'){
			loadCharts(curPage-1);
		}
	}
</script>

</body>
</html>