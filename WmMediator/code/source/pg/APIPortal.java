package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2015-11-24 14:42:10 IST
// -----( ON-HOST: MCCLEP01.eur.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.ui.APIPortalConfigHelper;
// --- <<IS-END-IMPORTS>> ---

public final class APIPortal

{
	// ---( internal utility methods )---

	final static APIPortal _instance = new APIPortal();

	static APIPortal _newInstance() { return new APIPortal(); }

	static APIPortal _cast(Object o) { return (APIPortal)o; }

	// ---( server methods )---




	public static final void deleteConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteConfig)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		APIPortalConfigHelper.deleteConfig(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getAllConfigs (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getAllConfigs)>> ---
		// @sigtype java 3.5
		APIPortalConfigHelper.getAllConfigs(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getConfig)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		APIPortalConfigHelper.getConfig(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void saveConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(saveConfig)>> ---
		// @sigtype java 3.5
		// [i] field:0:required ID
		// [i] field:0:required name
		// [i] field:0:required url
		// [i] field:0:required tenant
		// [i] field:0:required userName
		APIPortalConfigHelper.saveConfig(pipeline);
		// --- <<IS-END>> ---

                
	}
}

