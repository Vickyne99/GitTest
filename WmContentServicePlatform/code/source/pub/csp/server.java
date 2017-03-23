package pub.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.List;

import wm.csp.util;

import com.sag.eform.repo.EContentRepository;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;

public final class server {
	// ---( internal utility methods )---

	final static server _instance = new server();

	static server _newInstance() { return new server(); }

	static server _cast(Object o) { return (server)o; }

	// ---( server methods )---

	/**
	 * The createISServerForListener creates an IS connection for listener
	 * events. The IS connection is created in the CSP indicated by
	 * friendlyName.
	 * 
	 * INPUTS:
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server's connection to which the IS listener
	 *               is being added.
	 *  isName       is a required String indicating the friendly name to be
	 *               associated with the IS.
	 *  host         is a required String indicating the actual IS host name
	 *               or IP.
	 *  port         is a required String indicating the actual IS port.
	 *  userName     is a required String indicating the user to be used to
	 *               connect to the IS.
	 *  isPassword   is a required String indicating the userName's password.
	 * 
	 * OUTPUTS:
	 *  status       is a String indicating success or failure.
	 */
	public static final void createISServerForListener(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(createISServerForListener)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [i] field:0:required isName
		// [i] field:0:required host
		// [i] field:0:required port
		// [i] field:0:required userName
		// [i] field:0:required isPassword
		// [o] field:0:required status
		if (pipeline != null) {
			IDataCursor pipeCursor = pipeline.getCursor();
			String host = IDataUtil.getString(pipeCursor, "host");
			String port = IDataUtil.getString(pipeCursor, "port");
			StringBuffer hostName = new StringBuffer();
			if (host != null && port != null) {
				hostName.append(host);
				hostName.append(":");
				hostName.append(port);
			}
			try {
				String status = "Sucess";
				IDataUtil.put(pipeCursor, "hostName", hostName.toString());
				String cspFriendlyName = IDataUtil.getString(pipeCursor,
						"friendlyName");
				EContentRepository repo = util.getRepo(cspFriendlyName);
				if (repo != null) {
					if (!repo.isLive()) {
						repo.getRepo();
					}
					repo.storeServerInformation(pipeline);
				} else {
					status = "Failed: to create connection to CSP server. Server is down or invalid connection details.";
				}
				IDataUtil.put(pipeCursor, "status", status);
			} catch (Exception e) {
				StringWriter result = new StringWriter();
				PrintWriter printWriter = new PrintWriter(result);
				e.printStackTrace(printWriter);
				util.logger.error(result.toString());
				e.printStackTrace();
			} finally {
				pipeCursor.destroy();
			}
		}
		// --- <<IS-END>> ---

                
	}

	/**
	 * The listAllISServers service returns list of all IS servers associated
	 * with the CSP indicated by the friendlyName.
	 * 
	 * INPUTS:
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server's connection.
	 * 
	 * OUTPUTS:
	 *  ISServerMap  is a HashMap<String,String> of the form:
	 *               [isName1, login1@hostname1][isName2, login2@hostname2][etc]
	 *  status       is a String indicating success or failure.
	 */
	public static final void listAllISServers(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(listAllISServers)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [o] object:0:required ISServerMap
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");

		// get the repo, based upon its friendlyName
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
		} catch (Exception e1) {
			; // nothing to do; the null repo is handled nicely next
		}

		cursor.destroy();
		List<IData> data = null;
		java.util.HashMap<String, String> isServersList = new java.util.HashMap();
		String status = "Success";
		try {
			if (repo != null) {
				if (!repo.isLive()) {
					repo.getRepo();
				}
				data = repo.listAllISServersIData();
			} else {
				status = "Failed: Repository (" + friendlyName
						+ ") not configured, please first run addConnection.";
			}
		} catch (Exception e) {
			StringWriter result = new StringWriter();
			PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);
			util.logger.error(result.toString());
			data = null;
		}

		if (data != null) {
			for (Iterator<IData> iter = data.iterator(); iter.hasNext();) {
				StringBuffer details = new StringBuffer();
				IData current = iter.next();
				cursor = current.getCursor();
				String isName = IDataUtil.getString(cursor, "isName");
				String login = IDataUtil.getString(cursor, "login");
				String hostName = IDataUtil.getString(cursor, "host");
				String date = IDataUtil.getString(cursor, "date");
				details.append(login);
				details.append("@");
				details.append(hostName);
				cursor.destroy();
				isServersList.put(isName, details.toString());
			}
		}
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "ISServerMap", isServersList);
		IDataUtil.put(cursor, "status", status);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

