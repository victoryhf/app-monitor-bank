<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!--获取Path路径-->    
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>   
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>银行SLA监控系统</title>

<!-- ECharts单文件引入-->
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<!--引入Jquery核心文件-->
<script src="<%=path%>/jquery-1.9.1/jquery.min.js"></script>
<!--引入 Bootstrap核心 文件 -->
<script src="<%=path%>/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
<!--引入bootstrap.min.css文档的外部样式表-->
<link href="<%=path%>/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<!--引入bootstrap-responsive.min.css文档的外部样式表 -->
<link href="<%=path%>/bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
<!--引入bootstrap-3.3.5-dist/css/docs.css文档的外部样式表-->
<link href="<%=path%>/bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">
<!--定义页面Top样式-->
<style type="text/css">
	.title_left{
		height:25px;
		font:16px Arial,Verdana,"微软雅黑";
		color:#0060a6;
		background-color:inherit;
		text-decoration:none;
		text-align:right;
		padding:0;
    }
    .title_left span{
		height:25px;
		font:16px Arial,Verdana,"微软雅黑";
		color:#0060a6;
		background-color:inherit;
		text-decoration:none;
		text-align:center;
		text-transform:uppercase;
		float:left;
		padding-top:4px;
    }
    #topMain{
		width:100%;
		height:60px;
    }
    #topContainer{
		width:auto;
		min-width:1240px;
		padding:0px 0 0px 0;
		margin:0 auto;
    }
    #top{
		width:98%;
		margin:0 auto;
		padding:0 auto;
		height:100px;
    }
    #top img.logo{
		display:block;
		width:104px;
		height:58px;
		margin:0px 10px 0 0;
		float:left;
    }
    .systitle{
		width:280px;
		height:43px;
		float:left;
		margin:10px 0 0 0px;
		padding:10px 0 0 0;
		font-size:26px;
		text-align:left;
		line-height:25px;
		color:#3F3F3F;
		background-color:inherit;
		background:url(/app-monitor-bank/images/systitle.png) left top no-repeat;
    }
    #bodyTopMain{
		width:auto;
		min-width:1260px;
		height:3px;
		background:url(/app-monitor-bank/images/body_top_bg.gif) 0 0 repeat-x #39A09B;
		color:#C5F6F2;
		padding:auto;
		z-index: 100;
    }
    .do{background: #F0F0F0;}
    .no{margin:8px 0px 0px 0px;}
</style>
</head>
<body>


<!--设置页面top并引入指定的Css样式-->
<div id="topMain">
	<div id="topContainer">
		<div id="top">
			<img src="/app-monitor-bank/images/logo.gif" alt="foot step" width="79" height="44" class="logo">
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
			<div class="span4"  style="width : 33%; margin-left: 0;" id="rowLeft" ></div>
			<div class="span4"  style="width : 33%; margin-left: 0;" id="rowMiddle"></div>
			<div class="span4"  style="width : 33%; margin-left: 0;" id="rowRight"></div>
		</div>
	</div>
</div>

<script type="text/javascript">
    //使用Jquery的append函数在指定元素的结尾插入指定内容
	$("#rowLeft").append('<div id="ratio1" style="height:300px"></div>');
	$("#rowMiddle").append('<div id="sla1" style="height:300px"></div>');
	$("#rowRight").append('<div id="rrbar1" style="height:300px"></div>');
	
	//配置ECharts路径 
	require.config({paths:{echarts:'http://echarts.baidu.com/build/dist'}});
	
	//使用ECharts图表库并按需加载折线图和柱状图后进入drawEcharts初始化方法
	require(['echarts','echarts/chart/line','echarts/chart/bar'],drawEcharts);
	
	//执行drawEcharts所有option初始化方法
    function drawEcharts(ec){
		
		var leg=[];
		var date="";
    	var ratioTitle="";
    	var xTimeArr=[];
    	var yAvailableRatioArr=[];
    	var d = new Date();
    	var marklineAvailableRatioThreshold = null;
    	
    	var slaTitle="";
    	var legn=[];
    	var daten="";
    	var yAverageSla=[];
    	var marklineSlaThreshold = null;
    	
    	var rrTitle="";
    	var legd=[];
    	var leg1="";
    	var leg2="";
    	var nomalRespArr=[];
    	var totalReqArr=[];
		//使用Jquery-Ajax获取所需数据
		$.ajax({
			type:'post',//请求方式 
			async:false,//设置为同步请求
			url:"banksla/ratiolist.action",//请求地址
			data:{},//请求数据类型 
			dataType:"json",//请求返回的数据类型
			success:function(result){//请求成功后回调函数
				if(result){
					ratioTitle=result[0].bank_name+"专线可用率曲线图";//1获取标题
					slaTitle=result[0].bank_name+"sla曲线图";//2获取标题
					rrTitle=result[0].bank_name+"请求响应数统计";//3获取标题
					marklineAvailableRatioThreshold = result[0].available_ratio_threshold;//1获取标线起点
					marklineSlaThreshold = result[0].sla_threshold;//2获取标线起点
					leg[0]=result[result.length-1].time+"分可用率"+result[result.length-1].available_ratio+"%"+"    阀值"+result[result.length-1].available_ratio_threshold+"%"+"    周期=1分钟    "+d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();//1.获取图例                      
					legn[0]=result[result.length-1].time+"分sla"+result[result.length-1].average_sla+"ms"+"    阀值"+result[result.length-1].sla_threshold+"ms"+"    周期=1分钟    "+d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();//2.获取图例
					legd[0]=result[result.length-1].time+"分请求数"+result[result.length-1].total_req+"笔";//3获取图例  
					legd[1]=result[result.length-1].time+"分正常响应数"+result[result.length-1].nomal_resp+"笔"+"    周期=1分钟  ";//3获取图例  
					date=leg[0];//1获取系列名称
					daten=legn[0];//2获取系列名称
					leg1=legd[0];//3获取系列名称
					leg2=legd[1];//3获取系列名称
					for (var i = 0; i < result.length; i++) {
						xTimeArr.push(result[i].time);//1获取X轴数据
						yAvailableRatioArr.push(result[i].available_ratio);//1获取Y轴数据
						yAverageSla.push(result[i].average_sla);//2获取Y轴数据
						nomalRespArr.push(result[i].nomal_resp);//3获取每分钟正常响应数据
						totalReqArr.push(result[i].total_req);////3获取每分钟请求数据
					}
				}
				
			},
			error:function(errorMsg){//请求失败后回调函数
				alert("数据加载出错");
			    //设置ECharts过渡控制
				myChart.hideLoading();
			},
		});
		drawratio1(ec,date,leg,ratioTitle,xTimeArr,yAvailableRatioArr,marklineAvailableRatioThreshold);
		drawsla1(ec,slaTitle,legn,daten,yAverageSla,marklineSlaThreshold,xTimeArr);
		drawrrbar1(ec,rrTitle,legd,leg1,leg2,nomalRespArr,totalReqArr,xTimeArr);
	}
	
	//中国银联CP00010001专线可用率
	function drawratio1(ec,date,leg,ratioTitle,xTimeArr,yAvailableRatioArr,marklineAvailableRatioThreshold){

		
		// 基于准备好的容器,初始化echarts图表
		myChart = ec.init(document.getElementById('ratio1'));
		var option={
				
				title:{//标题
					text:ratioTitle,//主标题文本
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
					x:'45px',//水平安放位置
					y:'195px',//垂直安放位置
					itemWidth:18,//图例图形宽度
					itemHeight:12,//图例图形高度
					padding:[0,0,0,0],//图例内边距
					itemGap:2,//每个图例间隔
					selectedMode:false,//图例开关选择模式
					orient:'vertical',//布局方式
					textStyle:{//文字样式
						fontSize:'6',//字号
					},
					data:leg,//图例内容数组
				},
				
				grid:{//直角坐标系内绘图网格
					x:45,//左上角横坐标    
					y:35,//左上角纵坐标
					height:'130px',//网格高度
					width:'370px',//网格宽度 
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
				
				series:[{//驱动图表生成的数据内容数组
					name:date,//系列名称
					type:'line',//图表类型
					data:yAvailableRatioArr,//数据
					clickable:false,//数据图形是否可点击
					markLine:{//标线
						clickable:false,//数据图形是否可点击
						data:[//标线图形数据
						   [  
						     {//标线起点
							   name:'可用率阀值',
							   value:marklineAvailableRatioThreshold,
							   xAxis:-1,
							   yAxis:marklineAvailableRatioThreshold,
						     },
						     
						     {//标线终点
						       xAxis:16,
						       yAxis:marklineAvailableRatioThreshold,
						     }
						   ],   
						],
					},
				}],
				
		};
		
		//为echarts对象加载数据 
		myChart.setOption(option);
	}
	
	
	//中国银联CP00010001专线时效
	function drawsla1(ec,slaTitle,legn,daten,yAverageSla,marklineSlaThreshold,xTimeArr){
		// 基于准备好的容器,初始化echarts图表
		myChart = ec.init(document.getElementById('sla1'));
		var option={
				
				title:{//标题
					text:slaTitle,//主标题文本
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
					x:'60px',//水平安放位置
					y:'195px',//垂直安放位置
					itemWidth:18,//图例图形宽度
					itemHeight:12,//图例图形高度
					padding:[0,0,0,0],//图例内边距
					itemGap:2,//每个图例间隔
					selectedMode:false,//图例开关选择模式
					orient:'vertical',//布局方式
					textStyle:{//文字样式
						fontSize:'6',//字号
					},
					data:legn,//图例内容数组
				},
				
				grid:{//直角坐标系内绘图网格
					x:58,//左上角横坐标    
					y:35,//左上角纵坐标
					height:'130px',//网格高度
					width:'350px',//网格宽度 
				},
				
				xAxis:[{//横坐标轴
					type:'category',//坐标轴类型
					boundaryGap : false,//类目起始和结束两端空白策略
					data:xTimeArr,//类目列表
				}],
				
				yAxis:[{//纵坐标轴
					type:'value',//坐标轴类型
					splitNumber:5,//坐标轴分割段数
					axisLabel:{//坐标轴文本标签
						formatter:'{value}ms',
					},
				}],
				
				series:[{//驱动图表生成的数据内容数组
					name:daten,//系列名称
					type:'line',//图表类型
					data:yAverageSla,//数据
					clickable:false,//数据图形是否可点击
					markLine:{//标线
						clickable:false,//数据图形是否可点击
						data:[//标线图形数据
						   [  
						     {//标线起点
							   name:'SLA阀值',
							   value:marklineSlaThreshold,
							   xAxis:-1,
							   yAxis:marklineSlaThreshold,
						     },
						     
						     {//标线终点
						       xAxis:16,
						       yAxis:marklineSlaThreshold,
						     }
						   ],   
						],
					},
				}],
				
		};
		
		//为echarts对象加载数据 
		myChart.setOption(option);
	}
	
	//中国银联CP00010001专线请求响应
	function drawrrbar1(ec,rrTitle,legd,leg1,leg2,nomalRespArr,totalReqArr,xTimeArr){
		// 基于准备好的容器,初始化echarts图表
		myChart = ec.init(document.getElementById('rrbar1'));
		var option={
				
				title:{//标题
					text:rrTitle,//主标题文本
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
					y:'195px',//垂直安放位置
					itemWidth:18,//图例图形宽度
					itemHeight:12,//图例图形高度
					padding:[0,0,0,0],//图例内边距
					itemGap:20,//每个图例间隔
					selectedMode:false,//图例开关选择模式
					orient:'horizontal',//布局方式
					textStyle:{//文字样式
						fontSize:'6',//字号
					},
					data:legd,//图例内容数组
				},
				
				grid:{//直角坐标系内绘图网格
					x:35,//左上角横坐标    
					y:35,//左上角纵坐标
					height:'130px',//网格高度
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
</script>



</body>
</html>