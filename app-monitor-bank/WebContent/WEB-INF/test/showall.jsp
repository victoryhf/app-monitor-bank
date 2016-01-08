<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<script type="text/javascript"></script>
<script src="./build/dist/echarts.js"></script>
<link href="./bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
<link href="./bootstrap-3.3.5-dist/css/bootstrap-responsive.min.css" rel="stylesheet">
<link href="./bootstrap-3.3.5-dist/css/docs.css" rel="stylesheet">
<script src="./jquery-1.9.1/jquery.min.js"></script>
<script src="./bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>

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
	background:url(https://sars.99bill.net/sor/app-monitor-bank/images/systitle.png) left top no-repeat;
}

#bodyTopMain{
	width:auto;
	min-width:1260px;
	height:3px;
	background:url(https://sars.99bill.net/sor/app-monitor-bank/images/body_top_bg.gif) 0 0 repeat-x #39A09B;
	color:#C5F6F2;
	padding:auto;
	z-index: 100;
}

.do{background: #F0F0F0;}
</style>
</head>


<body>
<div id="topMain">
   <div id ="topContainer">
       <div id ="top">
            <img src="https://sars.99bill.net/sor/app-monitor-bank/images/logo.gif" alt="foot step" width="79" height="44" class="logo">
            <div class="systitle"></div>
       </div>
    </div>
</div>
<div id="bodyTopMain"></div>

<div style="margin:8px 0px 0px 0px;">
  <div class="container-fluid">
    <div class="row-fluid">
      <div class="span4"  style="width : 33%; margin-left: 0;" id="rowLeft" >
      </div>
    
      <div class="span4"  style="width : 33%; margin-left: 0;" id="rowMiddle">
      </div>
    
      <div class="span4"  style="width : 33%; margin-left: 0;" id="rowRight">
     </div>
    
    </div>
  </div>
</div>
    
	<script type="text/javascript">	
	   $("#rowLeft").append('<div id="ratio1" style="height:300px"></div>');
	   $("#rowMiddle").append('<div id="sla1" style="height:300px"></div>');
	   $("#rowRight").append('<div id="rrbar1" style="height:300px"></div>');
		// 路径配置
		require.config({
			paths : {
				echarts : './build/dist/'
			}
		});

		// 使用
		require([ 'echarts', 'echarts/chart/line','echarts/chart/bar' // 使用折线图就加载line模块，按需加载
		          
		          ], 
		    
		          drawEcharts
		    );
			 
	    function drawEcharts(ec){
	    	  drawratio1(ec);
	    	  drawsla1(ec);
	    	  drawrrbar1(ec);
		     
		}
		 
	    //ratio1
       function drawratio1(ec) {
			//ajax查询后台数据存放在各个变量中
			var ratioTitle="专线可用率曲线图";
			var leg=[];
			var date="";
			var dtime="";
			var dmark="";
			var d = new Date();
			var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
			var xTimeArr = [];
			var yAvailableRatioArr =[];
			var marklineAvailableRatioThreshold = null;
			$.ajax({
					type : "post",
					async : false, //同步执行
					url : "banksla/ratiolist.action",
					data : {},
					dataType : "json", //返回数据形式为json
					success : function(result) {
								if (result) {
									console.log(result[0].bank_name);
									ratioTitle = result[0].bank_name + ratioTitle;
									dtime=result[result.length-1].time;
									dmark=result[result.length-1].available_ratio_threshold;
									leg[0]=dtime+"分可用率"+result[result.length-1].available_ratio+"%"+"    阀值"+dmark+"%"+"    周期=1分钟    "+str;
									date=leg[0];
									for (var i = 0; i < result.length; i++) {
										    console.log(result[i].time);
										    xTimeArr.push(result[i].time);
										    yAvailableRatioArr.push(result[i].available_ratio);
									     }
									marklineAvailableRatioThreshold = result[0].available_ratio_threshold;
                                    
                                   
								}

							},
							error : function(errorMsg) {
								alert("数据加载出错");
								myChart.hideLoading();
							}
						});
					
			// 基于准备好的dom，初始化echarts图表
			myChart = ec.init(document.getElementById('ratio1'));
			var option = {

			    title : {
					text: ratioTitle,
					x:'center',
					y:'top',
					padding:8,
					textStyle :{
						fontSize: 14,
					    fontWeight: 'bolder',
					    align: 'center',
					    
					}
					
			    },
			    
				grid:{
					x:45,
					y:35,
					height:'130px', 
					width:'370px'
					
				},
				
			    legend: {
			    	show:true,
			    	x:'45px',
			    	y:'195px',
			    	itemWidth:18,
			    	itemHeight:12,
			    	padding:[0,0,0,0],
			    	itemGap:2,
			    	selectedMode:false,			    	
			    	orient:'vertical',
			    	textStyle:{
			    		fontSize:'6',
			    	},
	               data:leg,
			    },
				
				calculable : true,

				xAxis : [ {
					type : 'category',
					boundaryGap : false,
					data : xTimeArr,
				  /*   axisLabel:{
					       rotate:45,
					       interval:0,
						   margin: 0.5,
						   textStyle:{
						   //color:"red", //刻度颜色
						   fontSize:0.5  //刻度大小
					
						}
					},   */
				   
				   
				
				
				} ],
				
				yAxis : [ {

					type : 'value',
					//splitArea : {show : true},
					axisLabel : {
						formatter : '{value}%'
					}
					
				
				} ],

				
				series : [ {
					name : date,
					type : 'line',
					data : yAvailableRatioArr,
					clickable:false,
					markLine : {
						clickable:false,
	                    data : [
	                        [{name: '可用率阀值',value: marklineAvailableRatioThreshold, xAxis: -1, yAxis: marklineAvailableRatioThreshold},{xAxis:16,yAxis: marklineAvailableRatioThreshold}]
	                 
	                        ], 
	                        
			           },
				},
	 
				
				]
				
			
			};
			myChart.setOption(option);
		
		
		}
		
	    //sla
		function drawsla1(ec) {
			
			//ajax查询后台数据存放在各个变量中
			var slaTitle="sla曲线图";
			var leg=[];
			var date="";
			var dtime="";
			var dmark="";
			var d = new Date();
			var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
			var xTimeArr = [];
			var yAverageSla =[];
			var marklineSlaThreshold = null;
			$.ajax({
					type : "post",
					async : false, //同步执行
					url : "banksla/ratiolist.action",
					data : {},
					dataType : "json", //返回数据形式为json
					success : function(result) {
								if (result) {
									console.log(result[0].bank_name);
									slaTitle = result[0].bank_name + slaTitle;
									dtime=result[result.length-1].time;
									dmark=result[result.length-1].sla_threshold;
									leg[0]=dtime+"分sla"+result[result.length-1].average_sla+"ms"+"    阀值"+dmark+"ms"+"    周期=1分钟    "+str;
									date=leg[0];
									for (var i = 0; i < result.length; i++) {
										    console.log(result[i].time);
										    xTimeArr.push(result[i].time);
										    yAverageSla.push(result[i].average_sla);
									     }
									marklineSlaThreshold = result[0].sla_threshold;

								}

							},
							error : function(errorMsg) {
								alert("数据加载出错");
								myChart.hideLoading();
							}
						})
					
			// 基于准备好的dom，初始化echarts图表
			myChart = ec.init(document.getElementById('sla1'));
			var option = {
					
			    title : {
					text: slaTitle,
					x:'center',
					y:'top',
					padding:8,
					textStyle :{
						fontSize: 14,
					    fontWeight: 'bolder',
					    align: 'center',
					    
					}
			    },
			    
				grid:{
					x:58,
					y:35,
					height:'130px', 
					width:'350px'
					
				},
				 legend: {
				    	show:true,
				    	x:'60px',
				    	y:'195px',
				    	itemWidth:18,
				    	itemHeight:12,
				    	padding:[0,0,0,0],
				    	itemGap:2,
				    	selectedMode:false,			    	
				    	orient:'vertical',
				    	textStyle:{
				    		fontSize:'6',
				    	},
		               data:leg,
				    },
				
				calculable : true,

				xAxis : [ {
					type : 'category',
					boundaryGap : false,
					data : xTimeArr,
				} ],
				
				yAxis : [ {

					type : 'value',
					splitNumber:5,
					axisLabel : {
						formatter : '{value} ms'
					}
				} ],

				
				series : [ {
					name : date,
					type : 'line',
				   //折线颜色
				   // itemStyle:{
				   // 	normal:{
				   // 		lineStyle:{
				   // 			color:'#6eaaee',
				   // 		}
				   // 	}
				   // },
					data : yAverageSla,
					clickable:false,
					markLine : {
						clickable:false,
	                    data : [
	                         [{name: 'SLA阀值',value: marklineSlaThreshold, xAxis: -1, yAxis: marklineSlaThreshold},{xAxis:16,yAxis: marklineSlaThreshold}]
	                           ]
			           }
					

				}, 
				
				]
				
			};

			// 为echarts对象加载数据 
			myChart.setOption(option);
			//window.onresize = myChart.resize;
		}	
	    
        
	    //
	    function drawrrbar1(ec) {
			//ajax查询后台数据存放在各个变量中
			var rrTitle="请求响应数统计";
			var leg=[];
			var leg1="";
			var leg2="";
			var dtime="";
			var d = new Date();
			var str = d.getFullYear()+"-"+(d.getMonth()+1)+"-"+d.getDate();
			var xTimeArr = [];
			var nomalRespArr = [];
			var totalReqArr= [];
			
			$.ajax({
					type : "post",
					async : false, //同步执行
					url : "banksla/ratiolist.action",
					data : {},
					dataType : "json", //返回数据形式为json
					success : function(result) {
								if (result) {
									console.log(result[0].bank_name);
									rrTitle = result[0].bank_name + rrTitle;
									dtime=result[result.length-1].time;
									leg[0]=dtime+"分请求数"+result[result.length-1].total_req+"笔";
									leg[1]=dtime+"分正常响应数"+result[result.length-1].nomal_resp+"笔"+"    周期=1分钟  ";
									leg1=leg[0];
									leg2=leg[1];
									for (var i = 0; i < result.length; i++) {
										    console.log(result[i].time);
										    xTimeArr.push(result[i].time);
										    nomalRespArr.push(result[i].nomal_resp);
										    totalReqArr.push(result[i].total_req);
									     }
									

								}

							},
							error : function(errorMsg) {
								alert("数据加载出错");
								myChart.hideLoading();
							}
						})
					
			// 基于准备好的dom，初始化echarts图表
			myChart = ec.init(document.getElementById('rrbar1'));
			var option = {
					
			    title : {
					text: rrTitle,
					x:'center',
					y:'top',
					padding:8,
					textStyle :{
						fontSize: 14,
					    fontWeight: 'bolder',
					    align: 'center',
					    
					}
			    },
			    
			    legend: {
			    	show:true,
			    	x:'40px',
			    	y:'195px',
			    	itemWidth:18,
			    	itemHeight:12,
			    	padding:[0,0,0,0],
			    	itemGap:20,
			    	selectedMode:false,			    	
			    	orient:'horizontal',
			    	textStyle:{
			    		fontSize:'6',
			    	},
	               data:leg,
			    },
			    
			    
				tooltip : {
					trigger: 'axis',
					//show:false
				},
				
				calculable : true,
				
				grid:{
					x:35,
					y:35,
					height:'130px', 
					width:'390px'
					
				},
				
				
				xAxis : [ {
					type : 'category',
					data : xTimeArr
				},
				{
		            type : 'category',
		            axisLine: {show:false},
		            axisTick: {show:false},
		            axisLabel: {show:false},
		            splitArea: {show:false},
		            splitLine: {show:false},
		            data : xTimeArr
		        }
				
				],
				
				yAxis : [ {

					type : 'value',
					axisLabel : {
						formatter : '{value} '
					}
				} ],

				
			    series : [
			              {
			                  name:leg2,
			                  type:'bar',
			                  itemStyle: {normal: {color:'rgba(181,195,52,1)', label:{show:true,textStyle:{color:'#27727B'}}}},
			                  data:nomalRespArr
			              },

			              {
			                  name:leg1,
			                  type:'bar',
			                  xAxisIndex:1,
			                  itemStyle: {normal: {color:'rgba(181,195,52,0.5)', label:{show:true}}},
			                  data:totalReqArr
			              }
			          ]
				
			};

			// 为echarts对象加载数据 
			myChart.setOption(option);
		}
	    
		
	</script>





</body>
</html>