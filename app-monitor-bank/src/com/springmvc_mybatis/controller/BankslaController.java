package com.springmvc_mybatis.controller;


import java.io.IOException;
import java.io.PrintWriter;

import java.util.List;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.springmvc_mybatis.bean.Banksla;
import com.springmvc_mybatis.mapper.BankslaMapper;



@Controller
@RequestMapping("/banksla")
public class BankslaController {
	/**author：龚壮壮
	 * data：2015-12-11
	 * 作用：ConfigController,初始化获取banksla数据
	 */	
	
	@Autowired
	private BankslaMapper bankslamapper;
	
	@RequestMapping("/ratiolist")
	public String selebanksla(HttpServletRequest request,HttpServletResponse response, Model model){
		
		List<Banksla> array = bankslamapper.getAllbanksla();
		response.setContentType("text/html; charset=utf-8");
		JSONArray json=JSONArray.fromObject(array);
		System.out.println(json.toString());
		
		
        PrintWriter out;
		try {
			out = response.getWriter();
			out.println(json);  
	        out.flush();  
	        out.close(); 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	    
		return "ratio";
		
	}

}
	
