package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class Banksla implements Serializable{
	/**author：龚壮壮
	 * data：2015-12-11
	 * 作用：配置表实体bean
	 */
	private int id;
	private String bankid;
	private String time;
	private int nomal_resp;
	private int total_req;
	private String average_sla;
	private String available_ratio;
	
	public Banksla() {
		super();
	}
	
	public Banksla(int id) {
        super();
        this.id = id;
    }
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBankid() {
		return bankid;
	}
	public void setBankid(String bankid) {
		this.bankid = bankid;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getNomal_resp() {
		return nomal_resp;
	}
	public void setNomal_resp(int nomal_resp) {
		this.nomal_resp = nomal_resp;
	}
	public int getTotal_req() {
		return total_req;
	}
	public void setTotal_req(int total_req) {
		this.total_req = total_req;
	}
	public String getAverage_sla() {
		return average_sla;
	}
	public void setAverage_sla(String average_sla) {
		this.average_sla = average_sla;
	}
	public String getAvailable_ratio() {
		return available_ratio;
	}
	public void setAvailable_ratio(String available_ratio) {
		this.available_ratio = available_ratio;
	}
	

}
