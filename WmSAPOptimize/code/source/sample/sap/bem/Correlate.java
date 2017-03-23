/*
 * Correlate.java
 *
 * Copyright 2008 webMethods, Inc.
 * ALL RIGHTS RESERVED
 *
 * UNPUBLISHED -- Rights reserved under the copyright laws of the United States.
 * Use of a copyright notice is precautionary only and does not imply
 * publication or disclosure.
 *
 * THIS SOURCE CODE IS THE CONFIDENTIAL AND PROPRIETARY INFORMATION OF
 * WEBMETHODS, INC.  ANY REPRODUCTION, MODIFICATION, DISTRIBUTION,
 * OR DISCLOSURE IN ANY FORM, IN WHOLE, OR IN PART, IS STRICTLY PROHIBITED
 * WITHOUT THE PRIOR EXPRESS WRITTEN PERMISSION OF WEBMETHODS, INC.
 */
package sample.sap.bem;

// --- <<B2B-START-IMPORTS>> ---
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataFactory;
import com.wm.data.IDataUtil;
import com.wm.lang.ns.NSName;

// --- <<B2B-END-IMPORTS>> ---

/**
 * Sample correlation services.
 */
public final class Correlate
{
	// ---( internal utility methods )---
	final static Correlate _instance = new Correlate();
	static Correlate _newInstance() {return new Correlate();}
	static Correlate _cast( Object o) {return (Correlate) o;}
	// ---( server methods )---

	// --- <<B2B-START-SHARED>> ---

	private static NSName _lookupCorrService	= NSName.create( "pub.prt.correlate", "lookupCorrelation");
	private static NSName _establishCorrService	= NSName.create( "pub.prt.correlate", "establishCorrelation");

	/**
	 * Looks up the process instance id for an given correlation id.
	 * 
	 * @param	cid The correlation id
	 * @return	the process instance id
	 * @throws	ServiceException if there is an error during execution of the underlying service
	 */
	private static String lookupCorrelation( String cid) throws ServiceException
	{
		String pid = null;
		try
		{
			Object [][] o =
			{
				{ "ProcessCorrelationID", cid			},
				{ "MappingType"			, "IS"			},
				{ "CreateIfMissing"		, "false"		},
			};
			IData corrPipe;
			corrPipe = Service.doInvoke( _lookupCorrService, IDataFactory.create( o));
			IDataCursor ipc = corrPipe.getCursor();
			pid = IDataUtil.getString( ipc, "ProcessInstanceID");
			ipc.destroy();
		}
		catch( Exception e)
		{
			throw new ServiceException( e);
		}
		return getProcessID( pid);
	}

	/**
	 * Establishes a new correlation between the provided process instance id and
	 * a given correlation id.
	 * 
	 * @param	pid The process instance id
	 * @param	cid The correlation id
	 * @return	<code>true</code> if the correlation got established successfully,
	 * 			<code>false</code> otherwise
	 * @throws	ServiceException if there is an error during execution of the underlying service
	 */
	private static boolean establishCorrelation( String pid, String cid) throws ServiceException
	{
		try
		{
			Object [][] o =
			{
				{ "ProcessCorrelationID", cid				},
				{ "ProcessInstanceID"	, pid				},
				{ "MappingType"			, "IS"				},
			};
			IData corrPipe;
			corrPipe = Service.doInvoke( _establishCorrService, IDataFactory.create( o));
			IDataCursor ipc = corrPipe.getCursor();
			boolean success = IDataUtil.getBoolean( ipc, "success");
			ipc.destroy();
			return success;
		}
		catch( Exception e)
		{
			throw new ServiceException( e);
		}
	}

	/**
	 * Retrieves the pure process instance id without iteration identifier.
	 * 
	 * @param	combinedId The process instance id plus iteration number
	 * @return	the pure process instance id without iteration identifier
	 */
	private static String getProcessID( String combinedId)
	{
		if( combinedId == null)
			return null;
		else if( combinedId.lastIndexOf( ':') != -1)
			return combinedId.substring( 0, combinedId.lastIndexOf( ':'));
		else
			return combinedId;
	}

	/**
	 * Retrieves the iteration number for this process instance.
	 * 
	 * @param	combinedId The process instance id plus iteration number
	 * @return	the iteration identifier
	 */
	private static Integer getIteration( String combinedId)
	{
		if( combinedId == null)
			return new Integer( 1);

		combinedId = combinedId.trim();
		if( combinedId.lastIndexOf( ':') != -1)
			return new Integer( combinedId.substring( combinedId.lastIndexOf( ':') + 1));
		else
			return new Integer( 1);
	}

