package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-08-18 10:53:06 EDT
// -----( ON-HOST: mcmgunasek-6400.AME.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.softwareag.pg.ui.STSConfigRetriever;
// --- <<IS-END-IMPORTS>> ---

public final class stsconfig

{
	// ---( internal utility methods )---

	final static stsconfig _instance = new stsconfig();

	static stsconfig _newInstance() { return new stsconfig(); }

	static stsconfig _cast(Object o) { return (stsconfig)o; }

	// ---( server methods )---




	public static final void deleteConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(deleteConfig)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.deleteconfig(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getAllConfigs (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getAllConfigs)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.loadConfigs(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getCertAliases (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getCertAliases)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.getCertAliases(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getConfig)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.loadConfig(pipeline);		
		// --- <<IS-END>> ---

                
	}



	public static final void getKeyStoreAliases (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getKeyStoreAliases)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.getPrivateKeyAliases(pipeline);
		STSConfigRetriever.getCertAliases(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getPKAliases (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getPKAliases)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.getPrivateKeyAliases(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void saveConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(saveConfig)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		STSConfigRetriever.saveConfig(pipeline);
		// --- <<IS-END>> ---

                
	}
}

