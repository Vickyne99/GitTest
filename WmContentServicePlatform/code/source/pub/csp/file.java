package pub.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import wm.csp.util;

import com.sag.eform.repo.CSPContentObject;
import com.sag.eform.repo.EContentRepository;
import com.webmethods.sc.codec.Base64;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;

public final class file {
	// ---( internal utility methods )---

	final static file _instance = new file();

	static file _newInstance() { return new file(); }

	static file _cast(Object o) { return (file)o; }

	// ---( server methods )---

	/**
	 * The addFile service adds a new file into CSP, specified in friendlyName,
	 * creating a new contentID if one is not provided. Also, one or both of
	 * contentID and nodeID fields can be provided, but at least one needs to be
	 * provided; that is why BOTH are listed as required. If both are provided
	 * then the nodeID takes precedence. And if both are null then there will be
	 * a service error.
	 * 
	 * INPUTS:
	 *  contentID       is a required String; if the contentID is not provided,
	 *                  then one will be created at the provided nodeID.
	 *  fileName        is a required String that is the file name of the file to
	 *                  be added.
	 *  fileInputStream is a required String(Base64 encoded). It can be either the
	 *                  full path to the file to be added, OR or a Base64 encoded
	 *                  byte stream of the file to be added.
	 *  friendlyName    is a required String indicating the identifier associated
	 *                  with the CSP server where the file is being added.
	 *  nodeID          is a required String and it indicates the ID of the node to
	 *                  which the file will be added. An example of which can be seen
	 *                  in the Automobile Accident Claims sample included with the
	 *                  CSP. E.g. the nodeID of "Automobile Accident Claims" is 8.
	 *  metadataMap     is an optional HashMap<String,String>, OR String, that should
	 *                  contain a collection of key-value pairs, which represent
	 *                  metadata about the created node. This can be either a String
	 *                  in the form of comma separated key=value pairs, e.g.
	 *                  "key1=value1, key2=value2, etc", or a HashMap<String, String>
	 *                  with key-value pairs entered at each map index/position. Thus,
	 *                  the user can associate any desired metadata key-value pairs
	 *                  with the created contentID.
	 * 
	 * OUTPUTS:
	 *  contentID       is a String and it is the same passed-in contentID if one was
	 *                  provided. If one was not provided, then it is the created
	 *                  contentID.
	 *  fileID          is a String representing the ID of the file.
	 *  status          is a String indicating success or failure.
	 */
	public static final void addFile(IData pipeline) throws ServiceException {
		// --- <<IS-START(addFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required contentID
		// [i] field:0:required fileName
		// [i] field:0:required fileInputStream
		// [i] field:0:required friendlyName
		// [i] field:0:required nodeID
		// [i] object:0:optional metadataMap
		// [o] field:0:required contentID
		// [o] field:0:required fileID
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String contentID = IDataUtil.getString(cursor, "contentID");
		String fileName = IDataUtil.getString(cursor, "fileName");
		Object input = IDataUtil.get(cursor, "fileInputStream");
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		String nodeIDString = IDataUtil.getString(cursor, "nodeID");
		Object metadataMap = IDataUtil.get(cursor, "metadataMap");
		IDataUtil.remove(cursor, "metadataMap");
		cursor.destroy();
		InputStream stream = null;
		if (metadataMap instanceof String) {
			String stringMap = (String) metadataMap;
			metadataMap = new HashMap<String, String>();
			stringMap = stringMap.replaceAll("}", "");
			String[] mapValues = stringMap.split(",");
			for (String valuePair : mapValues) {
				valuePair = valuePair.substring(1);
				String[] keyPair = valuePair.split("=");
				String key = keyPair[0];
				String value = keyPair[1];
				((HashMap<String, String>) metadataMap).put(key, value);
			}
		}

		try {
			if (input instanceof String) {
				File file = new File((String) input);
				if (file.exists()) {
					stream = new FileInputStream(file);
				} else {
					byte[] bytes = Base64.decode(((String) input).getBytes());
					stream = new ByteArrayInputStream(bytes);
				}
			} else if (input instanceof InputStream) {
				stream = (InputStream) input;
			}
		} catch (Exception e) {
			StringWriter result = new StringWriter();
			PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);
			util.logger.error(result.toString());
			e.printStackTrace();
		}

