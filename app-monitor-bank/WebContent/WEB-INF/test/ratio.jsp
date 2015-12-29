<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<title>Insert title here</title>

<script src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
<style type="text/css">

.div{width:438px;height:208px;border:0px;
}
</style>
</head>
<body>


	<div id="main" class="div"></div>

	<script type="text/javascript">
	
	   
		// 路径配置
		require.config({
			paths : {
				echarts : 'http://echarts.baidu.com/build/dist'
			}
		});

		// 使用
		require([ 'echarts', 'echarts/chart/line' // 使用折线图就加载line模块，按需加载
		], function drewEcharts(ec) {
			
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
			myChart = ec.init(document.getElementById('main'));
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

		);
	</script>





</body>
</html>