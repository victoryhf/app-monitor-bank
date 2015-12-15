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

<script type="text/javascript"
	src="http://code.jquery.com/jquery-1.8.2.min.js"></script>
<script src="http://echarts.baidu.com/build/dist/echarts.js"></script>

</head>
<body>


	<div id="main" style="height: 350px"></div>

	<script type="text/javascript">
		// 路径配置
		require.config({
			paths : {
				echarts : 'http://echarts.baidu.com/build/dist'
			}
		});

		// 使用
		require([ 'echarts', 'echarts/chart/bar' // 使用折线图就加载line模块，按需加载
		], function drewEcharts(ec) {
			
			//ajax查询后台数据存放在各个变量中
			var rrTitle="请求响应数统计";
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
			myChart = ec.init(document.getElementById('main'));
			var option = {
					
			    title : {
					text: rrTitle,
			    },
			    
				tooltip : {
					trigger: 'axis'
				},
				
				legend: {
				    data:[
				            '正常响应笔数',
				            '总请求笔数'
				         ]
				},
				
				calculable : true,

				xAxis : [ {
					type : 'category',
					boundaryGap : false,
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
			                  name:'正常响应笔数',
			                  type:'bar',
			                  itemStyle: {normal: {color:'rgba(181,195,52,1)', label:{show:true,textStyle:{color:'#27727B'}}}},
			                  data:nomalRespArr
			              },

			              {
			                  name:'总请求笔数',
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

		);
	</script>





</body>
</html>