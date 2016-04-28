package com.springmvc_mybatis.tools;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

public class ResponseJsonResult {
	
	//是否成功
	private int success;
	//消息
	private String msg;
	//返回数据
	private Object obj;
	
	public ResponseJsonResult() {
	}
	
	public ResponseJsonResult(int success) {
		this.success = success;
	}
	
	public ResponseJsonResult(int success, String msg) {
		this.success = success;
		this.msg = msg;
	}
	
	public ResponseJsonResult(int success, String msg, Object obj) {
		this.success = success;
		this.msg = msg;
		this.obj = obj;
	}
	
	
	public ResponseJsonResult(int success, String msg, Object obj,HttpServletResponse responsep) {
		this.success = success;
		this.msg = msg;
		this.obj = obj;
		returnResponse(responsep);
	}
	
	public int getSuccess() {
		return success;
	}

	public void setSuccess(int success) {
		this.success = success;
	}

	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public Object getObj() {
		return obj;
	}
	public void setObj(Object obj) {
		this.obj = obj;
	}
	
	//在response中写入json
	public void returnResponse(HttpServletResponse response){
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("success", getSuccess());
			map.put("msg", getMsg());
			map.put("obj", getObj());
			response.setContentType("text/html; charset=utf-8");
			JSONObject json = JSONObject.fromObject(map);
			PrintWriter out;
			out = response.getWriter();
	        out.println(json);  
	        out.flush();  
	        out.close();  
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
}
