package com.springmvc_mybatis.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import com.springmvc_mybatis.mapper.ConfigMapper;


public class AutoLoadCfg {
	
	@Autowired
	private ConfigMapper configmapper;
	
	//private Config config;
	//配置内容 随便什么对象都可以
	private Map<String,Object> map = new HashMap<String,Object>();
	
	//初始化
	public void init(){
		
		//map.put("cfg", "cfg-value");
	    List<Config> configs = configmapper.getAllConfigs();
	    
	    //循环配置信息，把map,key=bankid,value=config
	    for (Config config : configs) {
            System.out.println(config.getBankid());
            map.put(config.getBankid(),config);
        }
	    
	    System.out.println("*********装载所需要的配置！");
		
	}
	
	public Object getValue(String key){
		return map.get(key);
	}

}
