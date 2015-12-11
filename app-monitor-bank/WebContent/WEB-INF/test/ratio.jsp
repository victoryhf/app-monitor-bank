<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script src="WEB-INF/JS/jquery-1.7.1.js"></script>

</head>
<body >


    
    <div id="main" style="height:400px"></div>
    <script src="http://echarts.baidu.com/build/dist/echarts.js"></script>
    
    <script type="text/javascript">
    
        require.config({
            paths: {
                echarts: 'http://echarts.baidu.com/build/dist'
            }
        });
        
        require(
            [
                'echarts',
                'echarts/chart/line' // 使用柱状图就加载bar模块，按需加载
            ],
        
        function (ec){
            
            var chart = document.getElementById('main');	
            var echart = ec.init(chart);
            
            echart.showLoading({
            	
            	text: '正在努力加载中...'
            	
            });  
            
            var categories = [];  
            var values = [];
            
            $.ajaxSettings.async = false;
            
            $.getJSON('<%=path%>/banksla/ratiolist.action', function (json) {
            	alert("加载");
            	categories = json.categories;
            	values = json.values;
            	
            });
            
            var option={
            		
            		tooltip:{
            			show:true
            		},
            
                    legend:{
                    	data: ['销量']
                    },
                    
                    xAxis:[
                        {
                           type: 'category',
                           data: categories
                        }        
                    ],
                    
                    yAxis:[
                           {
                              type: 'value',
                           }        
                       ],
            		
                    series:[
                           {
                        	   'name': '销量',
                        	   'type': 'line',
                        	   'data': values
                           }        
                       ]
            };
            
            echart.setOption(option);  
            echart.hideLoading();
            	
            }    
            
   
        );
    </script>


</body>
</html>