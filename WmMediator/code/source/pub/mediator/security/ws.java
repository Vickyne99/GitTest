package pub.mediator.security;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2011-06-01 12:29:13 EDT
// -----( ON-HOST: mcmgunasek-6400.mshome.net

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.security.ws.UsernameTokenAction;
import com.softwareag.pg.security.ws.X509TokenAction;
import com.softwareag.pg.security.ws.saml.SamlSenderVouchesTokenAction;
import com.softwareag.pg.security.ws.TimestampAction;
// --- <<IS-END-IMPORTS>> ---

public final class ws

{
	// ---( internal utility methods )---

	final static ws _instance = new ws();

	static ws _newInstance() { return new ws(); }

	static ws _cast(Object o) { return (ws)o; }

	// ---( server methods )---




	public static final void AddSamlSenderVouchesToken (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(AddSamlSenderVouchesToken)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		new SamlSenderVouchesTokenAction().process(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void AddTimestamp (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(AddTimestamp)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		new TimestampAction().process(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void AddUsernameToken (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(AddUsernameToken)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		new UsernameTokenAction().process(pipeline);
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void AddX509Token (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(AddX509Token)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		new X509TokenAction().process(pipeline);	
			
		// --- <<IS-END>> ---

                
	}
}

