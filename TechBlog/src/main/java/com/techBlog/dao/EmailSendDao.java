package com.techBlog.dao;

import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailSendDao {
	public String generateAlphaOtp() {
		int length = 6;
		String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuilder otp = new StringBuilder();
		Random random = new Random();

		for (int i = 0; i < length; i++) {
			int index = random.nextInt(alphabet.length());
			otp.append(alphabet.charAt(index));
		}
		return otp.toString();
	}

	public boolean OtpSendToEmail(String email, String otp) {
		boolean f=false;
		String subject = "TechBlog otp verification:";
		String from = "tauseefthedeveloper@gmail.com";
		String password="qscapwfihkwfmrik";

		Properties props = new Properties();
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");

		Session session = Session.getInstance(props, new Authenticator() {
            @Override
			protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(from, password);
            }
        });
		try {
            MimeMessage mess = new MimeMessage(session);
            mess.setFrom(new InternetAddress(from, "TechBlog"));
            mess.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            mess.setSubject("Your OTP Code");
            mess.setText("Your OTP is: " + otp + "\n\nIt will expire in 5 minutes.");

            Transport.send(mess);
            f=true;
            com.techBlog.entities.Message message=new com.techBlog.entities.Message("OTP send successfully!","success","aler-success");
        } catch (Exception e) {
            e.printStackTrace();
        }
		return f;
	}
}
