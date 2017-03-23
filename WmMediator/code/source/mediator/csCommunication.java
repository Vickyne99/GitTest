package mediator;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2014-11-05 15:49:49 IST
// -----( ON-HOST: MCVAC01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.cscommunication.CSCommunicationISManager;
import com.wm.data.IData;
// --- <<IS-END-IMPORTS>> ---

public final class csCommunication

{
	// ---( internal utility methods )---

	final static csCommunication _instance = new csCommunication();

	static csCommunication _newInstance() { return new csCommunication(); }

	static csCommunication _cast(Object o) { return (csCommunication)o; }

	// ---( server methods )---




	public static final void publishCSCommunication (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(publishCSCommunication)>> ---
		// @sigtype java 3.5
		CSCommunicationISManager mgr = new CSCommunicationISManager();
		mgr.update(pipeline);
		// --- <<IS-END>> ---

                
	}
}

