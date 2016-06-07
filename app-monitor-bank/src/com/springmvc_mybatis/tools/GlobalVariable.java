package com.springmvc_mybatis.tools;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class GlobalVariable {
	
	//上一次计算专线可用率是否低于阀值的时间
	public static Date G_LAST_TIME_AVAILABLE_RATIO = null;
	//自定义session
	public static Map<String, Object> sessionMap = new HashMap<String, Object>();
}
