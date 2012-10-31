package ca.utoronto.its.lms.tools.btest.web.fback;

import java.io.File;

import javax.mail.Session;

public interface SendEmailService {
	public Session ConfigureEmail();
	public void SendEmailWithoutAttachment(Session session, String subject, String body );
	public void SendEmailWithAttachment(Session session, String subject, String body, File fileAttachment );

}
