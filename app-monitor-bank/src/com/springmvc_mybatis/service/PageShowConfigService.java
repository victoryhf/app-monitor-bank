package com.springmvc_mybatis.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springmvc_mybatis.bean.PageShowConfig;
import com.springmvc_mybatis.mapper.PageShowConfigMapper;

@Service("pageShowConfigService")
public class PageShowConfigService {
	
	@Autowired
	private PageShowConfigMapper pageShowConfigMapper;
	
	/**
	 * 获取页面配置信息列表
	 * @author xuqq   2016年4月11日    下午3:55:00
	 *
	 * @return
	 */
	public List<PageShowConfig> pageShowConfigList(){
		List<PageShowConfig> pageShowConfigs = pageShowConfigMapper.findAllPageShowConfigs();
		return pageShowConfigs;
	}
	
	/**
	 * 添加页面配置信息
	 * @author xuqq   2016年4月11日    下午4:36:50
	 *
	 * @param pageShowConfig
	 */
	public void addPageShowConfig(PageShowConfig pageShowConfig){
		pageShowConfigMapper.addPageShowConfig(pageShowConfig);
	}
	
	/**
	 * 根据id获取页面显示配置信息
	 * @author xuqq   2016年4月12日    上午10:05:04
	 *
	 * @param pageShowConfig
	 * @return
	 */
	public PageShowConfig findPageShowConfigById(PageShowConfig pageShowConfig){
		return pageShowConfigMapper.findPageShowConfig(pageShowConfig);
	}
	
	/**
	 * 修改配置信息
	 * @author xuqq   2016年4月12日    上午10:32:18
	 *
	 * @param pageShowConfig
	 */
	public void modifyPageShowConfig(PageShowConfig pageShowConfig){
		pageShowConfigMapper.updatePageShowConfig(pageShowConfig);
	}
	
	/**
	 * 删除信息
	 * @author xuqq   2016年4月12日    上午11:21:02
	 *
	 * @param pageShowConfig
	 */
	public void deletePageShowConfig(PageShowConfig pageShowConfig){
		pageShowConfigMapper.deletePageShowConfig(pageShowConfig);
	}
}
