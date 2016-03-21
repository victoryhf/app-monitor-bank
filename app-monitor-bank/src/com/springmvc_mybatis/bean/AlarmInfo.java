package com.springmvc_mybatis.bean;

public class AlarmInfo {
	
	private int alarmInfoId;
	
	//存放告警信息内容
	private String content;

	public int getAlarmInfoId() {
		return alarmInfoId;
	}

	public void setAlarmInfoId(int alarmInfoId) {
		this.alarmInfoId = alarmInfoId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	
}
