package mediator;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2013-12-11 14:03:47 IST
// -----( ON-HOST: MCMKI01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.oauth2.AccessTokenHelper;
// --- <<IS-END-IMPORTS>> ---

public final class oauth2

{
	// ---( internal utility methods )---

	final static oauth2 _instance = new oauth2();

	static oauth2 _newInstance() { return new oauth2(); }

	static oauth2 _cast(Object o) { return (oauth2)o; }

	// ---( server methods )---




	public static final void getAccessToken (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getAccessToken)>> ---
		// @sigtype java 3.5
		new AccessTokenHelper().getAccessToken(pipeline);
		// --- <<IS-END>> ---

                
	}
}

