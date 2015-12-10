package com.springmvc_mybatis.bean;

import java.util.HashMap;
import java.util.Map;

public class AutoLoadCfg {
	
	
	//配置内容 随便什么对象都可以
	private Map<String,String> map = new HashMap<String,String>();
	
	//初始化
	public void init(){
		
		map.put("cfg", "cfg-value");
		System.out.println("*********装载所需要的配置！");
		
		
	}
	
	public String getValue(String key){
		return map.get(key);
	}

}