	/**
	 * Returns the business object id.
	 * 
	 * @return	the business object id
	 */
	private static String getObjectId( IData bo)
	{
		IDataCursor idc = bo.getCursor();
		String cid = IDataUtil.getString( idc, "objectID");
		idc.destroy();
		return (cid != null && cid.length() > 0) ? cid : null;
	}

	/**
	 * Returns the receiver type from the pipeline.
	 * 
	 * @param	idc The {@link IData} cursor
	 * @return	the receiver type from the pipeline
	 */
	private static String getReceiverType( IDataCursor idc)
	{
		String rt = IDataUtil.getString( idc, "receiverType");
		if( rt == null)
			rt = IDataUtil.getString( idc, "RECEIVERTYPE");
		return rt;
	}

	/**
	 * Queries IDoc segments <code>E1EDK02</code> for reference id's.
	 * 
	 * @param	idocSegments List of <code>E1EDK02</code> IDoc segments
	 * @return	one reference id from the list of reference id's or <code>null</code> if none was found
	 */
	private static String extractIDocReference( IData[] idocSegments)
	{
		// Reading the complete list for the first document number used. Should be
		// the inquiry, quotation, or order number.
		String belnr = null;
		for( int i = 0; i < idocSegments.length; i++)
		{
			String newBelnr = extractIDocReference( idocSegments[i]);
			belnr = newBelnr != null ? newBelnr : belnr;
		}
		return belnr;
	}

	/**
	 * Queries the fields from IDoc segment <code>E1EDK02</code> for reference
	 * id's.
	 * 
	 * @param	idocSegment One <code>E1EDK02</code> IDoc segment
	 * @return	one reference id from the list of reference id's or <code>null</code> if none was found
	 */
	private static String extractIDocReference( IData idocSegment)
	{
		IDataCursor idc = idocSegment.getCursor();
		int qualf = IDataUtil.getInt( idc, "QUALF", -1);
		String belnr = IDataUtil.getString( idc, "BELNR");
		String vgbel = IDataUtil.getString( idc, "VGBEL");
		idc.destroy();
		
		// Segment from DESADV01
		if(vgbel != null)
			return vgbel;

		// Segment from ORDERS05 or INVOIC02
		switch( qualf)
		{
			case 003: // Reference to CustomerInquiry
			case 004: // Reference to CustomerQuotation
			case 002: // Reference to SalesOrder
				return belnr;
			default:
				return null;
		}
	}

	/**
	 * Extracts the correlation id from the <code>event</code>/<code>rfc</code> document.
	 * 
	 * @param	document The received document of document
	 * @return	the correlation id
	 */
	private static String getCorrelationID( IData document)
	{
		IDataCursor idc = document.getCursor();

		// Extracts the reference id from the IDoc document
		IData idocList = IDataUtil.getIData( idc, "ORDERS05");
		if (idocList == null)
			idocList = IDataUtil.getIData( idc, "INVOIC02");
		if (idocList == null)
			idocList = IDataUtil.getIData( idc, "DESADV01");
		if (idocList != null)
		{
			IDataCursor idocListCursor = idocList.getCursor();
			IData idoc = IDataUtil.getIDataArray( idocListCursor, "IDOC")[0];
			idocListCursor.destroy();
			IDataCursor idocCursor = idoc.getCursor();
			IData[] idocSegments = IDataUtil.getIDataArray( idocCursor, "E1EDK02");
			if (idocSegments == null)
			{
				IData idocSegment = IDataUtil.getIDataArray( idocCursor, "E1EDK08")[0];
				IDataCursor idocSegmentCursor = idocSegment.getCursor();
				idocSegments = IDataUtil.getIDataArray( idocSegmentCursor, "E1EDP07");
				idocSegmentCursor.destroy();
			}
			idocCursor.destroy();
			return extractIDocReference( idocSegments);
		}

		// It's not an IDoc ... check rfc document
		String cid = IDataUtil.getString( idc, "CORRELATIONOBJECTID");
		// No specific correlation id found ... use event id instead
		if( cid == null || cid.length() == 0)
			cid = IDataUtil.getString( idc, "EVENTOBJECTID");
		if( cid != null && cid.length() > 0)
		{
			idc.destroy();
			return cid;
		}

		// It's not an rfc document ... check event document
		IData evtObject = IDataUtil.getIData( idc, "eventObject");
		IData corrObject = IDataUtil.getIData( idc, "correlationObject");
		idc.destroy();

		IData applObject = null;
		if( evtObject != null)
		{
			IDataCursor eoc = evtObject.getCursor();
			IData inputParams = IDataUtil.getIData( eoc, "fields");
			eoc.destroy();
			if( inputParams != null)
			{
				IDataCursor ipc = inputParams.getCursor();
				applObject = IDataUtil.getIData( ipc, "Appl_Object");
				ipc.destroy();
			}
		}

		// Replace event BO by application BO
		if( corrObject != null)
			cid = getObjectId( corrObject);

		if( cid == null && applObject != null)
			cid = getObjectId( applObject);

		if( cid == null)
			cid = getObjectId( evtObject);
		return cid;
	}

