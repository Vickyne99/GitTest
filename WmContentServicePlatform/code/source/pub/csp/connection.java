package pub.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;

import wm.csp.util;

import com.sag.eform.repo.CSPConnection;
import com.sag.eform.repo.EContentRepository;
import com.wm.app.b2b.server.Server;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataFactory;
import com.wm.data.IDataUtil;

public final class connection {
	private final static String DEAD = "0";
	private final static String ALIVE = "1";

	// ---( internal utility methods )---

	final static connection _instance = new connection();

	static connection _newInstance() { return new connection(); }

	static connection _cast(Object o) { return (connection)o; }

	// ---( server methods )---

	/**
	 * The addConnection service is used to add a new CSP connection that the
	 * other services in the WmContentServicePlatform package can be executed
	 * against. The friendlyName, is the identifier for the added connection.
	 * 
	 * As a point of reference, the addConnection service creates connections
	 * similar to what is currently done in MWS under
	 * Administration>System-Wide>Environments>Define Environments wherein a
	 * user can add (and subsequently deploy) a Content Service Platform Server
	 * environment.
	 * 
	 * INPUTS:
	 *  host         is a required String indicating the CSP host name or IP
	 *               address to which the connection will be made.
	 *  port         is a required String indicating the CSP port; note for
	 *               the typical CSP install this value should be 9010.
	 *  userName     is a required String indicating the CSP user to be used
	 *               to connect to the CSP.
	 *  password     is a required String indicating the password associated
	 *               with the above CSP user.
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server's connection that is being added.
	 *  overwrite    is an optional String, which when true if the connection
	 *               characterized by friendlyName already exists, then it will
	 *               be replaced.
	 * 
	 * OUTPUTS:
	 * status        is a String indicating success or failure.
	 */
	public static final void addConnection(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(addConnection)>> ---
		// @sigtype java 3.5
		// [i] field:0:required host
		// [i] field:0:required port
		// [i] field:0:required userName
		// [i] field:0:required password
		// [i] field:0:required friendlyName
		// [i] field:0:required overwrite
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String host = IDataUtil.getString(cursor, "host");
		String port = IDataUtil.getString(cursor, "port");
		String userName = IDataUtil.getString(cursor, "userName");
		String password = IDataUtil.getString(cursor, "password");
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		boolean overwrite = IDataUtil.getBoolean(cursor, "overwrite", false);
		String status = "";
		cursor.destroy();
		EContentRepository repo = null;
		if (util.repoMap.get(friendlyName) != null) {
			if (overwrite) {
				try {
					CSPConnection connection = new CSPConnection(host, port,
							userName, password, friendlyName);
					repo = connection.getRepo();
					if (repo == null) {
						status = "Failed: Could not create a connection to the specified CSP server. The server is down or invalid connection details were provided.";
					} else {
						util.repoMap.put(friendlyName, connection);
						JAXBContext jc = JAXBContext
								.newInstance(CSPConnection.class);
						Marshaller marshaller = jc.createMarshaller();
						marshaller.setProperty(
								Marshaller.JAXB_FORMATTED_OUTPUT, true);
						File cfg = Server.getResources().getPackageConfigDir(
								"WmContentServicePlatform");
						File cfgFile = new File(cfg, friendlyName + util.EXT);
						marshaller.marshal(connection, cfgFile);
						status = "Success: Added connection to CSP.";
					}

				} catch (Exception e) {
					System.out.println(e.getMessage());
					StringWriter result = new StringWriter();
					PrintWriter printWriter = new PrintWriter(result);
					e.printStackTrace(printWriter);
					util.logger.error(result.toString());
					status = "Failed: to create connection to CSP server.";
				}
			} else {
				status = "Failed: The CSP server configuration already exists please set overwrite flag to true to overwrite it.";
			}
		} else {
			try {
				CSPConnection connection = new CSPConnection(host, port, userName,
						password, friendlyName);
				repo = connection.getRepo();
				if (repo == null) {
					status = "Failed: Could not create a connection to the specified CSP server. The server is down or invalid connection details were provided.";
				} else {
					util.repoMap.put(friendlyName, connection);
					JAXBContext jc = JAXBContext
							.newInstance(CSPConnection.class);
					Marshaller marshaller = jc.createMarshaller();
					marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT,
							true);
					File cfg = Server.getResources().getPackageConfigDir(
							"WmContentServicePlatform");
					File cfgFile = new File(cfg, friendlyName + util.EXT);
					marshaller.marshal(connection, cfgFile);
					status = "Success: Added connection to CSP: " + friendlyName + "[" + host + "@" + port + "]";
				}

			} catch (Exception e) {
				StringWriter result = new StringWriter();
				PrintWriter printWriter = new PrintWriter(result);
				e.printStackTrace(printWriter);
				util.logger.error(result.toString());
				e.printStackTrace();
				status = " Could not create a connection to the specified CSP server. The server is down or invalid connection details were provided.";
			}
		}
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "status", status);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The deleteConnection service is used to delete the CSP connection
	 * identified by the friendlyName
	 * 
	 * INPUTS:
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server's connection that is being deleted.
	 * 
	 * OUTPUTS:
	 *  status       is a String indicating success or failure.
	 */
	public static final void deleteConnection(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(deleteConnection)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();

		// get the repo to be deleted, based upon its friendlyName
		// and disconnect it.
		final String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
			if (repo != null) {
				repo.disconnect();
			}
		} catch (Exception e1) {
			; // nothing to do
		}

		// remove the csp definition from the repoMap
		String status = "";
		File cfg = Server.getResources().getPackageConfigDir(
				"WmContentServicePlatform");
		File cfgFile = new File(cfg, friendlyName + util.EXT);
		try {
			cfgFile.delete();
			util.repoMap.remove(friendlyName);
			status = "Success: Removed connection (" + friendlyName + ").";
		} catch (Exception e) {
			StringWriter result = new StringWriter();
			PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);
			util.logger.error(result.toString());
			status = "Failed: Could not delete Connection (" + friendlyName
					+ ").";
		}
		IDataUtil.put(cursor, "status", status);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The listConnections service returns an array of IData containing all
	 * connections available for use in this package.
	 * 
	 * INPUTS: no inputs
	 * 
	 * OUTPUTS:
	 *  connections       is a String[] of CSP friendlyNames; if there
	 *                    are no connections, then this is null.
	 *  connectionDetails is an IData[] where each element in the array
	 *                    is a connectionDetail object each of which
	 *                    contains: friendlyName, host, port, login
	 *                    (AKA userName), status (indicates if the
	 *                    connection is currently live), and message
	 *                    (for a dead/bad status a message is provided
	 *                    to indicate why).  The output provided in
	 *                    connectionDetails should be the same as was
	 *                    input to addConnection. If there are no
	 *                    connections, then this field is not output.
	 */
	public static final void listConnections(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(listConnections)>> ---
		// @sigtype java 3.5
		// [o] field:1:required connections
		// [o] object:1:required connectionDetails
		Set<String> friendlyNames = util.repoMap.keySet();
		IDataCursor cursor = pipeline.getCursor();
		if (friendlyNames != null) {
			IDataUtil.put(cursor, "connections", friendlyNames.toArray());
			List<IData> connectionIData = new ArrayList<IData>();
			IDataCursor repoCursor = null;
			String connStatus = DEAD;
			for (String key : friendlyNames) {
				try {
					CSPConnection repo = util.repoMap.get(key);

					// check if the connection is live
					try {
						EContentRepository eContentRepo = util.getRepo(key);
						if (eContentRepo != null) {
							if (eContentRepo.isLive()) {
								connStatus = ALIVE;
							} else {
								connStatus = DEAD;
							}
						}
					} catch (Exception e) {
						connStatus = DEAD;
					}

					IData connectionDetail = IDataFactory.create();
					repoCursor = connectionDetail.getCursor();
					IDataUtil.put(repoCursor, "friendlyName", key);
					IDataUtil.put(repoCursor, "host", repo.getHost());
					IDataUtil.put(repoCursor, "port", repo.getPort());
					IDataUtil.put(repoCursor, "userName", repo.getLogin());
					IDataUtil.put(repoCursor, "status", connStatus);
					repoCursor.destroy();
					connectionIData.add(connectionDetail);
				} catch (Exception e) {
					StringWriter result = new StringWriter();
					PrintWriter printWriter = new PrintWriter(result);
					e.printStackTrace(printWriter);
					util.logger.error(result.toString());
					e.printStackTrace();
				}
			}

			IData[] connectionDetails = new IData[connectionIData.size()];
			connectionIData.toArray(connectionDetails);
			IDataUtil.put(cursor, "connectionDetails", connectionDetails);
		} else {
			IDataUtil.put(cursor, "connections", null);
		}
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

