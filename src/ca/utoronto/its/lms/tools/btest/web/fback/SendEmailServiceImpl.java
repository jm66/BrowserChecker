package ca.utoronto.its.lms.tools.btest.web.fback;

import java.io.*;
import java.util.Properties;

import javax.activation.*;
import javax.mail.*;
import javax.mail.internet.*;

import ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper;

public class SendEmailServiceImpl implements SendEmailService{
	private String from = null;
	private String to = "jm.lopez@utoronto.ca";
	private String smtp = null;
	
	public SendEmailServiceImpl(){
		this.from = new StringBuffer().append(BuildingBlockHelper.getHostname(BuildingBlockHelper.getFullHostName())).append("@").append(BuildingBlockHelper.DOMAIN).toString();
		this.smtp = BuildingBlockHelper.getSMTPServer();	
	}
	
	public SendEmailServiceImpl(String from){
		this.from = from;
	}
	public SendEmailServiceImpl(String from, String to){
		this.from = from;
		this.to = to;
	}
	
	public Session ConfigureEmail(){
		// Get system properties
	    Properties props = System.getProperties();
	    // 	Setup mail server
	    props.put("mail.smtp.host", smtp);
	    // Get session
	    return  Session.getInstance(props, null);
	}
	
	public void SendEmailWithAttachment(Session session, String subject, String body, File fileAttachment ){
		   try{
		         // Create a default MimeMessage object.
		         MimeMessage message = new MimeMessage(session);

		         // Set From: header field of the header.
		         message.setFrom(new InternetAddress(from));

		         // Set To: header field of the header.
		         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		         // Set Subject: header field
		         message.setSubject("This is the Subject Line!");

		         // Create the message part 
		         BodyPart messageBodyPart = new MimeBodyPart();

		         // Fill the message
		         messageBodyPart.setText("This is message body");
		         
		         // Create a multipar message
		         Multipart multipart = new MimeMultipart();

		         // Set text message part
		         multipart.addBodyPart(messageBodyPart);

		         // Part two is attachment
		         messageBodyPart = new MimeBodyPart();
		         DataSource source = new FileDataSource(fileAttachment.getAbsoluteFile());
		         messageBodyPart.setDataHandler(new DataHandler(source));
		         messageBodyPart.setFileName(fileAttachment.getName());
		         multipart.addBodyPart(messageBodyPart);

		         // Send the complete message parts
		         message.setContent(multipart );

		         // Send message
		         Transport.send(message);
		         System.out.println("Sent message successfully....");
		      }catch (MessagingException mex) {
		         mex.printStackTrace();
		      }
	}

	public void SendEmailWithoutAttachment(Session session, String subject,
			String body) {
		// TODO Auto-generated method stub
		
	}
}