	/**
	 * Extracts the event id from the <code>event</code>/<code>rfc</code> document.
	 * 
	 * @param	document The received document
	 * @return	the event id
	 */
	private static String getEventID( IData document)
	{
		IDataCursor idc = document.getCursor();

		// Extracts the reference id from the IDoc document
		IData idocList = IDataUtil.getIData( idc, "ORDERS05");
		if (idocList == null)
			idocList = IDataUtil.getIData( idc, "INVOIC02");
		if (idocList == null)
			idocList = IDataUtil.getIData( idc, "DESADV01");
		if (idocList != null)
		{
			IDataCursor idocListCursor = idocList.getCursor();
			IData idoc = IDataUtil.getIDataArray( idocListCursor, "IDOC")[0];
			idocListCursor.destroy();
			IDataCursor idocCursor = idoc.getCursor();
			IData idocSegment = IDataUtil.getIData( idocCursor, "EDI_DC40");
			idocCursor.destroy();
			IDataCursor idocSegmentCursor = idocSegment.getCursor();
			String docNum = IDataUtil.getString( idocSegmentCursor, "DOCNUM");
			idocSegmentCursor.destroy();
			return docNum;
		}

		// It's not an IDoc ... check event document
		IData evtObject = IDataUtil.getIData( idc, "eventObject");
		if( evtObject != null)
		{
			idc.destroy();
			return getObjectId( evtObject);
		}

		// It's not an event document ... check rfc document
		String cid = IDataUtil.getString( idc, "EVENTOBJECTID");
		if( cid != null && cid.length() > 0)
		{
			idc.destroy();
			return cid;
		}

		// default
		idc.destroy();
		return null;
	}
	// --- <<B2B-END-SHARED>> ---

	/**
	 * Correlation service used to determine the correlation id based on the received
	 * business object event stored in document <code>Document</code>.
	 * <p>Used in conjunction with PE processes only.</p>
	 * <p>
	 * Depending on the event parameters and how the event container was populated
	 * at the SAP system, the data stored in <code>Document</code> will vary. The
	 * following fields/objects are expected to be contained in <code>Document</code>:
	 * <ul>
	 *   <li>eventName - {@link String} - The event name as defined within SAP</li>
	 *   <li>receiverType - {@link String} - The receiver type from the event/receiver coupling</li>
	 *   <li>logicalSystem - {@link String} - The SAP logical system</li>
	 *   <li>eventObject - {@link IData} - The business object instance for this event</li>
	 *   <li>correlationObject(optional) - {@link IData} - The business object instance used for correlation purpose</li>
	 * </ul>
	 * </p>
	 * @param	pipeline The pipeline.
	 * @throws	ServiceException if there is an error during execution of this service.
	 */
	public static final void extractCID( IData pipeline) throws ServiceException
	{
		// --- <<B2B-START(extractCID)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// @specification pub.prt:CorrelationService
		IDataCursor idc = pipeline.getCursor();
		IData document = IDataUtil.getIData( idc, "Document");
		if( document == null)
			throw new ServiceException( "WmSAPOptimize sample service: Missing required parameter \"Document\"");

		// Extracts the correlation id from the document
		String cid = getCorrelationID( document);
		if( cid == null)
			return;

		IDataUtil.put( idc, "ProcessCorrelationID", cid);
		idc.destroy();

		// Establish an additional correlation for later usage
		String cid2 = getEventID( document);
		if( cid2 != null && !cid2.equals( cid))
		{
			String pid = lookupCorrelation( cid);
			if( pid != null && pid.length() > 0)
				establishCorrelation( pid, cid2);
		}
		// --- <<B2B-END>> ---
	}
}