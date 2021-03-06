package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class Banksla implements Serializable {
    private static final long serialVersionUID = 8380092438180952286L;
    /**
     * author：龚壮壮 data：2015-12-11 作用：配置表实体bean
     */
    private int id;
    private String bankid;
    private String time;
    private int nomal_resp;
    private int total_req;
    private String average_sla;
    private String available_ratio;

    private String bank_name;
    private String available_ratio_threshold;

    private String sla_threshold;

    private String mail_to;

    private int isSendAlarmMail;

    private int number;

    private int request;

    private String solution;

    public String getSla_threshold() {
        return sla_threshold;
    }

    public void setSla_threshold(String sla_threshold) {
        this.sla_threshold = sla_threshold;
    }

    public String getBank_name() {
        return bank_name;
    }

    public void setBank_name(String bank_name) {
        this.bank_name = bank_name;
    }

    public String getAvailable_ratio_threshold() {
        return available_ratio_threshold;
    }

    public void setAvailable_ratio_threshold(String available_ratio_threshold) {
        this.available_ratio_threshold = available_ratio_threshold;
    }

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

    public String getMail_to() {
        return mail_to;
    }

    public void setMail_to(String mail_to) {
        this.mail_to = mail_to;
    }

    public int getIsSendAlarmMail() {
        return isSendAlarmMail;
    }

    public void setIsSendAlarmMail(int isSendAlarmMail) {
        this.isSendAlarmMail = isSendAlarmMail;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getRequest() {
        return request;
    }

    public void setRequest(int request) {
        this.request = request;
    }

    public String getSolution() {
        return solution;
    }

    public void setSolution(String solution) {
        this.solution = solution;
    }

}
