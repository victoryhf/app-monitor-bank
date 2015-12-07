package com.springmvc_mybatis.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.Config;
import com.springmvc_mybatis.bean.User;
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
	
	@RequestMapping("/configlist")
	public String getAllConfigs(Model model) {
		List<Config> configs = configrmapper.getAllConfigs();
		model.addAttribute("configs", configs);
		System.out.println(configs);
		return "configlist";

	}
	
	@RequestMapping("/addconfig")
	public String addconfig(HttpServletRequest request, Model model) {
		String bankid = request.getParameter("bankid");
		String bankname = request.getParameter("bankname");
		String sla_threshold = request.getParameter("sla_threshold");
		String available_ratio_threshold = request.getParameter("available_ratio_threshold");
		String max_beyond_time = request.getParameter("max_beyond_time");
		Integer rstatus = Integer.valueOf(request.getParameter("rstatus"));
		String mail_to = request.getParameter("mail_to");
		int config_add = configrmapper.addConfig(bankid, bankname,sla_threshold,available_ratio_threshold,
				max_beyond_time,rstatus,mail_to);
		
		if (config_add != 1) {
			System.out.println("Error insert!");
			return "fail";
		} else {
			model.addAttribute("config", config_add);
			return "redirect:/config/configlist.action";
		}
		
	}
	
	
}

