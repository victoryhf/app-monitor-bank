package com.springmvc_mybatis.tools;

import java.util.Date;

public class EmptyUtil {
	
	public static boolean isEmpty(String value){
		return value == null || value.length() == 0;
	}
	
	public static boolean isNotEmpty(String value){
		return !(value == null || value.length() == 0);
	}
	
	public static boolean isEmpty(Date value){
		return value == null;
	}
	
	public static boolean isNotEmpty(Date value){
		return !(value == null);
	}
	
	public static boolean isNotEmpty(Object value){
		return !(value == null);
	}
	
	public static boolean isEmpty(Object value){
		return value == null;
	}
}
