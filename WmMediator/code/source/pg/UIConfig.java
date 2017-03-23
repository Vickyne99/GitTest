package pg;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2010-12-01 11:14:15 EST
// -----( ON-HOST: MCUSAWCO01.AME.ad.sag

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.cert.X509Certificate;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.StringTokenizer;

import javax.xml.datatype.XMLGregorianCalendar;
import javax.xml.namespace.QName;

import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.OMXMLBuilderFactory;

import com.softwareag.pg.aliases.AbstractAlias;
import com.softwareag.pg.aliases.Alias;
import com.softwareag.pg.aliases.EndpointAlias;
import com.softwareag.pg.aliases.esbalias.ESBServiceAlias;
import com.softwareag.pg.aliases.securealias.AuthenticationTypes;
import com.softwareag.pg.aliases.securealias.SecureAlias;
import com.softwareag.pg.aliases.store.AliasesBeanHelpher;
import com.softwareag.pg.aliases.xsltalias.XSLTAlias;
import com.softwareag.pg.config.VersioningUtils;
import com.softwareag.pg.consumers.Consumer;
import com.softwareag.pg.consumers.ConsumerManager;
import com.softwareag.pg.consumers.RegisteredConsumerNamesManager;
import com.softwareag.pg.consumers.utils.IPRange;
import com.softwareag.pg.logging.PGLoggingResources;
import com.softwareag.pg.service.manager.ServiceManager;
import com.softwareag.pg.ui.FilePropertiesManager;
import com.softwareag.pg.ui.PortsConfigRetriever;
import com.softwareag.pg.ui.ServiceFaultConfigController;
import com.softwareag.pg.ui.ServiceInfo;
import com.softwareag.pg.ui.ServicesRetriever;
import com.softwareag.pg.util.ConfigUtil;
import com.softwareag.pg.util.XMLUtils;
import com.webmethods.sc.logging.log4j.WmJournalLogger;
import com.wm.app.b2b.server.InvokeState;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataFactory;
import com.wm.data.IDataUtil;
import com.wm.lang.ns.NSPackage;
import com.wm.lang.ns.NSService;
import com.wm.security.keystore.ISKeyStoreManager;
import com.wm.util.Values;

// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class UIConfig

