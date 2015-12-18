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
			        orient: 'vertical',      // 布局方式，默认为水平布局，可选为：
			                                   // 'horizontal' ¦ 'vertical'
			        x: 'right',               // 水平安放位置，默认为全图居中，可选为：
			                                   // 'center' ¦ 'left' ¦ 'right'
			                                   // ¦ {number}（x坐标，单位px）
			        y: 'top',                  // 垂直安放位置，默认为全图顶端，可选为：
			                                   // 'top' ¦ 'bottom' ¦ 'center'
			                                   // ¦ {number}（y坐标，单位px）
			        backgroundColor: 'rgba(0,0,0,0)',
			        borderColor: '#ccc',       // 图例边框颜色
			        borderWidth: 0,            // 图例边框线宽，单位px，默认为0（无边框）
			        padding: 5,                // 图例内边距，单位px，默认各方向内边距为5，
			                                   // 接受数组分别设定上右下左边距，同css
			        itemGap: 5,               // 各个item之间的间隔，单位px，默认为10，
			                                   // 横向布局时为水平间隔，纵向布局时为纵向间隔
			        itemWidth: 15,             // 图例图形宽度
			        itemHeight: 10.5,            // 图例图形高度
			        textStyle: {
			        	fontSize: 5,
			            color: '#333'          // 图例文字颜色
			        },
			        data:[
			            '正常响应',
			            '总请求'
			        ]
			    },
			    
			    
				tooltip : {
					trigger: 'axis',
					//show:false
				},
				
				calculable : true,
				
				grid:{
					x:35,
					y:35,
					height:'71%', 
					width:'84%'
					
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
			                  name:'正常响应',
			                  type:'bar',
			                  itemStyle: {normal: {color:'rgba(181,195,52,1)', label:{show:true,textStyle:{color:'#27727B'}}}},
			                  data:nomalRespArr
			              },

			              {
			                  name:'总请求',
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