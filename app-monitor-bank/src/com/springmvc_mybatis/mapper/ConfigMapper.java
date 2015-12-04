package com.springmvc_mybatis.mapper;

import java.util.List;
import com.springmvc_mybatis.bean.Config;


public interface ConfigMapper {

	/**author：皇甫立胜
	   data：2015-12-4
	         作用：ConfigMapper映射类，映射到configMapper.xml执行对应sql
	 */
	 List<Config> getAllConfigs();
}
