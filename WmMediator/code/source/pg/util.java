package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2008-07-07 12:08:50 EDT
// -----( ON-HOST: usasuD600.AME.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class util

{
	// ---( internal utility methods )---

	final static util _instance = new util();

	static util _newInstance() { return new util(); }

	static util _cast(Object o) { return (util)o; }

	// ---( server methods )---




	public static final void checkHeartbeat (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(checkHeartbeat)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		//a no-op service which for now just prints a msg to the console
		System.out.println("WmPolicyGateway heart beat service called");
		// --- <<IS-END>> ---

                
	}
}