		String status = "";
		CSPContentObject fileContent = null;
		String fileID = "";
		boolean contentValid = true;
		if (contentID == null) {
			if (nodeIDString == null) {
				contentValid = false;
			} else {
				content.createContentID(pipeline);
				cursor = pipeline.getCursor();
				contentID = IDataUtil.getString(cursor, "contentID");
				cursor.destroy();
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
		} else if (contentValid) {
			String[] fileNames = { fileName };
			String targetPath = "smi://" + friendlyName + "/tmp/" + fileName;
			if (repo != null) {
				try {
					if (!repo.isLive()) {
						repo.getRepo();
					}
					int nodeID;
					if (nodeIDString == null) {
						nodeID = repo.getNodeIDOfContentID(contentID);
					} else {
						nodeID = Integer.valueOf(nodeIDString);
					}
					int[] nodeIDs = { nodeID };
					repo.addObjectStream(contentID, nodeIDs, stream, fileNames,
							friendlyName, targetPath, new String[] { "" });
					if (metadataMap != null) {
						repo.addMetadata(contentID,
								(HashMap<String, String>) metadataMap);
					}
					String attachment = repo.getAttachmentID(contentID,
							fileName, true);
					fileContent = CSPContentObject.readXMLString(attachment,
							repo.getRetrieval(), repo.getSession());
					if (fileContent != null) {
						fileID = fileContent.getFileID();
					}
					status = "Success: Added " + fileName + " to " + contentID
							+ ".";
				} catch (Exception e) {
					StringWriter result = new StringWriter();
					PrintWriter printWriter = new PrintWriter(result);
					e.printStackTrace(printWriter);
					util.logger.error(result.toString());
					e.printStackTrace();
					status = "Failed: Unable to add File to contentID "
							+ contentID + ".";
				}
			}
		}
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "status", status);
		IDataUtil.put(cursor, "fileID", fileID);
		IDataUtil.put(cursor, "contentID", contentID);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The getFile service will retrieve only one file from the CSP based on the
	 * contentID and fileID pair.
	 * 
	 * INPUTS:
	 *  fileID       is a required String. The value used here represents the
	 *               index into the file list that comes back in the
	 *               retrieveFiles service. The value used here depends on what
	 *               position in the contentID it is located; this value is not
	 *               constant and you need to check the values returned in the
	 *               fileList field returned from retrieveFiles. This fileID
	 *               can be obtained from the fileList, which is one of the outputs
	 *               for retrieveFiles.
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server where the file is being added.
	 *  downloadDir  is a required String indicating the directory into which the
	 *               file indicated should be downloaded.
	 *  contentID    is a required String indicating the ID associated with the
	 *               file, e.g. 120823010432267c2dad94ac40354c3e.
	 * 
	 * OUTPUTS:
	 *  fileName     is a String and it is the name of the file.
	 *  status       is a String indicating success or failure.
	 */
	public static final void getFile(IData pipeline) throws ServiceException {
		// --- <<IS-START(getFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileID
		// [i] field:0:required friendlyName
		// [i] field:0:required downloadDir
		// [i] field:0:required contentID
		// [o] field:0:required fileName
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String fileID = IDataUtil.getString(cursor, "fileID");
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		String downloadDir = IDataUtil.getString(cursor, "downloadDir");
		String contentID = IDataUtil.getString(cursor, "contentID");
		cursor.destroy();
		String status = "";
		String[] fileNameList = null;

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
				fileNameList = repo.getContentObject(downloadDir, contentID,
						true, fileID);
				status = "Success: Retrieved Files for " + contentID
						+ "Downloaded to " + downloadDir + ".";
			} catch (Exception e) {
				StringWriter result = new StringWriter();
				PrintWriter printWriter = new PrintWriter(result);
				e.printStackTrace(printWriter);
				util.logger.error(result.toString());
				e.printStackTrace();
				status = "Failed: Unable to get files list.";
			}
		}

		cursor = pipeline.getCursor();
		if (fileNameList != null && fileNameList.length > 0) {
			CSPContentObject cspObject = CSPContentObject.readXMLString(
					fileNameList[0], repo.getRetrieval(), repo.getSession());
			IDataUtil.put(cursor, "fileName", cspObject.getOriginalFileName());
		} else {
			status = "Success: No files to retrieve.";
		}
		IDataUtil.put(cursor, "status", status);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The retrieveFiles service will, for a given content id, return all the
	 * files associated with that content id. <WHAT DOES THIS MEAN?>URLs
	 * returned with contentID and URL to download the item.</WHAT DOES THIS
	 * MEAN?> SPELLING ERROR IN SERVICE NAME. ALSO, THE downloadDir INPUT VALUE
	 * NEEDS TO BE REMOVED AS IT WAS A CUT AND PASTE ERROR BY HANK.
	 * 
	 * INPUTS:
	 *  contentID    is a required String indicating the ID associated with
	 *               the file, e.g. 120823010432267c2dad94ac40354c3e.
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server from which the files are being retrieved.
	 * 
	 * OUTPUTS:
	 *  fileList     is a List<CSPContentObject>. The CSPContentObject represents
	 *               the content object. Each content object has its own content
	 *               properties as well as a list of content objects. The structure
	 *               is organized as a tree.
	 *  status       is a String indicating success or failure.
	 */
	public static final void retrieveFiles(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(retrieveFiles)>> ---
		// @sigtype java 3.5
		// [i] field:0:required contentID
		// [i] field:0:required friendlyName
		// [o] object:1:required fileList
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String contentID = IDataUtil.getString(cursor, "contentID");
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		cursor.destroy();
		String status = "";

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
				CSPContentObject cSPContentObject = null;
				Set<CSPContentObject> fileObjects = new HashSet<CSPContentObject>();
				String[] filesList = repo.getFilesList(contentID);
				for (String fileObject : filesList) {
					cSPContentObject = CSPContentObject.readXMLString(
							fileObject, repo.getRetrieval(), repo.getSession());
					fileObjects.add(cSPContentObject);
				}
				status = "Success: Retrieved the files for " + contentID + ".";
				IDataUtil.put(cursor, "fileList", fileObjects.toArray());
			} catch (Exception e) {
				status = "Failed: Unable to get the files list.";
			}
		}

		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "status", status);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The updateFile service updates the file content and metadata of a file,
	 * which is associated with the provided contentID, and which is already
	 * present in CSP.
	 * 
	 * INPUTS:
	 *  fileID          is a required String. The value used here represents
	 *                  the index into the file list that comes back in the
	 *                  retrieveFiles service. The value used here depends on
	 *                  what position in the contentID it is located; this value
	 *                  is not constant and you need to check the values returned
	 *                  in the fileList field returned from retrieveFiles. This
	 *                  fileID can be obtained from the fileList, which is one
	 *                  of the outputs for retrieveFiles.
	 *  contentID       is a required String indicating the ID associated with
	 *                  the file, e.g. 120823010432267c2dad94ac40354c3e.
	 *  fileName        is a required String that is the file name of the file
	 *                  to be updated.
	 *  fileInputStream is a required String(Base64 encoded). It can be either
	 *                  the full path to the file to be updated, OR or a Base64
	 *                  encoded byte stream of the file to be updated.
	 *  friendlyName    is a required String indicating the identifier associated
	 *                  with the CSP server from which the files are being
	 *                  retrieved.
	 *  metadataMap     is an optional HashMap<String,String>, OR String, that
	 *                  should contain a collection of key-value pairs, which
	 *                  represent metadata about the updated node. This can be
	 *                  either a String in the form of comma separated key=value
	 *                  pairs, e.g. "key1=value1, key2=value2, etc", or a
	 *                  HashMap<String, String> with key-value pairs entered at
	 *                  each map index/position. Thus, the user can associate any
	 *                  desired metadata key-value pairs with the provided contentID.
	 * 
	 * OUTPUTS:
	 *  fileID          is a String that is the same as the passed-in value.
	 * status           is a String indicating success or failure.
	 */
	public static final void updateFile(IData pipeline) throws ServiceException {
		// --- <<IS-START(updateFile)>> ---
		// @sigtype java 3.5
		// [i] field:0:required fileID
		// [i] field:0:required contentID
		// [i] field:0:required fileName
		// [i] field:0:required fileInputStream
		// [i] field:0:required friendlyName
		// [i] object:0:optional metadataMap
		// [o] field:0:required fileID
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();
		String fileID = IDataUtil.getString(cursor, "fileID");
		String contentID = IDataUtil.getString(cursor, "contentID");
		String fileName = IDataUtil.getString(cursor, "fileName");
		Object input = IDataUtil.get(cursor, "fileInputStream");
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		Object metadataMap = IDataUtil.get(cursor, "metadataMap");
		cursor.destroy();
		if (metadataMap instanceof String) {
			String stringMap = (String) metadataMap;
			metadataMap = new HashMap<String, String>();
			stringMap = stringMap.replaceAll("}", "");
			String[] mapValues = stringMap.split(",");
			for (String valuePair : mapValues) {
				valuePair = valuePair.substring(1);
				String[] keyPair = valuePair.split("=");
				String key = keyPair[0];
				String value = keyPair[1];
				((HashMap<String, String>) metadataMap).put(key, value);
			}
		}
		((HashMap<String, String>) metadataMap).put("originalFileName",
				fileName);

		InputStream stream = null;
		try {
			if (input instanceof String) {
				File file = new File((String) input);
				if (file.exists()) {
					stream = new FileInputStream(file);
				} else {
					byte[] bytes = Base64.decode(((String) input).getBytes());
					stream = new ByteArrayInputStream(bytes);
				}
			} else if (input instanceof InputStream) {
				stream = (InputStream) input;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		// get the repo, based upon its friendlyName
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
		} catch (Exception e1) {
			; // nothing to do; the null repo is handled nicely next
		}

		String status = "";
		if (repo == null) {
			status = "Failed: Repository (" + friendlyName
					+ ") not configured, please first run addConnection.";
		}

		String[] fileNames = { fileName };
		String targetPath = "smi://" + friendlyName + "/tmp/" + fileName;
		try {
			if (repo != null) {
				if (!repo.isLive()) {
					repo.getRepo();
				}
				int nodeID = repo.getNodeIDOfContentID(contentID);
				int[] nodeIDs = { nodeID };
				if (fileID != null) {
					repo.updateFile(contentID, nodeIDs, stream, fileNames,
							friendlyName, targetPath, fileID);
					if (metadataMap != null)
						repo.addMetadata(contentID,
								(HashMap<String, String>) metadataMap);
					status = "Success: Updated " + fileName + " to "
							+ contentID + ".";
				} else {
					status = "Failed: Unable to update File for contentID "
							+ contentID + " fileID " + fileID + ".";
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			status = "Failed: Unable to update File for contentID " + contentID
					+ " fileID " + fileID + ".";
		}

		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "status", status);
		IDataUtil.put(cursor, "fileID", fileID);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

