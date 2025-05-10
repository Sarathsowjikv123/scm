package com.ppascm;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class EmailSender {

	public static void main(String[] args) {
		sendEmail("sarathsowjikv@gmail.com", "Sample Email", "Email Sent Successfully");
	}

	public static boolean sendEmail(String to, String subject, String body) {
		String from = "sarathsowjikmsd777@gmail.com";
		String password = "vsri bnzw jcgy wycb";

		// SMTP server configuration
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "587");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");

		// Create a session
		Session session = Session.getInstance(props, new Authenticator() {
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, password);
			}
		});

		try {
			// Create a message
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			message.setSubject(subject);
			message.setText(body);

			// Send the message
			Transport.send(message);

			System.out.println("✅ Email sent successfully!");
			return true;

		} catch (MessagingException e) {
			e.printStackTrace();
			System.err.println("❌ Email sending failed.");
		}
		return false;
	}
}
