package com.springmvc_mybatis.controller;

import java.util.List;

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
	
	@RequestMapping("/configlist")
	public String getAllConfigs(Model model) {
		List<Config> configs = configrmapper.getAllConfigs();
		model.addAttribute("configs", configs);
		System.out.println(configs);
		return "configlist";

	}
	
}

