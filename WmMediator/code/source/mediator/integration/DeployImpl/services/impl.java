package mediator.integration.DeployImpl.services;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-07-12 09:19:30 EDT
// -----( ON-HOST: pcrburgett.AME.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.integration.deployment.DeploymentController;
// --- <<IS-END-IMPORTS>> ---

public final class impl

{
	// ---( internal utility methods )---

	final static impl _instance = new impl();

	static impl _newInstance() { return new impl(); }

	static impl _cast(Object o) { return (impl)o; }

	// ---( server methods )---




	public static final void ping (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(ping)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		DeploymentController.ping( pipeline );
		// --- <<IS-END>> ---

                
	}



	public static final void remove (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(remove)>> ---
		// @subtype unknown
		// @sigtype java 3.5
        DeploymentController.remove( pipeline );
		// --- <<IS-END>> ---

                
	}



    public static final void replace (IData pipeline)
        throws ServiceException
    {
        // --- <<IS-START(replace)>> ---
        // @subtype unknown
        // @sigtype java 3.5
        DeploymentController.replace( pipeline );
        // --- <<IS-END>> ---

                
    }



	public static final void update (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(update)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		DeploymentController.update( pipeline );
		// --- <<IS-END>> ---

                
	}
	
	public static final void fetchOAuth2Client (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(update)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		DeploymentController.fetchOAuth2Client( pipeline );
		// --- <<IS-END>> ---

                
	}
}

