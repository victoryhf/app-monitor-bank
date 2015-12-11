package com.springmvc_mybatis.mapper;

import java.util.List;

import com.springmvc_mybatis.bean.Banksla;


public interface BankslaMapper {
	/**author：龚壮壮
	   data：2015-12-11
	         作用：BankslaMapper映射类，映射到BankslaMapper.xml执行对应sql
	 */
	
	List<Banksla> getAllbanksla();
 

}
