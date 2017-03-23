package pub.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import wm.csp.util;
import biz.i2z.contentstore.IndexDefinition;

import com.sag.eform.repo.EContentRepository;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataFactory;
import com.wm.data.IDataUtil;

public final class content {
	// ---( internal utility methods )---

	final static content _instance = new content();

	static content _newInstance() { return new content(); }

	static content _cast(Object o) { return (content)o; }

	// ---( server methods )---

	/**
	 * The createContentID service is used to create a new content object within
	 * the CSP indicated by friendlyName. You can then add document files to
	 * that content object.
	 * 
	 * INPUTS:
	 *  nodeID       is a required String and it indicates the ID of the node
	 *               to which the content will be added. An example of which
	 *               can be seen in the Automobile Accident Claims sample
	 *               included with the CSP. E.g. the nodeID of "Automobile
	 *               Accident Claims" is 8.
	 *  friendlyName is a required String that indicates the CSP server where the
	 *               above nodeID is located.
	 *  metadataMap  is an optional HashMap<String,String>, OR String, that should
	 *               contain a collection of key-value pairs, which represent
	 *               metadata about the created node. This can be either a String
	 *               in the form of comma separated key=value pairs, e.g.
	 *               "key1=value1, key2=value2, etc", or a HashMap<String, String>
	 *               with key-value pairs entered at each map index/position. Thus,
	 *               the user can associate any desired metadata key-value pairs
	 *               with the created contentID.
	 * 
	 * OUTPUTS:
	 *  contentID    is a String representing a GUID.
	 *  status       is a String indicating success or failure.
	 */
	public static final void createContentID(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(createContentID)>> ---
		// @sigtype java 3.5
		// [i] field:0:required nodeID
		// [i] field:0:required friendlyName
		// [i] object:0:required metadataMap
		// [o] field:0:required contentID
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String nodeID = IDataUtil.getString(cursor, "nodeID");
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		Object metadataMap = IDataUtil.get(cursor, "metadataMap");
		cursor.destroy();
		String status = "";
		String contentID = null;
		if (metadataMap instanceof String) {
			String stringMap = (String) metadataMap;
			metadataMap = new HashMap<String, String>();
			stringMap = stringMap.replaceAll("}", "");
			String[] mapValues = stringMap.split(",");
			for (String valuePair : mapValues) {
				valuePair = valuePair.substring(1);
				System.out.println(valuePair);
				String[] keyPair = valuePair.split("=");
				String key = keyPair[0];
				String value = keyPair[1];
				((HashMap<String, String>) metadataMap).put(key, value);
			}
		}

		// get the repo, based upon its friendlyName
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
		} catch (Exception e1) {
			; // nothing to do; the null repo is handled nicely next
		}

