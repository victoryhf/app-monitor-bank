package com.springmvc_mybatis.controller;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;






import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;





import com.springmvc_mybatis.bean.Banksla;
import com.springmvc_mybatis.bean.Config;
import com.springmvc_mybatis.mapper.BankslaMapper;
import com.springmvc_mybatis.mapper.ConfigMapper;



@Controller
@RequestMapping("/banksla")
public class BankslaController {
	/**author：龚壮壮
	 * data：2015-12-11
	 * 作用：ConfigController,初始化获取banksla数据
	 */	
	
	@Autowired
	private BankslaMapper bankslamapper;
	
	@Autowired
	private ConfigMapper configrmapper;
	
	
	
	@RequestMapping("/selectconfig")
	public String seleconfig(HttpServletRequest request,HttpServletResponse response, Model model,Banksla banksla) {
	
		List<Config> list=configrmapper.gettbankid();
		response.setContentType("text/html; charset=utf-8");
		JSONArray json=JSONArray.fromObject(list);
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
		
		return "showsla";
		
	}
	
	
	@RequestMapping("/ratiolist")
	public String selebanksla(HttpServletRequest request,HttpServletResponse response, Model model){
		
		String bankid=request.getParameter("bankid");
		
		List<Banksla> array = bankslamapper.getAllbanksla(bankid);
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
	
	@RequestMapping("/queryRatioListBybid")
	public String queryRatioList(HttpServletRequest request,HttpServletResponse response, Model model,Banksla banksla) {
		List<Banksla> array = bankslamapper.getbankslaBybid(banksla);
		//System.out.println(banksla.getBankid()+"aaaaaaa");
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
	
