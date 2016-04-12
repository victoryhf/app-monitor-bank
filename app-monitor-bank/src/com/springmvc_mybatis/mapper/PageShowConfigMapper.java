package com.springmvc_mybatis.mapper;

import java.util.List;

import com.springmvc_mybatis.bean.PageShowConfig;

public interface PageShowConfigMapper {
	
	List<PageShowConfig> findPageShowConfigs(PageShowConfig pageShowConfig);
	
	PageShowConfig findPageShowConfig(PageShowConfig pageShowConfig);
	
	List<PageShowConfig> findAllPageShowConfigs();
	
	int addPageShowConfig(PageShowConfig pageShowConfig);
	
	int updatePageShowConfig(PageShowConfig pageShowConfig);
	
	int deletePageShowConfig(PageShowConfig pageShowConfig);
}
