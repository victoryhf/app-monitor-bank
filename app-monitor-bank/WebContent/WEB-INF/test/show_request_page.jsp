<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" isELIgnored="false" contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@include file="/WEB-INF/test/base.jsp"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>银行SLA监控系统</title>

<!-- ECharts单文件引入-->
<script src="./build/dist/echarts.js"></script>

<link href="bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<link href="./css/top.css" rel="stylesheet">
<style type="text/css">
	#main{
		width: 100%;
		position: relative;
	}
	.list{
		width: 33.33%;
		height: 230px;
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
		font-size: 20px;
	}
</style>
</head>
<body>
<div>
<%@include file="/WEB-INF/test/homePage.jsp"%>
</div>
<div id="title">
	<p>银行专线请求响应数统计</p>
	<span>周期=1分钟&nbsp;&nbsp;&nbsp;&nbsp;
	<fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd"/> 
	</span>
	
</div>
<div id="main">
	
</div>
<div id="pageContain"></div>

<script type="text/javascript">
    var curPage = 1;
    var pageSize = 9;
    var countPage = 1;
    
    $(function(){
    	loadCharts(curPage);
    });
    
    setInterval(function(){
    	loadCharts(curPage);
    },60000);
    
    function loadCharts(cur){
    	curPage = cur;
    	//配置ECharts路径 
    	require.config({paths:{echarts:'./build/dist/'}});
    	
    	//使用ECharts图表库并按需加载折线图和柱状图后进入drawEcharts初始化方法
    	require(['echarts','echarts/chart/bar'],drawEcharts);
    }
	
	
	
	//执行drawEcharts所有option初始化方法
    function drawEcharts(ec){
		//使用Jquery-Ajax获取所需数据
		$.ajax({
			type:'post',//请求方式 
			async:false,//设置为同步请求
			url:"banksla/getBankRequestPage.action",//请求地址
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
					createPagination();
					
					var bankslaPage = result.bankslaPage;
					var xTimeArr = new Array();
					var map = {};
					for (var i = 0; i < bankslaPage.length; i++) {
						if(xTimeArr.indexOf(bankslaPage[i].time) < 0){
							xTimeArr[xTimeArr.length] = bankslaPage[i].time;
						}
						
						if(typeof(map[bankslaPage[i].bank_name]) == "undefined"){
							map[bankslaPage[i].bank_name] = {
								requests : new Array(),
								responses : new Array()
							};
							if(typeof(map["length"]) == "undefined"){
								map["length"] = 1;
							}else{
								map["length"]++;
							}
						}
						
						map[bankslaPage[i].bank_name]["requests"][map[bankslaPage[i].bank_name]["requests"].length] = bankslaPage[i]["total_req"] ;
						map[bankslaPage[i].bank_name]["responses"][map[bankslaPage[i].bank_name]["responses"].length] = bankslaPage[i]["nomal_resp"] ;
					}
					
					var listHtml = "";
					for (var i = 0; i < map.length; i++) {
						listHtml += "<div class=\"list\" id=\"list"+i+"\"></div>";
					}
					$("#main").html(listHtml);
					var index = 0;
					for(var key in map){
						if(key == 'length'){
							continue;
						}
						var title = key;
						var legd = new Array;
						var leg1 = xTimeArr[xTimeArr.length-1]+"分请求数"+map[key]["requests"][map[key]["requests"].length-1]+"笔";
						legd[0] = leg1;
						var leg2 = xTimeArr[xTimeArr.length-1]+"分正常响应数"+map[key]["responses"][map[key]["responses"].length-1]+"笔";
						legd[1] = leg2;
						var totalReqArr = map[key]["requests"];
						var nomalRespArr = map[key]["responses"];
						drawratio(ec,title,legd,leg1,leg2,nomalRespArr,totalReqArr,xTimeArr,index);
						index++;
					}
				} 
				
			},
			error:function(errorMsg){//请求失败后回调函数
				if(errorMsg.status == 403){
					alert("请登录！");
					window.location.href="https://sars.99bill.net/sor/app-monitor-bank/login.jsp";
				}else{
					setTimeout(function(){
						loadCharts(curPage);
					}, 5000);
					showPrompt("数据加载出错！",3000);
				}
			},
		});
		
	}
	
	function drawratio(ec,title,legd,leg1,leg2,nomalRespArr,totalReqArr,xTimeArr,index){
		// 基于准备好的容器,初始化echarts图表
		myChart = ec.init(document.getElementById('list'+index));
		var option={
				
				title:{//标题
					text:title,//主标题文本
					x:'center',//水平安放位置
					y:'top',//垂直安放位置
					padding:8,//标题内边距
					textStyle:{//文字样式
						fontSize:14,//字号
						fontWeight:'bolder',//粗细
						align:'center',//水平对齐方式
					},
				},
				
				legend:{//图例
					x:'40px',//水平安放位置
					y:'210px',//垂直安放位置
					itemWidth:18,//图例图形宽度
					itemHeight:12,//图例图形高度
					padding:[0,0,0,0],//图例内边距
					itemGap:20,//每个图例间隔
					selectedMode:false,//图例开关选择模式
					orient:'horizontal',//布局方式
					textStyle:{//文字样式
						fontSize:'12',//字号
					},
					data:legd,//图例内容数组
				},
				
				grid:{//直角坐标系内绘图网格
					x:35,//左上角横坐标    
					y:35,//左上角纵坐标
					height:'150px',//网格高度
					width:'390px',//网格宽度 
				},
				
				xAxis:[//横坐标轴
				   {   
					type:'category',//坐标轴类型
					data:xTimeArr,//类目列表
				   },
				   {
					type:'category',//坐标轴类型
					axisLine:{show:false},//坐标轴线
					axisTick:{show:false},//坐标轴小标记
					axisLabel:{show:false},//坐标轴文本标签
					splitArea:{show:false},//分隔区域
					splitLine:{show:false},//分隔线
					data : xTimeArr,//类目列表
				   },
				   ],
				
				yAxis:[{//纵坐标轴
					type:'value',//坐标轴类型
					axisLabel:{//坐标轴文本标签
						formatter:'{value}',
					},
				}],
				
				series:[//驱动图表生成的数据内容数组
					{
					 name:leg2,//系列名称
					 type:'bar',//图表类型
					 itemStyle:{//图形样式
						 normal:{//表内图形的默认样式
							 color:'rgba(181,195,52,1)',//图形颜色  
							 label:{//标签
								 show:true,//标签显示策略
								 textStyle:{//标签的文本样式
									 color:'#27727B'//标签的文本颜色
								 }
				            }
				         }
				     },
					 data:nomalRespArr
					},
					
					{
					 name:leg1,//系列名称
					 type:'bar',//图表类型
					 xAxisIndex:1,//xAxis坐标轴数组的索引
					 itemStyle:{//图形样式
						 normal:{//表内图形的默认样式
							 color:'rgba(181,195,52,0.5)',//图形颜色   
							 label:{//标签
								 show:true//标签显示策略
							 }
					     }
					 },
					 data:totalReqArr
					},
				],
				
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