package com.springmvc_mybatis.mailsend;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;


public class MailUtil {

	   // ���巢���˱���
	   private String displayName;

	   //�ʼ�������
	   private String from;

	   //�ʼ�������
	   private String smtpServer;

	   //�û���
	   private String username;

	   //����
	   private String password;

	   //�ַ���
	   private String charset = "utf-8";

	   /**
	    * ��ʼ��SMTP��������ַ
	    * @param smtpServer  ��������ַ
	    * @param from ������
	    * @param displayName ����
	    * @param username �û���
	    * @param password ����
	    */
	   public MailUtil(String smtpServer, String from, String displayName,
	           String username, String password) {
	       this.smtpServer = smtpServer;
	       this.from = from;
	       this.displayName = displayName;
	       this.username = username;
	       this.password = password;
	   }
	    
	    

	   public String getDisplayName() {
	       return displayName;
	   }



	   public void setDisplayName(String displayName) {
	       this.displayName = displayName;
	   }



	   public String getFrom() {
	       return from;
	   }



	   public void setFrom(String from) {
	       this.from = from;
	   }



	   public String getSmtpServer() {
	       return smtpServer;
	   }



	   public void setSmtpServer(String smtpServer) {
	       this.smtpServer = smtpServer;
	   }



	   public String getUsername() {
	       return username;
	   }



	   public void setUsername(String username) {
	       this.username = username;
	   }



	   public String getPassword() {
	       return password;
	   }



	   public void setPassword(String password) {
	       this.password = password;
	   }



	   public String getCharset() {
	       return charset;
	   }



	   public void setCharset(String charset) {
	       this.charset = charset;
	   }



	   /**
	    * @param to
	    *            ���͵�ַ
	    * @param isAuth
	    *            �Ƿ���Ҫ��֤
	    * @param subject
	    *            ����
	    * @param content
	    *            ����
	    * @param isHtml
	    *            �Ƿ���html
	    * @param files
	    *            ����
	    * @return
	    * @throws MessagingException
	    * @throws UnsupportedEncodingException
	    */
	   public void send(String[] tos, boolean isAuth, String subject,
	           String content, boolean isHtml, File[] files)
	        		   throws MessagingException, UnsupportedEncodingException {
	       Session session = null;
	       Properties props = System.getProperties();
	       props.put("mail.smtp.host", smtpServer);
	       if (isAuth) { // ��������Ҫ�����֤
	           props.put("mail.smtp.auth", "true");
	           //������֤��Authenticator
	           Authenticator authenticator = new Authenticator() {
	               protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
	                   return new javax.mail.PasswordAuthentication(username,
	                           password);
	               }
	           };
	           session = Session.getDefaultInstance(props, authenticator);
	       } else {
	           props.put("mail.smtp.auth", "false");
	           session = Session.getDefaultInstance(props, null);
	       }
	       //�Ƿ�debug
	       //session.setDebug(true);
	       Transport trans = session.getTransport("smtp");
	        
	       //���������
	      InternetAddress[] address = new InternetAddress[tos.length];
	       for (int i = 0; i < address.length; i++) {
	          address[i] = new InternetAddress(tos[i]);
	         // System.out.println(address[i]);
	         }
	        
	       //���ӷ�����
	       trans.connect(smtpServer, username, password);
	        
	       //���ɷ��͵���Ϣ
	       Message msg = new MimeMessage(session);
	       
	       //�ʼ��ĵ�ַ������
	       Address from_address = new InternetAddress(from, displayName);
	 
	       //����
	       msg.setFrom(from_address);
	        
	       //���ý����˵�ַ
	       msg.setRecipients(Message.RecipientType.TO, address);
	        
	       //���÷�������
	       msg.setSubject(subject);
	        
	       //����
	       Multipart mp = new MimeMultipart();
	 
	       //body����
	       MimeBodyPart mbp = new MimeBodyPart();
	   
	       //�жϷ��͵��Ƿ���html��ʽ
	       if (isHtml) {// �����html��ʽ
	           mbp.setContent(content, "text/html;charset=" + charset);
	       } else{
	           mbp.setText(content);
	       }
	       //�������Ĳ������뵽���岿��
	       mp.addBodyPart(mbp);
	        
	       if (files != null && files.length > 0) {// �ж��Ƿ��и���
	           //���ڸ����ͽ�����ȫ�����뵽BodyPart
	           for (File file : files) {
	               mbp = new MimeBodyPart();
	               FileDataSource fds = new FileDataSource(file); // �õ�����Դ
	               mbp.setDataHandler(new DataHandler(fds)); // �õ�������������BodyPart
	               mbp.setFileName(fds.getName()); // �õ��ļ���ͬ������BodyPart
	               mp.addBodyPart(mbp);
	           }
	       }
	       // Multipart���뵽�ż�
	       msg.setContent(mp); 
	        
	       // �����ż�ͷ�ķ�������
	       msg.setSentDate(new Date());
	        
	       // �����ż�
	       msg.saveChanges();
	       
	    
	       //����
	       trans.sendMessage(msg, msg.getAllRecipients());
	        
	       //����
	       trans.close();

	   }

}
