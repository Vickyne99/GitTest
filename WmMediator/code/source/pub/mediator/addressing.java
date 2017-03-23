package pub.mediator;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-11-02 16:55:15 EDT
// -----( ON-HOST: mcusawco.AME.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.addressing.AddressingOutAction;
// --- <<IS-END-IMPORTS>> ---

public final class addressing

{
	// ---( internal utility methods )---

	final static addressing _instance = new addressing();

	static addressing _newInstance() { return new addressing(); }

	static addressing _cast(Object o) { return (addressing)o; }

	// ---( server methods )---




	public static final void AddWSAddressingHeaders (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(AddWSAddressingHeaders)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		new AddressingOutAction().process(pipeline);
		// --- <<IS-END>> ---

                
	}
}

