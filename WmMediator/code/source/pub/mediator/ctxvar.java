package pub.mediator;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-11-02 22:31:53 EDT
// -----( ON-HOST: mcusawco.AME.ad.sag

import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;
import com.wm.app.b2b.server.ServiceException;



// --- <<IS-START-IMPORTS>> ---
import com.softwareag.mediator.api.ApiConstants;
import com.softwareag.pg.ctxvar.ContextVariableException;
import com.softwareag.pg.ctxvar.flow.IDataFactoryHelper;

import javax.xml.namespace.QName;

import java.io.Serializable;

import com.softwareag.mediator.api.MediatorFacade;
import com.softwareag.mediator.api.MediatorConfigurationFacade;
import com.softwareag.pg.ctxvar.flow.ISMediatorRuntimeFacade;
import com.softwareag.pg.util.MessageContextUtils;
// --- <<IS-END-IMPORTS>> ---

public final class ctxvar

{
	// ---( internal utility methods )---

	final static ctxvar _instance = new ctxvar();

	static ctxvar _newInstance() { return new ctxvar(); }

	static ctxvar _cast(Object o) { return (ctxvar)o; }

	// ---( server methods )---


	public static final void declareContextVariable (IData pipeline) throws ServiceException
	{
		// --- <<IS-START(declareContextVariable)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required ctxVar
		// [o] object:0:required ctxVar
		// [o] object:0:required varNameQ
		IDataCursor csr = null;
		IDataCursor iCtxVarC = null;
		try {
			csr = pipeline.getCursor();
			QName varNameQ = IDataFactoryHelper.inst().createContextVariableFromiData(pipeline);
	        IDataUtil.put(csr, "varNameQ", varNameQ);
	        //SMGME-2621. Fix documentation also.
	        //Do not populate the ContextVariable type. It is changing the type of the declaration from IData to ContextVariable. 
	        //retained the output declaration of ctxVar to avoid migration issues.
	        //IDataUtil.put(csr, "ctxVar", ctxVar);
		}
		finally {
		        if ( csr != null ) { csr.destroy(); }
		        if ( iCtxVarC != null ) { iCtxVarC.destroy(); }
		} 
		// --- <<IS-END>> ---

                
	}



	public static final void getContextVariable (IData pipeline) throws ServiceException
	{
		// --- <<IS-START(getContextVariable)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required MessageContext
		// [i] field:0:required varName
		// [o] object:0:required serValue
		IDataCursor csr = null;
		 try {
            csr = pipeline.getCursor();
            String varName = IDataUtil.getString(csr, "varName");
            MessageContextUtils.ContextWrapper msgCtx = getMessageContext(csr);
            QName varNameQ = MediatorFacade.getContextVariableName(varName);
            Serializable serValue = ISMediatorRuntimeFacade.getContextVariableValue(varNameQ, msgCtx);
            csr.insertAfter("serValue", serValue);
		 } finally {
		    if ( csr != null ) { csr.destroy(); }
		 }
		// --- <<IS-END>> ---

                
	}



	public static final void removeContextVariable (IData pipeline) throws ServiceException
	{
		// --- <<IS-START(removeContextVariable)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required varName
		// [i] object:0:required MessageContext
		IDataCursor csr = null;
		try {
            csr = pipeline.getCursor();
            String varName = IDataUtil.getString(csr, "varName");
            QName varNameQ = MediatorFacade.getContextVariableName(varName);
            csr = pipeline.getCursor();
            MessageContextUtils.ContextWrapper msgCtx = getMessageContext(csr);
            MediatorConfigurationFacade.removeCustomContextVariable(msgCtx, varNameQ);
		} finally {
		 	if ( csr != null ) { csr.destroy(); }
		}
		// --- <<IS-END>> ---

                
	}



	public static final void setContextVariable (IData pipeline) throws ServiceException
	{
		// --- <<IS-START(setContextVariable)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] object:0:required MessageContext
		// [i] object:0:required serValue
		// [i] field:0:required varName
		IDataCursor csr = null;
		try {
		   csr = pipeline.getCursor();
		   Serializable serValue = IDataUtil.getString(csr,"serValue");
		   String varName = IDataUtil.getString(csr,"varName");
		   QName varNameQ = MediatorFacade.getContextVariableName(varName);
		   MessageContextUtils.ContextWrapper msgCtx = getMessageContext(csr);
		   ISMediatorRuntimeFacade.setContextVariableValue(varNameQ, serValue, msgCtx);
		} finally {
		   if ( csr!=null) { csr.destroy(); }
		}
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	private static MessageContextUtils.ContextWrapper getMessageContext(IDataCursor csr) throws ContextVariableException
	{
		Object obj = null;
		MessageContextUtils.ContextWrapper msgCtx = null;

		if ( csr.first( ApiConstants.MEDIATOR_MESSAGE_CONTEXT) ) 
	    {
	        obj = csr.getValue();
	    }
	    
	    if (obj instanceof org.apache.axis2.context.MessageContext) {
	        msgCtx = new MessageContextUtils.ContextWrapper((org.apache.axis2.context.MessageContext) obj);
	    } else if (obj instanceof org.apache.synapse.MessageContext) {
            msgCtx = new MessageContextUtils.ContextWrapper((org.apache.synapse.MessageContext) obj);
	    }
	    
	    return msgCtx;
	}
	
	/*
	private static IDataCursor getContextVariable(IDataCursor csr) 
	{
	    Object obj = null;
	    IDataCursor iCsr = null;
	
		if ( csr.first("ctxVar") ) 
	    {
	        obj = csr.getValue();
	    }
	    
	    if ( obj instanceof IData ) {
	          iCsr = ((IData)obj).getCursor();
	    }
	
		return iCsr;
	
	}
	*/
	// --- <<IS-END-SHARED>> ---
}

