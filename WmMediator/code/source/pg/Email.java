package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2009-05-05 14:11:05 EDT
// -----( ON-HOST: pcrburgett.AME.ad.sag

// --- <<IS-START-IMPORTS>> ---
import java.util.ArrayList;
import java.util.List;

import com.softwareag.pg.PolicyGateway;
import com.softwareag.pg.logging.PGLoggingResources;
import com.softwareag.pg.pgmen.events.smtp.EmailMessage;
import com.softwareag.pg.pgmen.events.smtp.EmailSender;
import com.softwareag.pg.util.ConfigUtil;
// --- <<IS-END-IMPORTS>> ---
import com.wm.app.b2b.server.InvokeState;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;

public final class Email

{
	// ---( internal utility methods )---

	final static Email _instance = new Email();

	static Email _newInstance() { return new Email(); }

	static Email _cast(Object o) { return (Email)o; }

	// ---( server methods )---




	public static final void testEmailConnection (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(testEmailConnection)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required pg.email.smtpHost
		// [i] field:0:required pg.email.smtpPort
		// [i] field:0:required pg.email.userName
		// [i] field:0:required pg.email.password
		// [i] field:0:required pg.email.from
		// [i] field:0:required pg.email.TLSEnabled
		// [i] field:0:required pg.email.test.recipient
		// [o] field:1:required errorMessages
		IDataCursor csr = pipeline.getCursor();
		
		ArrayList<String> errorMsgs = new ArrayList<String>();
		
		String hostName = IDataUtil.getString( csr, HOST_NAME_PROP_KEY );
		int port = IDataUtil.getInt( csr, PORT_PROP_KEY, 25 );
		String userName = IDataUtil.getString( csr, USER_NAME_PROP_KEY );
		String pw = IDataUtil.getString( csr, PASSWORD_PROP_KEY );
		String fromName = IDataUtil.getString( csr, FROM_NAME_PROP_KEY );
		String enableTlsStr = IDataUtil.getString( csr, ENABLE_TLS_PROP_KEY );
		boolean enableTls = Boolean.parseBoolean( enableTlsStr );
		String recip = IDataUtil.getString( csr, TEST_RECIP_PROP_KEY );
		
		FriendlyEmailSender subject = new FriendlyEmailSender();
		
		try {
               EmailSender emailSender = (EmailSender)ConfigUtil.getInstance().getBean(EmailSender.BEAN_NAME);
		   subject.setSmtpHost( hostName );
		   subject.setSmtpPort( port );
		   subject.setUserName( userName );
		   subject.setPassword( pw );
		   subject.setFrom( fromName );
		   subject.setTLSEnabled( enableTls );
		   subject.setActive( true );
			// capture relevant configured values from the real bean's pg-config.xml configuration
               subject.setCharSet(emailSender.getCharSet());
               subject.setTimeout(emailSender.getTimeout());		

		   subject.lazyInit();
		
		   EmailMessage msg = createTestMsg( recip, fromName );
		   subject.send( msg );
		}
		catch ( Exception e ) {
		   collectErrorMessages( errorMsgs, e );
		}
		
		csr.insertAfter( "errorMessages", errorMsgs.toArray( new String[ errorMsgs.size() ] ) );
		csr.insertAfter( "localizedMessages", errorMsgs.toArray( new String[ errorMsgs.size() ] ) );
		csr.destroy();
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static final String HOST_NAME_PROP_KEY = "pg.email.smtpHost";
	private static final String PORT_PROP_KEY = "pg.email.smtpPort";
	private static final String USER_NAME_PROP_KEY = "pg.email.userName";
	private static final String PASSWORD_PROP_KEY = "pg.email.password";
	private static final String FROM_NAME_PROP_KEY = "pg.email.from";
	private static final String ENABLE_TLS_PROP_KEY = "pg.email.TLSEnabled";
	private static final String TEST_RECIP_PROP_KEY = "pg.email.test.recipient";

	private static final PGLoggingResources LOG_RES =
        new PGLoggingResources( EmailMessage.class,
                                PGLoggingResources.LoggingFacility.MEN_EVENTS);	

	
	private static EmailMessage createTestMsg(String inTo, String inFrom) {
	  EmailMessage returnMsg = new EmailMessage();

	  String targetName = PolicyGateway.getInstance().getTargetName();
	  if ( targetName == null ) targetName = "";
        returnMsg.setSubject( 
			LOG_RES.newMessage("0205.0359", new Object[]{targetName}).getMessage(InvokeState.getCurrentLocale()));
		
        returnMsg.setMessageBody( 
			LOG_RES.newMessage("0205.0391", 
				new Object[]{com.softwareag.pg.util.PropertyUtils.NL}
				).getMessage(InvokeState.getCurrentLocale()));

	  ArrayList<String> recips = new ArrayList<String>();
	  recips.add( inTo );
	  returnMsg.setRecipients( recips );
	  returnMsg.setFrom( inFrom );
	  return returnMsg;
	}
	
	private static void collectErrorMessages(List<String> inList, Exception inExcept) {
		
		String eMsg = LOG_RES.newMessage("0205.0363", 
				new Object[]{}
				).getMessage(InvokeState.getCurrentLocale());
		
	   inList.add( eMsg );	   
	   StringBuilder buff = new StringBuilder();
	   buff.append( inExcept.toString() );
	   inList.add( buff.toString() );
	   Throwable cause = inExcept.getCause();
	   while ( cause != null ) {
	      buff = new StringBuilder();
	      buff.append( cause.toString() );
	      inList.add( buff.toString() );
	      cause = cause.getCause();
	   }
	}
	
	//  an inner class to give us access to protected parts of the factory
	static class FriendlyEmailSender extends EmailSender {
	  public void setPassword(String inPw) {
	    super.setPassword( inPw );
	  }
	}
	// --- <<IS-END-SHARED>> ---
}

