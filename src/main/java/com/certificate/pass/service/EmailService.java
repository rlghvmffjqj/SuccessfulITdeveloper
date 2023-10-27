package com.certificate.pass.service;

import java.util.Random;

import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
	@Autowired JavaMailSender emailSender;
	
	public String ePw;
	
	private MimeMessage createMessage(String to)throws Exception{
	    ePw = createKey();
	    MimeMessage  message = emailSender.createMimeMessage();
	
	    message.addRecipients(RecipientType.TO, to);
	    message.setSubject("Successful IT Developer 이메일 인증");
	
	    String msgg="";
	    msgg+= "<div style='margin:20px;'>";
	    msgg+= "<h1>Successful IT Developer 회원가입 인증 메일</h1>";
	    msgg+= "<br>";
	    msgg+= "<p>회원 가입해 주셔서 감사합니다. 개발자님께 도움이 되기위해 더욱 노력 하겟습니다.<p>";
	    msgg+= "<br>";
	    msgg+= "<p>감사합니다.<p>";
	    msgg+= "<br>";
	    msgg+= "<div align='center' style='border:1px solid black; font-family:verdana';>";
	    msgg+= "<h3 style='color:blue;'>아래 코드 입력 바랍니다.</h3>";
	    msgg+= "<div style='font-size:130%'>";
	    msgg+= "CODE : <strong>";
	    msgg+= ePw+"</strong><div><br/> ";
	    msgg+= "</div>";
	    message.setText(msgg, "utf-8", "html");//�궡�슜
	    message.setFrom(new InternetAddress("rlghvmffjqj@gmail.com","Successful IT Developer"));
	
	    return message;
	}
	
	public static String createKey() {
	    StringBuffer key = new StringBuffer();
	    Random rnd = new Random();
	
	    for (int i = 0; i < 8; i++) { 
	        int index = rnd.nextInt(3); 
	
	        switch (index) {
	            case 0:
	                key.append((char) ((int) (rnd.nextInt(26)) + 97));
	                //  a~z  (ex. 1+97=98 => (char)98 = 'b')
	                break;
	            case 1:
	                key.append((char) ((int) (rnd.nextInt(26)) + 65));
	                //  A~Z
	                break;
	            case 2:
	                key.append((rnd.nextInt(10)));
	                // 0~9
	                break;
	        }
	    }
	    return key.toString();
	}

	public String sendSimpleMessage(String to)throws Exception {
	    // TODO Auto-generated method stub
	    MimeMessage message = createMessage(to);
	    try{
	        emailSender.send(message);
	    }catch(MailException es){
	        es.printStackTrace();
	        throw new IllegalArgumentException();
	    }
	    return ePw;
	}
}
