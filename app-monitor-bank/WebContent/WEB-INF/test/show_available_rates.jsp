<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
</head>
<body>


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

<!--创建一个div容器-->
<div class="no">
    <!--创建一个div并引入流式布局容器父类样式-->
	<div class="container-fluid">
	    <!--创建一个div流式布局容器并引入span4样式-->
		<div class="row-fluid">
			<div class="span4"  style="width : 100%; height: 600px;" id="ratesDiv"></div>
		</div>
	</div>
</div>

<script type="text/javascript">
    
	//配置ECharts路径 
	require.config({paths:{echarts:'./build/dist/'}});
	
	//使用ECharts图表库并按需加载折线图和柱状图后进入drawEcharts初始化方法
	require(['echarts','echarts/chart/line'],drawEcharts);
	
	
	//执行drawEcharts所有option初始化方法
    function drawEcharts(ec){
		//使用Jquery-Ajax获取所需数据
		$.ajax({
			type:'post',//请求方式 
			async:false,//设置为同步请求
			url:"banksla/getAllratio.action",//请求地址
			data:{},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					var leg = new Array();
					var xTimeArr = new Array();
					
					var seriesArr = new Array();
					var map = {};
					for (var i = 0; i < result.length; i++) {
						
						if(xTimeArr.indexOf(result[i].time) < 0){
							xTimeArr[xTimeArr.length] = result[i].time;
						}
						
						var a = new Array();
						if(typeof(map[result[i].bank_name]) != "undefined"){
							a = map[result[i].bank_name];
						}
						a[a.length] = result[i].available_ratio;
						map[result[i].bank_name] = a;
					}
					
					for(var key in map){
						var legName = key + " " + 
						  			  xTimeArr[xTimeArr.length-1] + " " + 
						 			  map[key][map[key].length-1] + "%";
						var seriesData = {
								name:legName,//系列名称
								type:'line',//图表类型
								clickable:true,//数据图形是否可点击
					            data:map[key],//数据
						};
						seriesArr[seriesArr.length] = seriesData;
						
						leg[leg.length] = legName;
					}
					drawratio(ec,leg,xTimeArr,seriesArr);
				}
				
			},
			error:function(errorMsg){//请求失败后回调函数
				alert("数据加载出错");
			    //设置ECharts过渡控制
				myChart.hideLoading();
			},
		});
		
	}
	
	function drawratio(ec,leg,xTimeArr,seriesArr){
		// 基于准备好的容器,初始化echarts图表
		myChart = ec.init(document.getElementById('ratesDiv'));
		var option={
				title:{//标题
					text:'专线可用率',//主标题文本
					x:'center',//水平安放位置
					y:'top',//垂直安放位置
					padding:8,//标题内边距
					textStyle:{//文字样式
						fontSize:20,//字号
						fontWeight:'bolder',//粗细
						align:'center',//水平对齐方式
					},
				},
				legend:{//图例
					x:'right',//水平安放位置
					y:'10px',//垂直安放位置
					itemWidth:20,//图例图形宽度
					itemHeight:20,//图例图形高度
					padding:[0,0,0,0],//图例内边距
					itemGap:5,//每个图例间隔
					selectedMode:false,//图例开关选择模式
					textStyle:{//文字样式
						fontSize:'12',//字号
					},
					data:leg,//图例内容数组
					orient:'vertical',
				},
				
				grid:{//直角坐标系内绘图网格
					x:40,//左上角横坐标    
					y:50,//左上角纵坐标
					height:'400px',//网格高度
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
						formatter:'{value}%',
					},
				}],
				
				series:seriesArr
				
		};
		
		//为echarts对象加载数据 
		myChart.setOption(option);
	}
	
</script>



</body>
</html>