package com.springmvc_mybatis.service;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springmvc_mybatis.bean.AlarmInfo;
import com.springmvc_mybatis.bean.Banksla;
import com.springmvc_mybatis.bean.PageShowConfig;
import com.springmvc_mybatis.mailsend.MailUtil;
import com.springmvc_mybatis.mapper.AlarmInfoMapper;
import com.springmvc_mybatis.mapper.BankslaMapper;
import com.springmvc_mybatis.mapper.ConfigMapper;
import com.springmvc_mybatis.mapper.PageShowConfigMapper;
import com.springmvc_mybatis.tools.CheckException;
import com.springmvc_mybatis.tools.EmptyUtil;
import com.springmvc_mybatis.tools.GlobalVariable;

@Service("bankslaService")
public class BankslaService {

    private final Log logger = LogFactory.getLog(BankslaService.class);

    @Autowired
    private BankslaMapper bankslamapper;

    @Autowired
    private ConfigMapper configrmapper;

    @Autowired
    private AlarmInfoMapper alarmInfoMapper;

    @Autowired
    private PageShowConfigMapper pageShowConfigMapper;

    /**
     * 获取所有banksla
     * 
     * @author xuqq 2016年3月16日 上午9:31:11
     * 
     * @param request
     * @param response
     * @param model
     */
    public void getAllbanksla(HttpServletRequest request,
            HttpServletResponse response) {
        List<Banksla> array = bankslamapper.getAllbankslas();
        Date lastTime = GlobalVariable.G_LAST_TIME_AVAILABLE_RATIO;
        if (EmptyUtil.isNotEmpty(lastTime)) {
            long diff = new Date().getTime() - lastTime.getTime();
            if (diff / (5 * 1000 * 60) >= 1) {
                GlobalVariable.G_LAST_TIME_AVAILABLE_RATIO = new Date();
                checkThresholdAndMail(array);
            }
        } else {
            checkThresholdAndMail(array);
            GlobalVariable.G_LAST_TIME_AVAILABLE_RATIO = new Date();

        }
        response.setContentType("text/html; charset=utf-8");
        JSONArray json = JSONArray.fromObject(array);

        PrintWriter out;
        try {

            out = response.getWriter();
            out.println(json);
            out.flush();
            out.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    /**
     * 分页获取sla数据
     * 
     * @author xuqq 2016年3月16日 上午9:06:21
     * 
     * @param request
     * @param response
     * @param model
     * @throws CheckException
     */
    public void getBankslaPage(HttpServletRequest request,
            HttpServletResponse response, Model model) {
        try {
            // 获取当前页数和每页显示条数
            int curPage = Integer.parseInt(request.getParameter("curPage"));

            PageShowConfig pageShowConfig = new PageShowConfig();
            pageShowConfig.setPageName("show_sla_page");
            pageShowConfig = pageShowConfigMapper
                    .findPageShowConfig(pageShowConfig);
            if (EmptyUtil.isEmpty(pageShowConfig.getPerChartNumber())
                    || EmptyUtil.isEmpty(pageShowConfig.getPerPageNumber())) {
                throw new CheckException("请配置该页面显示信息！");
            }
            int pageSize = pageShowConfig.getPerChartNumber()
                    * pageShowConfig.getPerPageNumber();

            // 计算查询起始位置
            int start = (curPage - 1) * pageSize;
            List<Banksla> array = bankslamapper.getBankslaPage(start, pageSize);

            // 计算总条数和总页数
            int count = configrmapper.getAllConfigCount();
            int countPage = (int) Math.ceil((double) count / (double) pageSize);
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("bankslaPage", array);
            map.put("curPage", curPage);
            map.put("countPage", countPage);
            map.put("perChartNumber", pageShowConfig.getPerChartNumber());
            map.put("perPageNumber", pageShowConfig.getPerPageNumber());
            response.setContentType("text/html; charset=utf-8");
            JSONObject json = JSONObject.fromObject(map);
            PrintWriter out;
            out = response.getWriter();
            out.println(json);
            out.flush();
            out.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (CheckException e) {
            // TODO: handle exception
            e.printStackTrace();
        }
    }

    /**
     * 检验专线可用率是否低于阀值并发告警邮件
     * 
     * @author xuqq 2016年3月16日 上午10:55:24
     * 
     * @param array
     */
    public void checkThresholdAndMail(List<Banksla> array) {

        Map<String, List<Banksla>> bankInfo = new HashMap<String, List<Banksla>>();
        for (int i = 0; i < array.size(); i++) {
            if (Integer.parseInt(array.get(i).getAvailable_ratio()) < Integer
                    .parseInt(array.get(i).getAvailable_ratio_threshold())
                    && array.get(i).getIsSendAlarmMail() == 1
                    && array.get(i).getTotal_req() >= array.get(i).getRequest()) {
                if (bankInfo.containsKey(array.get(i).getBank_name())) {
                    bankInfo.get(array.get(i).getBank_name()).add(array.get(i));
                } else {
                    List<Banksla> list = new ArrayList<Banksla>();
                    list.add(array.get(i));
                    bankInfo.put(array.get(i).getBank_name(), list);
                }
            }
        }
        for (String key : bankInfo.keySet()) {
            if (bankInfo.get(key).size() >= bankInfo.get(key).get(0)
                    .getNumber()) {
                String mailto = bankInfo.get(key).get(0).getMail_to();
                String content = "";
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                content += "告警时间："
                        + sdf.format(new Date())
                        + " "
                        + bankInfo.get(key).get(bankInfo.get(key).size() - 1)
                                .getTime() + "<br>";
                content += "告警描述："
                        + key
                        + "可用率"
                        + bankInfo.get(key).get(bankInfo.get(key).size() - 1)
                                .getAvailable_ratio() + "%<br>";
                content += "告警条件："
                        + "可用率<"
                        + bankInfo.get(key).get(0)
                                .getAvailable_ratio_threshold() + "%,请求数>="
                        + bankInfo.get(key).get(0).getRequest() + "连续"
                        + bankInfo.get(key).get(0).getNumber() + "次满足要求。<br>";
                content += "解决方案：" + bankInfo.get(key).get(0).getSolution();
                MailUtil mailUtil = new MailUtil("sh-nlb-mhc.99bill.com",
                        "monitor_op@99bill.com", "monitor_op@99bill.com",
                        "monitor_op@99bill.com", "1qaz@WSX");
                if (EmptyUtil.isNotEmpty(mailto)) {
                    try {
                        AlarmInfo alarmInfo = new AlarmInfo();
                        alarmInfo.setContent(content);
                        alarmInfoMapper.addAlarmInfo(alarmInfo);
                        String[] tos = mailto.split(";");
                        String subject = "运维监控系统告警【重要】：15分钟内" + key
                                + "可用率   告警ID：" + alarmInfo.getAlarmInfoId();
                        mailUtil.send(tos, true, subject, content, true, null);
                    } catch (UnsupportedEncodingException e) {
                        // TODO Auto-generated catch block
                        logger.error(e);
                    } catch (MessagingException e) {
                        // TODO Auto-generated catch block
                        logger.error(e);
                    } catch (Exception e) {
                        // TODO Auto-generated catch block
                        logger.error(e);
                    }
                }
            }
        }

    }
}