		if (repo == null) {
			status = "Failed: Repository (" + friendlyName
					+ ") not configured, please first run addConnection.";
		} else {
			try {
				if (!repo.isLive()) {
					repo.getRepo();
				}
				contentID = repo.getNewContentID();
				int[] nodeIDs = { Integer.valueOf(nodeID) };
				String[] fileNames = { "" };
				repo.storeContent(contentID, nodeIDs, fileNames, true);
				if (metadataMap != null) {
					repo.addMetadata(contentID,
							(HashMap<String, String>) metadataMap);
				}
				status = "Successful: ContentID created " + contentID
						+ " in node(" + nodeID + ").";
			} catch (Exception e) {
				StringWriter result = new StringWriter();
				PrintWriter printWriter = new PrintWriter(result);
				e.printStackTrace(printWriter);
				util.logger.error(result.toString());
				e.printStackTrace();
				status = "Failed: Unable to create new ContentID.";
			}
		}
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "status", status);
		IDataUtil.put(cursor, "contentID", contentID);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The createFilter service creates a new document filter.
	 * 
	 * Here is a snippet of useful text from the
	 * 8-2-SP2_Implementing_CSP_for_BPM.pdf doc:
	 * 
	 * In an enterprise of any size, a content repository can quickly collect a
	 * very large number of files so many that it can be difficult and
	 * time-consuming to browse through the repository to find exactly what you
	 * are looking for. webMethods Content Service Platform (CSP) provides you
	 * with the ability to define one or more content filters; when you create
	 * the filter, you specify exactly what document types are to be displayed
	 * to the filter user. This enables you to provide a customized view into
	 * the repository that shows only the document types of interest.
	 * 
	 * The user interacts with content filters in Software AG Designer. When you
	 * choose to create an IS document type from a content type in your CSP
	 * repository, the initial selection list contains all of the available
	 * content filters for that repository. After selecting the appropriate
	 * content filter, you can then locate and select the specific document type
	 * you want to work with. To assist the user with filter selection, be sure
	 * to name your content filters clearly, and to include appropriate
	 * description information. Content filters are created in My webMethods;
	 * you must have the Content Service Platform Configuration interface
	 * installed to carry out this procedure. If this interface is not
	 * installed, you can install it with the Software AG Installer.
	 * 
	 * INPUTS:
	 *  friendlyName          is a required String indicating the identifier
	 *                        associated with the CSP server where the filter
	 *                        is being added.
	 *  cspFilterFriendlyName is a required String indicating the friendly name
	 *                        that the user associates with the created filter.
	 *  nodeIDs               is a required String that indicates the ID of the
	 *                        node being filtered for. An example of which can
	 *                        be seen in the Automobile Accident Claims sample
	 *                        included with the CSP. E.g. the nodeID of
	 *                        "Automobile Accident Claims" is 8.
	 * 
	 * OUTPUTS:
	 *  status                is a String indicating success or failure.
	 */
	public static final void createFilter(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(createFilter)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [i] field:0:required cspFilterFriendlyName
		// [i] field:0:required nodeIDs
		// [o] field:0:required status
		try {
			if (pipeline != null) {
				IDataCursor pipeCursor = pipeline.getCursor();
				try {
					String status = "Success";
					String cspFriendlyName = IDataUtil.getString(pipeCursor,
							"friendlyName");
					Object nodeIDs = IDataUtil.get(pipeCursor, "nodeIDs");
					EContentRepository repo = util.getRepo(cspFriendlyName);
					if (repo != null && nodeIDs != null) {
						if (!repo.isLive()) {
							repo.getRepo();
						}
						IDataUtil.put(pipeCursor, "nodeIDs",
								util.convertObjectToStringArray(nodeIDs));
						String cspFilterFriendlyName = IDataUtil.getString(pipeCursor,
								"cspFilterFriendlyName");
						IDataUtil
								.put(pipeCursor, "friendlyName", cspFilterFriendlyName);
						pipeCursor.destroy();
						((EContentRepository) repo).storeDocFilter(pipeline);
					}
					if (repo == null) {
						status = "Failed: to create connection to CSP server. Server is down or invalid connection details.";
					} else if (nodeIDs == null) {
						status = "Failed: the required input 'nodeIDs' was not provided.";
					}
					IDataUtil.put(pipeCursor, "status", status);
				} catch (Exception e) {
					throw e;
				} finally {
					if (pipeCursor != null)
						pipeCursor.destroy();
				}
			}
		} catch (Exception e) {
			StringWriter result = new StringWriter();
			PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);
			util.logger.error(result.toString());
		}
		// --- <<IS-END>> ---

                
	}

	/**
	 * The createListener service creates a new CSP listener that is used to
	 * start a process created in Designer.
	 * 
	 * This service does what can also be done in MWS, i.e. this service creates
	 * a listener similar to what is currently done in MWS under Administration
	 * > System-Wide > Content Configurator.
	 * 
	 * Here is a snippet from 8-2-SP2_Implementing_CSP_for_BPM.pdf doc:
	 * 
	 * Although a content repository can simply collect and hold various files
	 * relevant to your line of business, the value of that content increases
	 * tremendously when you can integrate it with your automated business
	 * processes. webMethods Content Service Platform (CSP) provides you with
	 * the ability to define one or more content listeners; when you create the
	 * listener, you specify exactly what repository location and document types
	 * you want the listener to monitor.
	 * 
	 * Within a repository, documents are stored in a hierarchical archive
	 * structure, referred to as a content hierarchy tree. Each location, or
	 * hierarchical level of the tree, can also be referred to as a node.
	 * Document types are usually the lowest level of the tree.
	 * 
	 * You can configure a listener to monitor the specified location and
	 * document types for any or all of these actions: creation, deletion,
	 * updating, and deactivation. By linking the listener to a webMethods
	 * business process model, you can trigger a business process when the
	 * listener detects that any of the monitored actions has occurred. For
	 * example, the creation of a new Purchase Order document type could be used
	 * to trigger an order handling process.
	 * 
	 * INPUTS:
	 *  friendlyName             is a required String indicating the identifier
	 *                           associated with the CSP server's connection to
	 *                           which the listener is being added.
	 *  cspListenerFriendlyName  is a required String indicating the friendly
	 *                           name that the user associates with the created
	 *                           listener.
	 *  eventType                is a required String that contains a comma
	 *                           separated string comprised of one or more of
	 *                           CREATE, DELETE, UPDATE, and DEACTIVATE.
	 *  nodeIDs                  is a required String that indicates the ID of
	 *                           the node being listened to. An example of which
	 *                           can be seen in the Automobile Accident Claims sample
	 *                           included with the CSP. E.g. the nodeID of "Automobile
	 *                           Accident Claims" is 8.
	 *  searchFilter             searchFilter is a required String indicating which
	 *                           specific indexID value is being listened to. It needs
	 *                           to be formated like
	 *                                 ({$IndexID} operator value) <join clause>.
	 *                           Two examples are:
	 *                                1) "Driver Last Name ~ *" and
	 *                                2) "({$200000009} > 06.08.2012) AND".
	 *  isName                   is a required String that contains the same value used
	 *                           in the isName input to createISServerForListener, i.e.
	 *                           createListener will create a listener on the IS specified
	 *                           by this isName value.
	 *  description              is an optional String description of the listener being
	 *                           created.
	 * 
	 * OUTPUTS:
	 *  status                   is a String indicating success or failure.
	 */
	public static final void createListener(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(createListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [i] field:0:required cspListenerFriendlyName
		// [i] field:0:required eventType
		// [i] field:0:required nodeIDs
		// [i] field:0:optional searchFilter
		// [i] field:0:required isName
		// [i] field:0:optional description
		// [o] field:0:required status
		try {
			if (pipeline != null) {
				IDataCursor pipeCursor = pipeline.getCursor();
				IData createListener = IDataFactory.create();
				String cspServerFriendlyName = IDataUtil.getString(pipeCursor,
						"friendlyName");
				String cspFriendlyName = IDataUtil.getString(pipeCursor,
						"cspListenerFriendlyName");
				Object crudValues = IDataUtil.get(pipeCursor, "eventType");
				Object cmpStartNodes = IDataUtil.get(pipeCursor, "nodeIDs");
				String searchFilter = IDataUtil.getString(pipeCursor,
						"searchFilter");
				Object isName = IDataUtil.get(pipeCursor, "isName");
				Object description = IDataUtil.get(pipeCursor, "description");
				String hiddenUpdate = IDataUtil.getString(pipeCursor,
						"hiddenUpdate");
				if ("Yes".equals(hiddenUpdate)) {
					crudValues = "CREATE";
				}
				pipeCursor.destroy();

				// Map<String, CRManager> repos = ListenerManager.getRepoIndex();
				IDataCursor listenerCursor = createListener.getCursor();
				IDataUtil.put(listenerCursor, "nodeIDs",
						util.convertObjectToStringArray(cmpStartNodes));
				IDataUtil.put(listenerCursor, "friendlyName", cspFriendlyName);
				IDataUtil.put(listenerCursor, "isName",
						util.convertObjectToStringArray(isName));
				IDataUtil.put(listenerCursor, "packageName",
						util.convertObjectToStringArray("wm.econtent.econtent"));
				IDataUtil.put(listenerCursor, "serviceName",
						util.convertObjectToStringArray("publishCSPEFormDoc"));
				IDataUtil.put(listenerCursor, "eventType",
						util.convertObjectToStringArray(crudValues));
				IDataUtil.put(listenerCursor, "enable",
						util.convertObjectToStringArray("No"));
				IDataUtil.put(listenerCursor, "description",
						util.convertObjectToStringArray(description));
				IDataUtil.put(listenerCursor, "filter", searchFilter);
				listenerCursor.destroy();
				EContentRepository repo = util.getRepo(cspServerFriendlyName);
				String status = "Success";
				if (repo != null) {
					if (!repo.isLive()) {
						repo.getRepo();
					}
					repo.storeListener(createListener);
				} else {
					status = "Failed: to create connection to CSP server. Server is down or invalid connection details.";
				}
				IDataUtil.put(pipeCursor, "status", status);
			}
		} catch (Exception e) {
			StringWriter result = new StringWriter();
			PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);
			util.logger.error(result.toString());
			e.printStackTrace();
		}
		// --- <<IS-END>> ---

                
	}

	/**
	 * The listAllContentDefinitions service is used to list all of the content
	 * definitions in CSP. Those content definitions are returned as a HashMap
	 * where the Key is the indexName, and the value is the indexID.
	 * 
	 * INPUTS:
	 *  friendlyName         is a required String indicating the identifier
	 *                       associated with the CSP server for which all content
	 *                       definitions are being listed.
	 * 
	 * OUTPUTS:
	 *  size                 is an integer that indicates the number of elements
	 *                       in the contentDefinitionMap HashMap.
	 *  contentDefinitionMap is a HashMap<String,String> of the content definitions
	 *                       in the form: {Automobile Accident Claims=8,
	 *                       IS Servers=1000011000, WM Notifications=1000011010, CSP=0,
	 *                       Templates=1000012000, Document Representations=1000013000,
	 *                       WM Document Filters=1000011020, System=1000000000}
	 *  status               is a String indicating success or failure.
	 */
	public static final void listAllContentDefinitions(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(listAllContentDefinitions)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [o] object:0:required contentDefinitionMap
		// [o] field:0:required size
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		cursor.destroy();
		String status = "";
		Map<String, String> contentDefinitionMap = null;

		// get the repo, based upon its friendlyName
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
		} catch (Exception e1) {
			; // nothing to do; the null repo is handled nicely next
		}

		if (repo == null) {
			status = "Failed: Repository (" + friendlyName
					+ ") not configured, please first run addConnection.";
		} else {
			try {
				if (!repo.isLive()) {
					repo.getRepo();
				}
				contentDefinitionMap = repo.getContentDefinitionMap();
				status = "Success: Retrieved Content Definition Map.";
			} catch (Exception e) {
				StringWriter result = new StringWriter();
				PrintWriter printWriter = new PrintWriter(result);
				e.printStackTrace(printWriter);
				util.logger.error(result.toString());
				status = "Failed: Could not retrieve Content Definition Map.";
			}
		}

		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "contentDefinitionMap", contentDefinitionMap);
		IDataUtil.put(cursor, "size", contentDefinitionMap.size());
		IDataUtil.put(cursor, "status", status);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The listAllIndexIDs service returns a list of all IndexIDs for the given
	 * nodeID. The user can use contents of the returned IndexMap for many of
	 * the other services.
	 * 
	 * INPUTS:
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server for which all Index IDs are being returned
	 *               for the given nodeID.
     *  nodeID       is a required String and it indicates the ID of the node
     *               to which the content will be added. An example of which can
     *               be seen in the Automobile Accident Claims sample included
     *               with the CSP. E.g. the nodeID of "Automobile Accident Claims" is 8.
	 * 
	 * OUTPUTS:
	 *  IndexMap     is a Map<String,Integer> indicating an indexName-to-indexID mapping,
	 *               e.g. {Driver Last Name=200000001, Policy Number=200000004}.
	 */
	public static final void listAllIndexIDs(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(listAllIndexIDs)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [i] field:0:required nodeID
		// [o] object:0:required IndexMap
		IDataCursor cursor = pipeline.getCursor();
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		String nodeID = IDataUtil.getString(cursor, "nodeID");
		cursor.destroy();
		Map<String, String> indexDefinitions = new HashMap<String, String>();

		// get the repo, based upon its friendlyName
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
		} catch (Exception e1) {
			; // nothing to do; the null repo is handled nicely next
		}

		if (repo != null) {
			try {
				if (!repo.isLive()) {
					repo.getRepo();
				}

				int id = Integer.valueOf(nodeID);
				ArrayList<IndexDefinition> indexDefs = repo.getIndexNames(id);
				for (IndexDefinition index : indexDefs) {
					String name = index.getName();
					String indexID = String.valueOf(index.getID());
					indexDefinitions.put(name, indexID);
				}
			} catch (Exception e) {
				StringWriter result = new StringWriter();
				PrintWriter printWriter = new PrintWriter(result);
				e.printStackTrace(printWriter);
				util.logger.error(result.toString());
			}
		}
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "IndexMap", indexDefinitions);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

