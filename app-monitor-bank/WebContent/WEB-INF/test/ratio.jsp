<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>


 <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="main" style="height:400px"></div>
    <!-- ECharts单文件引入 -->
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    <script type="text/javascript">
        // 路径配置
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        // 使用
        require(
            [
                'echarts',
                'echarts/chart/line' // 使用柱状图就加载bar模块，按需加载
            ],
            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main')); 
                
                var option = {
                    tooltip: {
                        show: true
                    },
                    legend: {
                        data:['销量']
                    },
                    xAxis : [
                        {
                            type : 'category',
                            data : ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
                        }
                    ],
                    yAxis : [
                        {
                            type : 'value'
                        }
                    ],
                    series : [
                              {
                                  name:'最高气温',
                                  type:'line',
                                  data:[11, 11, 15, 13, 12, 13, 10],
                                  markPoint : {
                                      data : [
                                          {type : 'max', name: '最大值'},
                                          {type : 'min', name: '最小值'}
                                      ]
                                  },
                                  markLine : {
                                      data : [
                                          {type : 'average', name: '平均值'}
                                      ]
                                  }
                              },
                              {
                                  name:'最低气温',
                                  type:'line',
                                  data:[1, -2, 2, 5, 3, 2, 0],
                                  markPoint : {
                                      data : [
                                          {name : '周最低', value : -2, xAxis: 1, yAxis: -1.5}
                                      ]
                                  },
                                  markLine : {
                                      data : [
                                          {type : 'average', name : '平均值'}
                                      ]
                                  }
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