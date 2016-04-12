package com.springmvc_mybatis.controller;


import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springmvc_mybatis.bean.PageShowConfig;
import com.springmvc_mybatis.service.PageShowConfigService;
import com.springmvc_mybatis.tools.ResponseJsonResult;

@Controller
@RequestMapping("/pageShowConfig")
public class PageShowConfigController {
	
	@Autowired
	@Qualifier("pageShowConfigService")
	private PageShowConfigService pageShowConfigService;
	
	@RequestMapping("/pageShowConfigList")
	public String pageShowConfigList(Model model) {
		try {
			List<PageShowConfig> pageShowConfigList = pageShowConfigService.pageShowConfigList();
			model.addAttribute("success",1);
			model.addAttribute("pageShowConfigList", pageShowConfigList);
		} catch (Exception e) {
			// TODO: handle exception
			model.addAttribute("success",0);
			model.addAttribute("msg","数据加载失败");
			e.printStackTrace();
		}
		return "pageShowConfiglist";
	}
	
	@RequestMapping("/addPageShowConfig")
	public void addPageShowConfig(HttpServletResponse response,PageShowConfig pageShowConfig) {
		try {
			pageShowConfigService.addPageShowConfig(pageShowConfig);
			new ResponseJsonResult(1,"添加成功",null,response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			new ResponseJsonResult(0,"添加失败",null,response);
		}
	}
	
	@RequestMapping("/findPageShowConfigById")
	public void findPageShowConfigById(HttpServletResponse response,PageShowConfig pageShowConfig) {
		try {
			pageShowConfig = pageShowConfigService.findPageShowConfigById(pageShowConfig);
			new ResponseJsonResult(1,"",pageShowConfig,response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			new ResponseJsonResult(0,"获取失败",null,response);
		}
	}
	
	@RequestMapping("/modifyPageShowConfig")
	public void modifyPageShowConfig(HttpServletResponse response,PageShowConfig pageShowConfig) {
		try {
			pageShowConfigService.modifyPageShowConfig(pageShowConfig);
			new ResponseJsonResult(1,"修改成功",null,response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			new ResponseJsonResult(0,"修改失败",null,response);
		}
	}
	
	
	@RequestMapping("/deletePageShowConfig")
	public void deletePageShowConfig(HttpServletResponse response,PageShowConfig pageShowConfig) {
		try {
			pageShowConfigService.deletePageShowConfig(pageShowConfig);
			new ResponseJsonResult(1,"删除成功",null,response);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			new ResponseJsonResult(0,"删除失败",null,response);
		}
	}
}
	
