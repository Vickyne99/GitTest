package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-11-30 14:31:56 EST
// -----( ON-HOST: MCUSAWCO01.AME.ad.sag

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import java.util.ResourceBundle;
import java.util.Date;
import java.util.TimeZone;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.text.DateFormat;
import java.text.ParseException;
import java.io.FileNotFoundException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;
import com.wm.app.b2b.server.BundleUtil;
import com.wm.app.audit.config.AuditConfigConstants;
import com.softwareag.pg.pgmen.events.audit.reader.MediatorAuditLogReader;
import com.wm.util.Config;
import com.wm.util.Trace;
import com.wm.util.xform.DateTimeDT;
import com.softwareag.pg.pgmen.events.audit.TransactionAuditRecordType;
// --- <<IS-END-IMPORTS>> ---

public final class auditQuery

{
	// ---( internal utility methods )---

	final static auditQuery _instance = new auditQuery();

	static auditQuery _newInstance() { return new auditQuery(); }

	static auditQuery _cast(Object o) { return (auditQuery)o; }

	// ---( server methods )---



    public static final Values getAuditRows (Values in)
    {
        Values out = in;
		// --- <<IS-START(getAuditRows)>> ---
		// @subtype unknown
		// @sigtype java 3.0
		// [o] record:1:optional logEntries
		// [o] field:0:required message


    // Name: getAuditRows
    // Parameters:
    //    log (String, name of file)
    //    numlines (int, number of lines to return)
    //    reverse (boolean, true is descending)
    //    startDate (String, starting date for entries)
    //    endDate (String, ending date for entries)
    // Side-effects:
    //    none
    // Returns:
    //    found (String)
    //    logEntries (Values[], array of log values objects)
    String logFile = in.getString( "log" );
    String[] logText = null;
    IData[] logEntries = null;
    boolean reverse = false;

    int numlines = in.getInt( "numlines", 35 );
    out.put( "numlines", numlines );

    String order = in.getString( "order" );
    if( order != null )
    {
       reverse = "Descending".equalsIgnoreCase(order);
    }

	String startDate = in.getNonEmptyString("qfromdate");
	String endDate = in.getNonEmptyString("qtodate");

    if( logFile == null )
      {

      String message="logFile not found for 'log' input parameter";
      Object args[] = { logFile };
      message = MessageFormat.format( message, args );
      out.put( "message", message );
      }
    // Check for the custom Audit log
    // 
    else if( logFile.equals( "Transaction" )  )
    {
      // Determine which reader to use based on log file requested
      try
        {
		// check for valid dates....
		if(startDate != null) {
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			sd.setLenient(false);
			Date d = sd.parse(startDate);
		}
		if(endDate != null) {
			SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			sd.setLenient(false);
			Date d = sd.parse(endDate);
		}
		//The ctor parameter is the spring bean config name for Audit Transaction events
          MediatorAuditLogReader alr = new MediatorAuditLogReader( "AuditTransactionFormatter" );
          
          logEntries = alr.readAuditEntries(numlines, reverse, startDate, endDate);
	    out.put( "logEntries", logEntries );
        }
      catch( Throwable ex )
        {
        // The HTML pages can't contain the <> of wrapped exceptions
        // So this code replaces the <> with []
        String message = ex.toString();
        message = message.replace( '<', '[' );
        message = message.replace( '>', ']' );
        out.put( "message", message );
 
        ex.printStackTrace();

        }
      Date date = new Date();
      String d = DateTimeDT.convertDate( date, Config.getProperty( Trace.DEFAULT_DATE_FORMAT,
          "watt.server.dateStampFmt" ), null );
      out.put( "logdate", d );
      }

		// --- <<IS-END>> ---
        return out;
                
	}


    public static final Values readFieldValue (Values in)
    {
        Values out = in;
		// --- <<IS-START(readFieldValue)>> ---
		// @subtype unknown
		// [i] field:0:required pkname {&quot;e.g.&quot;,&quot;MSGID&quot;}
		// [i] field:0:required rowid {&quot;can&quot;,&quot;be&quot;,&quot;a&quot;,&quot;string&quot;,&quot;too&quot;}
		// [i] field:0:required colname {&quot;column&quot;,&quot;to&quot;,&quot;display&quot;,&quot;can&quot;,&quot;be&quot;,&quot;a&quot;,&quot;blob&quot;}
		// [i] field:0:required jdbctype {&quot;valid&quot;,&quot;constant&quot;,&quot;from&quot;,&quot;java.sql.Types&quot;}
		// [i] field:0:optional charset {&quot;defaults&quot;,&quot;to&quot;,&quot;'UTF-8'&quot;,&quot;if&quot;,&quot;not&quot;,&quot;specified&quot;}
    
    try {
    	String pkname = in.getString( "pkname" );
    	String rowid = in.getString( "rowid" );
    	String colname = in.getString( "colname" );
    	int jdbctype = in.getInt( "jdbctype" );
    	String charset = in.getString( "charset" );

	// invoke service
		//The ctor parameter is the spring bean config name for Audit Transaction events
    	MediatorAuditLogReader alr = new MediatorAuditLogReader( "AuditTransactionFormatter" );
    	IData fieldValue = alr.readFieldValue( pkname, rowid, colname,jdbctype,charset);

    	out.put( "fieldValue", fieldValue );
      
    } catch( Throwable ex )
    {
        // The HTML pages can't contain the <> of wrapped exceptions
        // So this code replaces the <> with []
        String message = ex.toString();
        message = message.replace( '<', '[' );
        message = message.replace( '>', ']' );
        out.put( "message", message );
 
        ex.printStackTrace();

    }

		// --- <<IS-END>> ---
        return out;
                
	}
}