{
	// ---( internal utility methods )---

//	final static UIConfig _instance = new UIConfig();

	static UIConfig _newInstance() { return new UIConfig(); }

	static UIConfig _cast(Object o) { return (UIConfig)o; }

	static final PGLoggingResources LOG_RES =
            new PGLoggingResources(UIConfig.class,
                    PGLoggingResources.LoggingFacility.CORE_RUNTIME);
    static  WmJournalLogger logger = LOG_RES.logger();
	// ---( server methods )---




	public static final void getAliases (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getAliases)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		//System.out.println("******Getting aliases ******"); 
		IDataCursor cur = pipeline.getCursor();
		boolean ksName = cur.first("keyStore");
		String keystore = "";
		if (ksName) {
		      keystore = (String) cur.getValue();       
		}
		else {
		  //get the aliases for the current keystore handle in the UI 
		  boolean ksHandlePresent = cur.first("pg.keystore.keyStoreHandle");
		  if (ksHandlePresent) {
		      keystore = (String) cur.getValue();
		  }
		
		}
		
		//System.out.println("Getting alias for keystore handle : (" + keystore + ")" );
		
		if (keystore!=null && keystore.length()>0) {
		 try {
		            ISKeyStoreManager ksMgr = ISKeyStoreManager.getInstance();
		            String[] ks = ksMgr.listKeyAliases(keystore);
		
			    IData[] names = new IData[ks.length];
		
			    for (int i=0; i<ks.length; i++) {		
				names[i] = IDataFactory.create();
				names[i].getCursor().insertAfter("name", ks[i]);
			    }
		
			    pipeline.getCursor().insertAfter(ALIAS_NAMES, names);
		
		        } catch (Exception e) {
		        	logger.error("0010.0871", new Object[]{ e.getMessage()},e);
		        }
		}
		// --- <<IS-END>> ---

                
	}



	public static final void getConfigProps (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getConfigProps)>> ---
		// @subtype unknown
		// @sigtype java 3.5
			Object o = ConfigUtil.getInstance().getBean("filePropertiesManager");
			  if (o != null && o instanceof FilePropertiesManager) {
				  FilePropertiesManager mgr = (FilePropertiesManager) o;
		
				  mgr.setRefresh(true);
				  Properties props = mgr.getProperties();
		
				  if (props != null) {
					  IDataCursor dc = pipeline.getCursor();
					  Set<Map.Entry<Object, Object>> entries = props.entrySet();
					  for (Map.Entry entry : entries) {
						  String pname = (String) entry.getKey();
						  String pval = (String) entry.getValue();
		
						  dc.insertAfter(pname, pval);
					  }
				  } 
			  }
		// --- <<IS-END>> ---
                
	}



	public static final void getConsumers (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getConsumers)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		IDataCursor mainCursor = pipeline.getCursor();
		       ConsumerManager mgr = ConsumerManager.getInstance();
		       if (mgr != null) {
		           Collection<Consumer> consumers = mgr.getAllConsumers();
		
		           if (consumers != null) {
		
		               IData[] conArray = new IData[consumers.size()];  //array of consumer IData
		               int x = 0;
		               for (Consumer con: consumers) {
		                   conArray[x] = IDataFactory.create();       //create a consumer IData to store consumer info
		                   IDataCursor cursor = conArray[x].getCursor();
		
		                   IDataUtil.put(cursor, "idx", x);
		                   
		                   String name = con.getName();
		                   IDataUtil.put(cursor, "name", name);        //store name
		
		                   String desc = con.getDescription();
		                   IDataUtil.put(cursor, "description", desc); //store description
		                   
		                   String partnerID = con.getPartnerID();
		                   IDataUtil.put(cursor, "partnerid", partnerID); //store description
		
		                   List<String> tokens = con.getTokens();
		                   processTokens(tokens, cursor);              //store the tokens
		
		                   Collection<IPRange> ranges = con.getIPRanges();
		                   processIPRanges(ranges, cursor);            //store the IP ranges
		
		                   XMLGregorianCalendar created = con.getCreated();
		                   IDataUtil.put(cursor, "created", getFormattedDate(created));     //store created date
		
		                   XMLGregorianCalendar modified = con.getModified();
		                   IDataUtil.put(cursor, "modified", getFormattedDate(modified));  //store modified date
		
		                   X509Certificate cert = con.getConsumerCert();
		                   processCert(cert, cursor);                   //store the cert if present
		
		                   x++;
		               }
		               mainCursor.insertAfter("consumers", conArray);   //store all the consumer IData array into main cursor
		           }
		       }
		// --- <<IS-END>> ---

                
	}



	public static final void getKeystoreNames (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getKeystoreNames)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		IDataCursor cursor = pipeline.getCursor();
		String ksHandle = (String) IDataUtil.get(cursor, "pg.keystore.keyStoreHandle");
		
		boolean isExisting = false;
		
			try {
		            ISKeyStoreManager ksMgr = ISKeyStoreManager.getInstance();
		            String[] ks = ksMgr.listKeyStoreNames();
		
			    IData[] names = new IData[ks.length];
		
			    for (int i=0; i<ks.length; i++) {		
				names[i] = IDataFactory.create();
				names[i].getCursor().insertAfter("name", ks[i]);
				
				if (ks[i].equals(ksHandle)) isExisting = true;
			    }
			    cursor.insertAfter(KEY_STORES, names);
		
		
			if (!isExisting) {
			   IDataUtil.put(cursor, "pg.keystore.keyStoreHandle", ks[0]);
			}
		
		        } catch (Exception e) {
		        	logger.error("0010.0871", new Object[]{ e.getMessage()},e);
		        }
		
		// --- <<IS-END>> ---

                
	}



	public static final void getMenu (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getMenu)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		IDataCursor pipelineCursor = pipeline.getCursor();
				
			IDataUtil.put( pipelineCursor, "text", "Mediator" );
				
			InvokeState currState = InvokeState.getCurrentState();
		        if ( currState != null ) {
		            NSService currService = InvokeState.getCurrentService();
		            if ( currService != null ) {
		                NSPackage currPkg = (NSPackage) currService.getPackage();
		                if ( currPkg != null ) {
				        String pkgName = currPkg.getName();
					IDataUtil.put( pipelineCursor, "url", "/"+pkgName );  //home page
			        }
		            }
		         }
			IDataUtil.put(pipelineCursor, "target", "rightSide");
				
			pipelineCursor.destroy();
		// --- <<IS-END>> ---

                
	}



	public static final void getPorts (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getPorts)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		    //set the selected https ports
		PortsConfigRetriever.loadPorts(pipeline);
		    //
		
		
			
		// --- <<IS-END>> ---

                
	}



	public static final void getPrimaryPort (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getPrimaryPort)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		PortsConfigRetriever.getPrimaryPort(pipeline);
			
		// --- <<IS-END>> ---

                
	}



	public static final void getServiceFaultConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getServiceFaultConfig)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required pg.providerFault.reason
		// [i] field:0:required pg.providerFault.enabled
		// [o] field:1:required messages
		// [o] field:0:required count
		
		// server side exceptions are caught and returned as output 
		// pipeline variables.
		
		ServiceFaultConfigController.getServiceFaultConfig(pipeline);
		// --- <<IS-END>> ---

                
	}



	public static final void getServices (IData pipeline)
        throws ServiceException
 {
        // --- <<IS-START(getServices)>> ---
        // @subtype unknown
        // @sigtype java 3.5
        List<ServiceInfo> servicesInfo = ServicesRetriever.get().getServicesInfo();

        IData[] services = new IData[servicesInfo.size()];
        int i = 0;
        for (ServiceInfo si : servicesInfo) {
            IData data = IDataFactory.create();
            IDataCursor dc = data.getCursor();
            dc.insertAfter("idx", i);
            dc.insertAfter("display-name", si.getDisplayName());
            if (si.getVersion() != null) {
                String versionInfo = "(" + si.getVersion() + ")";
                dc.insertAfter("version", versionInfo);
            }
            dc.insertAfter("rest-stack-used", si.isRestStackUsed());
            dc.insertAfter("service-type", si.getType().getDisplayName());
            dc.insertAfter("name", si.getName());
            dc.insertAfter("url", si.getUrl());
            dc.insertAfter("description", si.getDescription());
            dc.insertAfter("consumers", si.getConsumers());
            dc.insertAfter("operations", si.getOperations());
            if (si.getWsdlUrl() != null) {
                dc.insertAfter("wsdlUrl", si.getWsdlUrl() + "?wsdl");
                // dc.insertAfter("wsdlXml", si.getWsdlXml());
            }
            services[i++] = data;
        }

        pipeline.getCursor().insertAfter("services", services);
        // --- <<IS-END>> ---


 }



	public static final void getTrustStoreNames (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getTrustStoreNames)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		try {
			ISKeyStoreManager ksMgr = ISKeyStoreManager.getInstance();
			String[] ts = ksMgr.listTrustStoreNames();
		
			IData[] names = new IData[ts.length];
		
			for (int i=0; i<ts.length; i++) {
				names[i] = IDataFactory.create();
				names[i].getCursor().insertAfter("name", ts[i]);
			}
		
			pipeline.getCursor().insertAfter(TRUST_STORES, names);
		
		     } catch (Exception e) {
		    	 logger.error("0010.0871", new Object[]{ e.getMessage()},e);
		     }
		// --- <<IS-END>> ---

                
	}



	public static final void getVSD (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getVSD)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		IDataCursor cur = pipeline.getCursor();
		boolean isNamePresent = cur.first("serviceName");
		if (isNamePresent) {
		   String svcName = (String)cur.getValue();
		   String vsd = ServicesRetriever.get().getVSD(svcName);
		   cur.insertAfter("vsd", vsd);
		}
		else {
		  System.out.println("service name not set in request...");
		}
		
		// --- <<IS-END>> ---

                
	}



	public static final void getWSDL (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(getWSDL)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		IDataCursor cur = pipeline.getCursor();
		boolean isNamePresent = cur.first("serviceName");
		if (isNamePresent) {
		   String svcName = (String)cur.getValue();
		   String wsdl = ServicesRetriever.get().getWSDL(svcName);
		   cur.insertAfter("wsdl", wsdl);
		}
		else {
		  System.out.println("pg.UIConfig:getWSDL -- service name not set in request...");
		}
		// --- <<IS-END>> ---

                
	}



	public static final void initUI (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(initUI)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		try {
		
		//add an entry to the list of the menu's that will be shown in IS Admin page
		   Values values = new Values();
		
		   //this callback method gets called to init menu
		   values.put("callback", "pg.UIConfig:getMenu"); 
		
		   Service.doInvoke("wm.server.ui", "addSolution", values);
		
		
		}catch (Exception e) {
			logger.error("0010.0871", new Object[]{ e.getMessage()},e);
		}
		// --- <<IS-END>> ---

                
	}



	public static final void saveConfigProps (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(saveConfigProps)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		Object o = ConfigUtil.getInstance().getBean("filePropertiesManager");
		
		if (o != null && o instanceof FilePropertiesManager) {
			FilePropertiesManager mgr = (FilePropertiesManager) o;
			IDataCursor cursor = pipeline.getCursor();
			if (cursor != null) cursor.first();
		
			Properties newProps = new Properties();
		
			while (cursor.hasMoreData()) {
				String key = cursor.getKey();
				Object val = cursor.getValue();	
			
				newProps.put(key, val);
				cursor.next();
			}		
		
			//save the props to file
			mgr.saveProperties(newProps);
			
			String[] msgs = mgr.getMessages();
			
			IData[] values = new IData[msgs.length];
			if (msgs.length > 0) {
				for (int i=0; i<msgs.length; i++) {
					values[i] = IDataFactory.create();
					values[i].getCursor().insertAfter("message", msgs[i]);
				}
			}			
		
			cursor.last();
			IDataUtil.put(cursor, "messages", values);
			IDataUtil.put(cursor, "count", msgs.length);
		}
			
		// --- <<IS-END>> ---

                
	}



	public static final void saveServiceFaultConfig (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(saveServiceFaultConfig)>> ---
		// @subtype unknown
		// @sigtype java 3.5
		// [i] field:0:required pg.providerFault.reason
		// [i] field:0:required pg.providerFault.enabled
		// [o] field:1:required messages
		// [o] field:0:required count
		
		// server side exceptions are caught and returned as output 
		// pipeline variables.
		
		ServiceFaultConfigController.saveServiceFaultConfig(pipeline);
		// --- <<IS-END>> ---

                
	}
	
	public static final void getAPIKeys (IData pipeline)
    	throws ServiceException
    {
		// --- <<IS-START(getAPIKeys)>> ---
		// @sigtype java 3.5
		IDataCursor mainCursor = pipeline.getCursor();
		ConsumerManager mgr = ConsumerManager.getInstance();
		if (mgr != null) {			   
	      
	       Collection<Consumer> consumers = mgr.getAllApiKeys();
	
	       if (consumers != null) {
	    	   IData[] conArray = new IData[consumers.size()];  //array of consumer IData
	           int x = 0;
	           for (Consumer con: consumers) {
	               conArray[x] = IDataFactory.create();       //create a consumer IData to store consumer info
	               IDataCursor cursor = conArray[x].getCursor();
	               
	             
	               IDataUtil.put(cursor, "idx", x);
	               String name = con.getName();
	               IDataUtil.put(cursor, "name", name);        //store name
	               
	               String key=con.getKey();
	               IDataUtil.put(cursor, "key", key);
	               
	               
	               String apiKey = con.getApiKey().toString();
	               
	
	               RegisteredConsumerNamesManager   rcnMgr = (RegisteredConsumerNamesManager) ConfigUtil.getInstance().getBean(RegisteredConsumerNamesManager.DEFAULT_NAME);
	               String serviceKeyForApiKey = rcnMgr.getServiceNameForApiKey(apiKey);
                   String serviceNameForApiKey = getServiceNameWithVersion(serviceKeyForApiKey);
	               IDataUtil.put(cursor, "serviceNameForApiKey", serviceNameForApiKey);

	               
	               String clientname = con.getClientName();
	               IDataUtil.put(cursor, "clientname", clientname);
	               
	               String desc = con.getDescription();
	               IDataUtil.put(cursor, "description", desc); //store description
	              		               
	               String partnerID = con.getPartnerID();
	               IDataUtil.put(cursor, "partnerid", partnerID); //store description
	               		
	               List<String> tokens = con.getTokens();
	               processTokens(tokens, cursor);              //store the tokens
	
	               Collection<IPRange> ranges = con.getIPRanges();
	               processIPRanges(ranges, cursor);            //store the IP ranges
	
	               XMLGregorianCalendar created = con.getCreated();
	               IDataUtil.put(cursor, "created", getFormattedDate(created));     //store created date
	
	               XMLGregorianCalendar modified = con.getModified();
	               IDataUtil.put(cursor, "modified", getFormattedDate(modified));  //store modified date
	               
	               XMLGregorianCalendar expired= con.getExpirationDate();
	               IDataUtil.put(cursor, "expired", getFormattedDate(expired));   
	               
	               
	               X509Certificate cert = con.getConsumerCert();
	               processCert(cert, cursor);                   //store the cert if present
	               x++;		               
	           }
	           mainCursor.insertAfter("consumers", conArray);   //store all the consumer IData array into main cursor
	       }
	      
	   }
	  
		// --- <<IS-END>> ---

            
    }
	
	
	public static final void getOAuth2Tokens (IData pipeline)
    	throws ServiceException
    {
		// --- <<IS-START(getOAuth2Tokens)>> ---
		// @sigtype java 3.5
		
		IDataCursor mainCursor = pipeline.getCursor();
		ConsumerManager mgr = ConsumerManager.getInstance();
		if (mgr != null) {			   
	      		      
	       Collection<Consumer> consumers = mgr.getOAuthConsumerManager().getAllOAuth2ConsumerWithClientIDs();
	
	       if (consumers != null) {
	    	   IData[] conArray = new IData[consumers.size()];  //array of consumer IData
	           int x = 0;
	           for (Consumer con: consumers) {
	               conArray[x] = IDataFactory.create();       //create a consumer IData to store consumer info
	               IDataCursor cursor = conArray[x].getCursor();
	
	               IDataUtil.put(cursor, "idx", x);
	               String name = con.getName();
	               IDataUtil.put(cursor, "name", name);        //store name
	               
	               String key=con.getKey();
	               IDataUtil.put(cursor, "key", key);
	               String oauthToken=  con.getKey();                             
		              	               
	               RegisteredConsumerNamesManager   rcnMgr = (RegisteredConsumerNamesManager) ConfigUtil.getInstance().getBean(RegisteredConsumerNamesManager.DEFAULT_NAME);
	               String serviceKeyForOauthToken = rcnMgr.getServiceNameForOAuth2Token(oauthToken);
                   String serviceNameForOauthToken = getServiceNameWithVersion(serviceKeyForOauthToken);
	               IDataUtil.put(cursor, "serviceNameForOauthToken", serviceNameForOauthToken);
	               
	               
	               String clientname = con.getClientName();
	               IDataUtil.put(cursor, "clientname", clientname); 
	              		
	               String clientid = con.getOAuth2ClientID();
	               IDataUtil.put(cursor, "clientid", clientid); 
	               
	               String desc = con.getDescription();
	               IDataUtil.put(cursor, "description", desc); //store description
	              		               
	               String partnerID = con.getPartnerID();
	               IDataUtil.put(cursor, "partnerid", partnerID); //store description
	               		
	               List<String> tokens = con.getTokens();
	               processTokens(tokens, cursor);              //store the tokens
	
	               Collection<IPRange> ranges = con.getIPRanges();
	               processIPRanges(ranges, cursor);            //store the IP ranges
	
	               XMLGregorianCalendar created = con.getCreated();
	               IDataUtil.put(cursor, "created", getFormattedDate(created));     //store created date
	               
	               XMLGregorianCalendar modified = con.getModified();
	               IDataUtil.put(cursor, "modified", getFormattedDate(modified));  //store modified date
	               
	               
	               XMLGregorianCalendar expired= con.getExpirationDate();
	               IDataUtil.put(cursor, "expired", getFormattedDate(expired));  
	               
	
	               X509Certificate cert = con.getConsumerCert();
	               processCert(cert, cursor);                   //store the cert if present    
	               
	               x++;                     
	           }
	           mainCursor.insertAfter("consumers", conArray);   //store all the consumer IData array into main cursor
	       }
	      
	   }
		
		// --- <<IS-END>> ---
            
	}

    private static String getServiceNameWithVersion(String serviceKey) {
        ServiceManager serviceManager = (ServiceManager) ConfigUtil.getInstance().getBean("globalServiceManager");
        com.softwareag.pg.service.Service service = serviceManager.get(serviceKey);
        return VersioningUtils.getServiceNameWithVersion(service);
    }

    public static final void getRuntimeAlias (IData pipeline)
    	throws ServiceException
    {
		// --- <<IS-START(getRuntimeAlias)>> ---
		// @sigtype java 3.5
	
		IDataCursor mainCursor = pipeline.getCursor();
		Collection<AbstractAlias> allAliases = AliasesBeanHelpher.getAliasesController().getAllAliases();
		if(allAliases != null){
			IData[] conArray = new IData[allAliases.size()];
			int x=0;
			for(AbstractAlias alias : allAliases) {
				conArray[x] = IDataFactory.create();
				IDataCursor cursor = conArray[x].getCursor();
				
				IDataUtil.put(cursor, "idx", x);
				String name = alias.getName();
				IDataUtil.put(cursor, "name", name);

				String description = alias.getDescription();
				IDataUtil.put(cursor, "description", description);

				String key = alias.getKey();
				IDataUtil.put(cursor, "key", key);
				
				String type = null;
				
				if (alias instanceof Alias) {
					type = "Simple Alias";
					
					String value = ((Alias) alias).getValue();
					IDataUtil.put(cursor, "value", value);

				} else if (alias instanceof EndpointAlias) {
					type = "Endpoint Alias";
					
					String keyalias = ((EndpointAlias) alias).getKeyAlias();
					IDataUtil.put(cursor, "keyalias", keyalias);

					String endpointvalue = ((EndpointAlias) alias)
							.getEndPointValue();
					IDataUtil.put(cursor, "endpointvalue", endpointvalue);

					String keystorealias = ((EndpointAlias) alias)
							.getKeystoreAlias();
					IDataUtil.put(cursor, "keystorealias", keystorealias);

					Integer readtimeout = ((EndpointAlias) alias)
							.getReadTimeout();
					IDataUtil.put(cursor, "readtimeout", readtimeout);

					Integer connectiontimeout = ((EndpointAlias) alias)
							.getConnectionTimeout();
					IDataUtil.put(cursor, "connectiontimeout",
							connectiontimeout);

					String headers = ((EndpointAlias) alias).getWssHeaders();
					IDataUtil.put(cursor, "headers", headers);

					String soapoptimization = ((EndpointAlias) alias)
							.getSoapOptimzation();
					IDataUtil.put(cursor, "soapoptimization", soapoptimization);

				} else if (alias instanceof SecureAlias) {
					type = "Secure Alias";
					
					AuthenticationTypes authenticationtypes = ((SecureAlias) alias).getAuthType();
					String authentication = authenticationtypes.value();
					IDataUtil.put(cursor, "authentication", authentication);

				} else if (alias instanceof ESBServiceAlias) {
					type = "WebMethodsISService Alias";
					
					String serviceName = ((ESBServiceAlias) alias).getServiceName();
					IDataUtil.put(cursor, "serviceName", serviceName);

				} else if (alias instanceof XSLTAlias) {
					type = "XSLT Alias";
				} 
				
				IDataUtil.put(cursor, "type", type);
				x++;
			}
			mainCursor.insertAfter("runtimealias", conArray);
		}
		
		// --- <<IS-END>> ---

            
    }
	
	public static final void saveConfigPropsFromUI (IData pipeline)
    	throws ServiceException
    {
		// --- <<IS-START(saveConfigPropsFromUI)>> ---
		// @sigtype java 3.5
		
		IDataCursor cursor = pipeline.getCursor();
		if (cursor != null) cursor.first();
		String s = (String) cursor.getValue();
		String allSettings = (String)IDataUtil.get(cursor, "settings");
		StringTokenizer st = new StringTokenizer(allSettings, "\n");
		while (st.hasMoreTokens()) {
			String token = st.nextToken();
			int eqPos = token.indexOf("=");
			if (eqPos > -1) {
				String value = token.substring(eqPos + 1).trim();
				String key = token.substring(0, eqPos).trim();
				cursor.insertAfter(key, value);
			}
		}
		saveConfigProps(pipeline);
			    
	// --- <<IS-END>> ---   
	}
	
	public static final void mainMenu (IData pipeline)
	throws ServiceException
	{
		// --- <<IS-START(mainMenu)>> ---
		// @sigtype java 3.5
		
		IDataCursor idc = pipeline.getCursor();
		String extension = IDataUtil.getString(idc, "extension");
		if (extension == null)
		{
			extension = "dsp";
		}

		Locale locale = InvokeState.getCurrentSession().getLocale();
		IData mainMenu = IDataFactory.create();
		IDataCursor midc = mainMenu.getCursor();

		IData id_sections[] = new IData[sections.length];

		for(int i = 0; i < sections.length; i++)
		{
			id_sections[i] = IDataFactory.create();
			IDataCursor sec = id_sections[i].getCursor();
			IData sub[] = null;

			ArrayList<IData> tempSub = new ArrayList<IData>();
			for(int j = 0; j < items[i].length; j++)
			{
				IData tempIData = null;
				tempIData = IDataFactory.create();
				IDataCursor sidc = tempIData.getCursor();

				sidc.insertAfter("name", items[i][j]);
				String text = null;
			    try {
			    	text = LOG_RES.newMessage(items_msgKey[i][j]).getMessage(locale);
			    } catch(Exception e) {
			    	logger.error("0010.0871", new Object[]{ e.getMessage()},e);
			    }
			    if(text == null || text.isEmpty()) {
			    	text = items[i][j];
			    }
			    sidc.insertAfter("text", text);
			    
				if(j < urls[i].length)
					sidc.insertAfter("url",  urls[i][j] + extension);
				else
					sidc.insertAfter("url", "");

				sidc.destroy();
				tempSub.add(tempIData);
			}
			sub = tempSub.toArray(new IData[0]);
			sec.insertAfter("name", sections[i]);
			
		    // Localize this with call to LOG_RES
			String text = null;
		    try {
		    	text = LOG_RES.newMessage(sections_msgKey[i]).getMessage(locale);
		    } catch(Exception e) {
		    	logger.error("0010.0871", new Object[]{ e.getMessage()},e);
		    }
		    if(text == null || text.isEmpty()) {
		    	text = sections[i];
			}
		    sec.insertAfter("text", text);
			sec.insertAfter("submenu",sub);
		}
		midc.insertAfter("sections",id_sections);
		midc.destroy();

		idc.insertAfter("buttonUrls", mainMenu);
		
	// --- <<IS-END>> --- 
	}


	// --- <<IS-START-SHARED>> ---
		public static final String KEY_STORES = "keyStoreNames";
		public static final String TRUST_STORES = "trustStoreNames";
	    public static final String ALIAS_NAMES = "aliasNames";

	private static String dateFormat = "yyyy-MM-dd HH:mm:ss z";  //SMGME-783 - use same fmt used by IS
	
		private static void processTokens(List<String> tokens, IDataCursor cur) {
	        if (tokens != null) {
	            IData[] toks = new IData[tokens.size()];
	            for (int i = 0; i < tokens.size(); i++) {
	                toks[i] = IDataFactory.create();
	                IDataUtil.put(toks[i].getCursor(), "token", tokens.get(i));
	            }
	            IDataUtil.put(cur, "tokens", toks);
	        }
	    }

	    private static void processIPRanges(Collection<IPRange> ranges, IDataCursor cur) {
	        if (ranges != null) {
	            IData[] ips = new IData[ranges.size()];
                int i=0;
	            for (IPRange range: ranges) {
	                ips[i] = IDataFactory.create();
	                IDataUtil.put(ips[i].getCursor(), "rangeFrom", range.getFrom() );
	                IDataUtil.put(ips[i].getCursor(), "rangeTo", range.getTo() );
                    i++;
	            }
	            IDataUtil.put(cur, "ranges", ips);
	        }
	    }
	
	    private static void processCert(X509Certificate cert, IDataCursor cur) {
	        if (cert != null) {
	            String serialNumber = cert.getSerialNumber().toString();
	            IDataUtil.put(cur, "serialNumber", serialNumber);
		    String issuerDN = cert.getIssuerDN().toString();
		    IDataUtil.put(cur, "issuerDN", issuerDN);
	
	            String subjDN = cert.getSubjectDN().toString();
	            IDataUtil.put(cur, "subjectDN", subjDN);
	        }
	    }
	
	    private static String getFormattedDate(XMLGregorianCalendar inCal) {
	        Date date = XMLUtils.toDate( inCal );
	        SimpleDateFormat sdf = new SimpleDateFormat(dateFormat);
	        return (date!=null? sdf.format(date): "");
	    }

		/**
		 * A pair of strings.
		 */
		static class StringPair {
			private String first_;
			private String second_;

			public StringPair(String first, String second) {
				first_ = first;
				second_ = second;
			}

			/**
			 * Returns the first element of this pair.
			 */
			public String first() {
				return first_;
			}

			/**
			 * Returns the second element of this pair.
			 */
			public String second() {
				return second_;
			}
		}

		/**
		 * A collection of menu sections.
		 */
		static class MenuSectionsList {
			private String[] sections_;
			private String[] sections_msgKey_;
			private String[][] items_;
			private String[][] items_msgKey_;
			private String[][] urls_;
			
			public MenuSectionsList(OMElement root) {
				Iterator sections = root.getChildrenWithLocalName("section");
				int secLength = getSize(sections);
				sections = root.getChildrenWithLocalName("section");
				sections_ = new String[secLength];
				sections_msgKey_ = new String[secLength];
				items_ = new String[secLength][];
				items_msgKey_ = new String[secLength][];
				urls_ = new String[secLength][];
				int i = 0;
				while(sections.hasNext()) {
					OMElement section = (OMElement) sections.next();
					sections_[i] = section.getAttributeValue(new QName("name"));
					sections_msgKey_[i] = section.getAttributeValue(new QName("msgDbKey"));
					Iterator subSections = section.getChildrenWithLocalName("subsection");
					int subsecLength = getSize(subSections);
					subSections = section.getChildrenWithLocalName("subsection");
					items_[i] = new String[subsecLength];
					items_msgKey_[i] = new String[subsecLength];
					urls_[i] = new String[subsecLength];
					int j = 0;
					while(subSections.hasNext()) {
						OMElement subSection = (OMElement) subSections.next();
						urls_[i][j] = subSection.getAttributeValue(new QName("url"));
						items_msgKey_[i][j] = subSection.getAttributeValue(new QName("msgDbKey"));
						items_[i][j] = subSection.getText();
						j++;
					}
					i++;
				}
			}

			public String[] sections() {
				return sections_;
			}

			public String[][] items() {
				return items_;
			}

			public String[][] urls() {
				return urls_;
			}

			public String[] sectionsMsgKey() {
				return sections_msgKey_;
			}

			public String[][] itemsMsgKey() {
				return items_msgKey_;
			}
		}

		static MenuSectionsList sectionsList = parseSecListFromFile();
		static String[] sections = sectionsList.sections();
		static String[] sections_msgKey = sectionsList.sectionsMsgKey();
		static String[][] items = sectionsList.items();
		static String[][] items_msgKey = sectionsList.itemsMsgKey();
		static String[][] urls = sectionsList.urls();

		private static MenuSectionsList parseSecListFromFile() {
			
			FileInputStream fis = null;
			try {
				String path = ConfigUtil.getInstance().getResourceByPath("resources/menu.xml");
				File file = new File(path);
				// File propFile = res.getFile();
				fis = new FileInputStream(file);
				
				OMElement root = OMXMLBuilderFactory.createOMBuilder(fis).getDocumentElement();
				
				return new MenuSectionsList(root);
			} catch (Exception e) {
				logger.error("0010.0871", new Object[]{ e.getMessage()},e);
			} finally {
				if(fis != null) {
					try {
						fis.close();
					} catch (IOException e) {
						logger.error("0010.0871", new Object[]{ e.getMessage()},e);
					}
				}
			}
			
			return null;
		}

		private static int getSize(Iterator iter) {
			int size = 0;
			while(iter.hasNext()) {
				size++;
				iter.next();
			}
			return size;
		}		
		
	// --- <<IS-END-SHARED>> ---
}

