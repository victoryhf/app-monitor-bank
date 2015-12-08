package com.springmvc_mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc_mybatis.bean.Config;
import com.springmvc_mybatis.bean.User;


public interface ConfigMapper {

	/**author：皇甫立胜
	   data：2015-12-4
	         作用：ConfigMapper映射类，映射到configMapper.xml执行对应sql
	 */
	 List<Config> getAllConfigs();
	 
	 int addConfig(@Param(value = "bankid") String bankid,
				@Param(value = "bankname") String bankname,
				@Param(value = "sla_threshold") String sla_threshold,
				@Param(value = "available_ratio_threshold") String available_ratio_threshold,
				@Param(value = "max_beyond_time") String max_beyond_time,
				@Param(value = "rstatus") Integer rstatus,
				@Param(value = "mail_to") String mail_to);
	 
	 
	 Config getConfigByid(@Param(value = "id") int id);
	 
	 
	 int updateConfigByid(@Param(value = "id") String id,
			    @Param(value = "bankid") String bankid,
				@Param(value = "bankname") String bankname,
				@Param(value = "sla_threshold") String sla_threshold,
				@Param(value = "available_ratio_threshold") String available_ratio_threshold,
				@Param(value = "max_beyond_time") String max_beyond_time,
				@Param(value = "rstatus") Integer rstatus,
				@Param(value = "mail_to") String mail_to);
	 
	
	 
}





