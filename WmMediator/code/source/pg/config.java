package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2009-01-30 13:33:37 EST
// -----( ON-HOST: mgunasek-d610.AME.ad.sag


import com.softwareag.pg.PolicyGateway;
import com.softwareag.pg.init.PackageLifeCycleHelper;
import com.softwareag.pg.pgmen.cache.CacheManager;
import com.softwareag.pg.pgmen.cache.CacheState;
import com.softwareag.pg.pgmen.cache.ClusterStatusCache;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;
import com.wm.util.Trace;
import com.wm.util.Values;
import com.wm.util.xform.DateTimeDT;

import java.util.Date;

// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class config

{
	// ---( internal utility methods )---

//	final static config _instance = new config();

	static config _newInstance() { return new config(); }

	static config _cast(Object o) { return (config)o; }

	// ---( server methods )---



    public static final Values init (Values in)
    {
        Values out = in;
		// --- <<IS-START(init)>> ---
		// @subtype unknown
		// @sigtype java 3.0
		PackageLifeCycleHelper.startup();
		// --- <<IS-END>> ---
        return out;
                
	}


    public static final Values shutdown (Values in)
    {
        Values out = in;
		// --- <<IS-START(shutdown)>> ---
		// @subtype unknown
		// @sigtype java 3.0
		PackageLifeCycleHelper.shutdown();
		// --- <<IS-END>> ---
        return out;
                
	}

	public static final void isMediatorStarted (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(isMediatorStarted)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [o] field:0:required isMediatorStarted
		System.out.println("WmMediator start-up validation service is called");
		boolean state = PolicyGateway.getPGConfiguration().isSafeDeployment();
		IDataCursor inCsr = pipeline.getCursor();
		IDataUtil.put( inCsr, "isMediatorStarted", state);
		inCsr.destroy();
		// --- <<IS-END>> ---
	}
	
    public static final void getStateCacheProps (IData pipeline)
        throws ServiceException
    {
        // --- <<IS-START(getStateCacheProps)>> ---
        // @subtype unknown
        // @sigtype java 3.5
        // [o] field:0:required cacheState
        // [o] field:0:required updatingMember
        // [o] field:0:required lastRegisteredConsumerNamesTime
        // [o] field:0:required lastServiceUpdateTime
        // [o] field:0:required lastConsumerUpdateTime
        IDataCursor csr = pipeline.getCursor();
        
        CacheManager cMgr = CacheManager.inst();
        
        if ( cMgr != null ) {
            ClusterStatusCache cache = cMgr.getClusterStatusCache();
            if ( cache != null ) {
                CacheState cacheState = cache.getCacheState();
                addCacheStateString( csr, "cacheState", cacheState );
                String tempStr = cache.getCacheUpdatingMember();
                addUpdatingMemberString( csr, "updatingMember", tempStr );
                tempStr = date2String( cache.getLastRegisteredConsumerNamesUpdateTime() );
                addValidString( csr, "lastRegisteredConsumerNamesTime", tempStr, UNKNOWN );
                tempStr = date2String( cache.getLastServiceUpdateTime() );
                addValidString( csr, "lastServiceUpdateTime", tempStr, UNKNOWN );
                tempStr = date2String( cache.getLastConsumerUpdateTime() );
                addValidString( csr, "lastConsumerUpdateTime", tempStr, UNKNOWN );
            }
        }
        
        csr.destroy();
            
        // --- <<IS-END>> ---

                
    }

	// --- <<IS-START-SHARED>> ---

	// these are global-type definitions

	// connection table is scoped to this IM
   	private static long gId = System.currentTimeMillis(); // initialize
   	private static Object gLock = new Object(); // locking

   	private static final String nextKey () {
        synchronized(gLock) {
            return Long.toString(gId++);
        }
    }

    private static final String UNKNOWN = "unknown";

	private static void addCacheStateString(IDataCursor inCsr, String inKey, CacheState inState) {
        if ( inState != null ) {
            IDataUtil.put( inCsr, inKey, inState.toString() );
        }
    }

    private static void addUpdatingMemberString(IDataCursor inCsr, String inKey, String inValue) {
        if ( ! ClusterStatusCache.NON_UPDATING_MEMBER_UID.equals( inValue ) ) {
            IDataUtil.put( inCsr, inKey, inValue );
        }
    }

    private static void addValidString(IDataCursor inCsr, String inKey, String inValue) {
        if ( neitherNullNorEmpty( inValue ) ) {
            IDataUtil.put( inCsr, inKey, inValue );
        }
    }

    private static void addValidString(IDataCursor inCsr, String inKey, String inValue, String inDefault) {
        if ( neitherNullNorEmpty( inValue ) ) {
            IDataUtil.put( inCsr, inKey, inValue );
        }
        else {
            IDataUtil.put( inCsr, inKey, inDefault );
        }
    }

    private static String date2String(Date inDate) {
         return (inDate != null ? DateTimeDT.convertDate( inDate, Trace.DEFAULT_DATE_FORMAT, null)
                    : "");
    }

    private static boolean neitherNullNorEmpty(String inStr) {
        return ( inStr != null && inStr.length() > 0 );
    }
    
	// --- <<IS-END-SHARED>> ---
}

