package com.springmvc_mybatis.bean;

public class PageShowConfig {
	private Integer pageConfigId;
	//每页显示多少张图
	private Integer perPageNumber;
	//每张图显示条数
	private Integer perChartNumber;
	//网页名
	private String pageName;
	public Integer getPageConfigId() {
		return pageConfigId;
	}
	public void setPageConfigId(Integer pageConfigId) {
		this.pageConfigId = pageConfigId;
	}
	public Integer getPerPageNumber() {
		return perPageNumber;
	}
	public void setPerPageNumber(Integer perPageNumber) {
		this.perPageNumber = perPageNumber;
	}
	public Integer getPerChartNumber() {
		return perChartNumber;
	}
	public void setPerChartNumber(Integer perChartNumber) {
		this.perChartNumber = perChartNumber;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	
	
}
