package com.springmvc_mybatis.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.Banksla;
import com.springmvc_mybatis.bean.Config;
import com.springmvc_mybatis.bean.User;
import com.springmvc_mybatis.mapper.BankslaMapper;
import com.sun.xml.internal.ws.util.JAXWSUtils;


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
		
		List<Banksla> sla = bankslamapper.getAllbanksla();
		String[] categories = {"鞋", "衬衫", "外套", "牛仔裤"};  
		Integer[] values = {80, 50, 75, 100};  
		 
		Map<String, Object> jsonArray = new HashMap<String, Object>();  
		jsonArray.put("categories", categories);  
		jsonArray.put("values", values);  
		net.sf.json.JSONArray json = net.sf.json.JSONArray.fromObject(jsonArray);
         try {
			response.getWriter().print(json);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      
	       System.out.println("方法");

	 
		return "ratio";
	}

}
	
