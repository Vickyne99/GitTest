package mediator;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-10-07 07:58:50 EDT
// -----( ON-HOST: mcusawco.AME.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.io.InputStream;
import com.softwareag.pg.diag.DiagnosticManager;
import com.wm.data.IDataCursor;
import com.wm.app.b2b.server.Service;
import com.wm.net.HttpHeader;
// --- <<IS-END-IMPORTS>> ---

public final class util

{
	// ---( internal utility methods )---

	final static util _instance = new util();

	static util _newInstance() { return new util(); }

	static util _cast(Object o) { return (util)o; }

	// ---( server methods )---




	public static final void mediatorDiagnosticZip (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(mediatorDiagnosticZip)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		IDataCursor csr = null;
		boolean deleteZipFile = true;
		try {
			csr = pipeline.getCursor();
		        DiagnosticManager dm = new DiagnosticManager();
			Service.setResponse( dm.getDiagnosticDataAsBytes(deleteZipFile) );
		        HttpHeader hdr = Service.getHttpResponseHeader();
		        if ( hdr != null ) { 
		        	hdr.clearField(HttpHeader.CONTENT_TYPE);	
				hdr.addField(HttpHeader.CONTENT_TYPE, "application/zip" );
		                hdr.clearField(HttpHeader.CONTENT_DISPOSITION);
		                hdr.addField(HttpHeader.CONTENT_DISPOSITION, "attachment; filename=mediatorDiagnostic.zip");
			}
		
		} catch (Throwable t) {
			throw new ServiceException(t);
		}  finally {
			if ( csr != null ) { csr.destroy(); }
		}
		// --- <<IS-END>> ---

                
	}

	// --- <<IS-START-SHARED>> ---
	
	// --- <<IS-END-SHARED>> ---
}

