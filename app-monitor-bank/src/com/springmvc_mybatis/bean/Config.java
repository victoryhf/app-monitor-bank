package com.springmvc_mybatis.bean;

import java.io.Serializable;
import java.util.Date;



public class Config  implements Serializable{
	/**author：皇甫立胜
	 * data：2015-12-4
	 * 作用：配置表实体bean
	 */
	private static final long serialVersionUID = 1L;
	private int id;
	private String  bankid;
	private String bankname;
	private String sla_threshold;
	private String available_ratio_threshold;
	private String max_beyond_time;
	private Integer rstatus;
	private String mail_to;
	
	public Config() {
		super();
	}

	public Config(String bankid, 
			      String bankname,
			      String sla_threshold,
			      String available_ratio_threshold,
			      String max_beyond_time,
			      Integer rstatus,
			      String mail_to) {
		super();
		this.bankid = bankid;
		this.bankname = bankname;
		this.sla_threshold = sla_threshold;
		this.available_ratio_threshold = available_ratio_threshold;
		this.max_beyond_time = max_beyond_time;
		this.rstatus = rstatus;
		this.mail_to = mail_to;
	}
	
	public Config(int id,
			      String bankid, 
		          String bankname,
		          String sla_threshold,
		          String available_ratio_threshold,
		          String max_beyond_time,
		          Integer rstatus,
		          String mail_to) {
	super();
	this.id = id;
	this.bankid = bankid;
	this.bankname = bankname;
	this.sla_threshold = sla_threshold;
	this.available_ratio_threshold = available_ratio_threshold;
	this.max_beyond_time = max_beyond_time;
	this.rstatus = rstatus;
	this.mail_to = mail_to;
	
	}

	
	
	public String getMail_to() {
		return mail_to;
	}

	public void setMail_to(String mail_to) {
		this.mail_to = mail_to;
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

	public String getBankname() {
		return bankname;
	}

	public void setBankname(String bankname) {
		this.bankname = bankname;
	}

	public String getSla_threshold() {
		return sla_threshold;
	}

	public void setSla_threshold(String sla_threshold) {
		this.sla_threshold = sla_threshold;
	}

	public String getAvailable_ratio_threshold() {
		return available_ratio_threshold;
	}

	public void setAvailable_ratio_threshold(String available_ratio_threshold) {
		this.available_ratio_threshold = available_ratio_threshold;
	}

	public String getMax_beyond_time() {
		return max_beyond_time;
	}

	public void setMax_beyond_time(String max_beyond_time) {
		this.max_beyond_time = max_beyond_time;
	}

	public Integer getRstatus() {
		return rstatus;
	}

	public void setRstatus(Integer rstatus) {
		this.rstatus = rstatus;
	}
	
	@Override
	public String toString() {
		return "Config [id=" + id + ", bankid=" + bankid + ", bankname=" + bankname
				+ ", sla_threshold=" + sla_threshold +", available_ratio_threshold=" + available_ratio_threshold 
				+ ", max_beyond_time=" + max_beyond_time +", rstatus=" + rstatus+", mail_to=" + mail_to+"]";
	}

	/*public User() {
		super();
	}

	public User(String name, String password) {
		super();
		this.name = name;
		this.password = password;
	}

	public User(Integer id, String name, String password, Date time) {
		super();
		this.id = id;
		this.name = name;
		this.password = password;
		this.time = time;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}*/




}
