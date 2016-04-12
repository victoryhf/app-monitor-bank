package com.springmvc_mybatis.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import com.springmvc_mybatis.bean.Config;
import com.springmvc_mybatis.mapper.ConfigMapper;


@Controller
@RequestMapping("/config")
public class ConfigController {
	/**author：皇甫立胜
	 * data：2015-12-4
	 * 作用：ConfigController,前端业务处理器，接收页面请求，并传给后端处理
	 */
	
	@Autowired
	private ConfigMapper configrmapper;
	
	//查询所有配置信息
	@RequestMapping("/configlist")
	public String getAllConfigs(Model model) {
		List<Config> configs = configrmapper.getAllConfigs();
		model.addAttribute("configs", configs);
		return "configlist";

	}
	
	//新增配置信息
	@RequestMapping("/addconfig")
	public String addConfig(HttpServletRequest request, Model model,Config config) {
		int config_add = configrmapper.addConfig(config);
		
		if (config_add != 1) {
			//System.out.println("Error insert!");
			return "addconfigfail";
		} else {
			//return "redirect:configlist.action";
			return "redirect:https://sars.99bill.net/sor/app-monitor-bank/config/configlist.action";
		}
		
	}
	
	
	
	//通过id查询一条配置信息
	@RequestMapping("/queryConfigByid")
	public String queryConfigByid(HttpServletRequest request, Model model) {
		int id =  Integer.parseInt(request.getParameter("id"));		
		Config config_one = configrmapper.getConfigByid(id);
		model.addAttribute("config", config_one);	
		return "modifyconfig";
		
	}
	

	
    //更新配置信息
    @RequestMapping("/updateConfigByid")
	public String updateConfigByid(Config config) {
		configrmapper.updateConfigByid(config);
		//return "redirect:configlist.action";
		return "redirect:https://sars.99bill.net/sor/app-monitor-bank/config/configlist.action";
	}
    
   
    
    //删除一条配置信息
    @RequestMapping("/deleteConfigByid")
	public String delConfig(Config config) {
		configrmapper.deleteConfig(config);
		//System.out.println(config);
		//return "redirect:configlist.action";
		return "redirect:https://sars.99bill.net/sor/app-monitor-bank/config/configlist.action";
	}
    


	
  /*  @RequestMapping("/updateConfigByid")
	public String updateConfigByid(HttpServletRequest request, Model model) {
		String id = request.getParameter("id");
		String bankid = request.getParameter("bankid");
		String bankname = request.getParameter("bankname");
		String sla_threshold = request.getParameter("sla_threshold");
		String available_ratio_threshold = request.getParameter("available_ratio_threshold");
		String max_beyond_time = request.getParameter("max_beyond_time");
		Integer rstatus = Integer.valueOf(request.getParameter("rstatus"));
		String mail_to = request.getParameter("mail_to");
		
		int updatestatus = configrmapper.updateConfigByid(id, bankid, bankname,sla_threshold,available_ratio_threshold,
				max_beyond_time,rstatus,mail_to);
		
		if (updatestatus == 1) {
			return "redirect:/config/configlist.action";
		}
		return null;
	}*/
	
	 
}

