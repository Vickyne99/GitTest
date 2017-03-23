package pub.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import wm.csp.util;

import com.sag.eform.common.SearchString;
import com.sag.eform.repo.EContentRepository;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;
import com.wm.data.IDataCursor;
import com.wm.data.IDataUtil;

public final class search {
	// ---( internal utility methods )---

	final static search _instance = new search();

	static search _newInstance() { return new search(); }

	static search _cast(Object o) { return (search)o; }

	// ---( server methods )---

	/**
	 * The createMetadataMap service is used to translate the key-value pairs in
	 * the IData of an IS Doc into a HashMap called metadataMap. That output
	 * metadataMap can be used as input to other services in this package such
	 * as createContentID, addFile and updateFile.
	 * 
	 * INPUTS:
	 *  metadata    is a required IData in the form of key-value pairs,
	 *              which is just what IData is.
	 * 
	 * OUTPUTS:
	 *  metadataMap is a HashMap<String,String> of the input IData.
	 */
	public static final void createMetadataMap(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(createMetadataMap)>> ---
		// @sigtype java 3.5
		// [i] record:0:required metadata
		// [o] object:0:required metadataMap
		IDataCursor cursor = pipeline.getCursor();
		IData metadataDoc = IDataUtil.getIData(cursor, "metadata");
		cursor.destroy();
		HashMap<String, String> metadataMap = new HashMap<String, String>();
		if (metadataDoc != null) {
			cursor = metadataDoc.getCursor();
			while (cursor.next()) {
				Object value = cursor.getValue();
				if (value != null) {
					metadataMap.put(cursor.getKey(), value.toString());
				}
			}
			cursor.destroy();
		}
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "metadataMap", metadataMap);
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The createSearchTerm service is used to create a "SearchTerm" object from
	 * the passed-in values. That SearchTerm object can then be used as input to
	 * searchMetadata. The returned SearchTerm object is built from the provided
	 * inputs. When this service is invoked via JAVA code, then multiple
	 * invocations of this service can be made in order to products SearchTerm
	 * objects that can then be JOINed together via the join input.
	 * 
	 * INPUTS:
	 *  indexID      is a required String containing values in the form of a
	 *               CSP indexID, some examples of which can be seen in the
	 *               Automobile Accident Claims sample included with the CSP.
	 *               E.g. the Index Name "Driver Last Name" has an indexID
	 *               value of 200000001, and the Index Name "Driver First Name"
	 *               has an indexID value of 200000002.
	 *  operator     is a required String containing values in the form of (STACEY, THIS NEEDS
	 *               WORK):
	 *               ~ Match everything e.g. ~ Test =, !~ Not Equals e.g. foo! ~ Test, <, >,
	 *               <=, >=. Other examples: 200000001 = Test // Will only match Test not
	 *               Test1 200000001 ~ Test* // Will match everything containing Test
	 *  searchValue  is a required String. This field is a user-defined value and
	 *               thus any string can be here. Also, the '*' char can be used to
	 *               indicate match everything.
	 *  join         is a required String. This field should be set to either AND or OR.
	 *               It defaults to AND, and is used to join multiple SearchTerm objects.
	 *               In the case of this service being run from the launch menu, the user
	 *               can only input one value for AND/OR and AND should be used. However,
	 *               when this service is invoked via JAVA code the user can invoke this
	 *               service multiple times, thus creating multiple SearchTerm objects.
	 *               The user can then take that collection of SearchTerm objects and
	 *               provide them as a list of SearchTerm objects as input to the
	 *               searchMetadata service. Those SearchTerm objects are then AND-ed or
	 *               OR-ed together.
	 * 
	 * 
	 * OUTPUTS:
	 *  searchTerm   is an object value that can be used in searchMetadata.
	 *  searchFilter is a String value that is a toString() representation of the
	 *               searchTerm output; i.e. is it the input fields encapsulated into
	 *               a single formatted string.
	 */
	public static final void createSearchTerm(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(createSearchTerm)>> ---
		// @sigtype java 3.5
		// [i] field:0:required indexID
		// [i] field:0:required operator
		// [i] field:0:required searchValue
		// [i] field:0:required join
		// [o] object:0:required searchTerm
		// [o] field:0:required searchFilter
		IDataCursor cursor = pipeline.getCursor();
		String indexID = IDataUtil.getString(cursor, "indexID");
		String operator = IDataUtil.getString(cursor, "operator");
		String searchValue = IDataUtil.getString(cursor, "searchValue");
		String join = IDataUtil.getString(cursor, "join");

		SearchString searchString = new SearchString(new Integer(indexID),
				operator, searchValue, join);
		IDataUtil.put(cursor, "searchTerm", searchString);
		IDataUtil.put(cursor, "searchFilter", searchString.toString());
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}

	/**
	 * The searchMetadata service is used to search the CSP for a specific
	 * metadata. The user must use the createSearchTerm method and place the
	 * resulting searchTerm into the searchTerms list to use this service.
	 * 
	 * INPUTS:
	 *  friendlyName is a required String indicating the identifier associated
	 *               with the CSP server from which the files are being retrieved.
	 *  nodeID       is a required String that indicates the ID of the node being
	 *               searched. An example of which can be seen in the Automobile
	 *               Accident Claims sample included with the CSP. E.g. the nodeID
	 *               of "Automobile Accident Claims" is 8.
	 *  searchTerms  is a required List<SearchTerm>. The list of SearchTerm
	 *               items can be built by calling createSearchTerm and adding
	 *               the searchTerm output to the list of searchTerms. On 9/2013
	 *               the code was changed for this input to be able to support
	 *               a single SearchTerm object or, as the input type indicates,
	 *               a List of SearchTerm items.
	 * 
	 * OUTPUTS:
	 *  contentList  is a List<String>. The contentList contains a list of contentIDs
	 *               that can be used in other WmContentServicePlatform services such
	 *               as addFile and retrieveFiles.
	 *  status       is a String indicating success or failure.
	 */
	public static final void searchMetadata(IData pipeline)
			throws ServiceException {
		// --- <<IS-START(searchMetadata)>> ---
		// @sigtype java 3.5
		// [i] field:0:required friendlyName
		// [i] field:0:required nodeID
		// [i] object:1:required searchTerms
		// [o] field:1:required contentList
		// [o] field:0:required status
		IDataCursor cursor = pipeline.getCursor();

		/*
		 * Retrieve the input values from the pipeline and confirm their
		 * presence.
		 */
		String friendlyName = IDataUtil.getString(cursor, "friendlyName");
		if (friendlyName == null) {
			throw new ServiceException(
					"No value was supplied for the required parameter 'friendlyName'");
		}
		String nodeID = IDataUtil.getString(cursor, "nodeID");
		if (nodeID == null) {
			throw new ServiceException(
					"No value was supplied for the required parameter 'nodeID'");
		}
		List<SearchString> terms = new ArrayList<SearchString>();
		Object inSearchTerms = IDataUtil.get(cursor, "searchTerms");
		if (!(inSearchTerms instanceof Object[])) {
			throw new ServiceException(
				"An incorrect type was supplied for the required parameter"
				+ " 'searchTerms'. The type provided was: '" + inSearchTerms.getClass()
				+ "' and it should have been 'SearchString[]'.");
		}
		Object[] istArray = (Object[]) inSearchTerms;
		for (int i = 0; i < istArray.length; i++) {
			if (!(istArray[i] instanceof SearchString)) {
				throw new ServiceException(
					"Incorrect 'String' type was supplied in the required parameter"
					+ " 'searchTerms'; the contents of 'searchTerms' must be of type 'SearchString'.");
			}
			terms.add((SearchString) istArray[i]);
		}
		if (terms.size() == 0) {
			throw new ServiceException(
				"No value was supplied for the required parameter 'searchTerms'.");
		}

		/*
		 * Get the repo, based upon its friendlyName.
		 */
		EContentRepository repo = null;
		try {
			repo = util.getRepo(friendlyName);
		} catch (Exception e1) {
			; // nothing to do; the null repo is handled nicely next
		}

		/*
		 * Confirm we have a repo object, connect if necessary, and then do the
		 * search.
		 */
		String status = "";
		List<String> contentList = null;
		if (repo == null) {
			status = "Failed: Repository (" + friendlyName
					+ ") not configured, please first run addConnection.";
		}
		cursor.destroy();
		try {
			if (repo != null) {
				if (!repo.isLive()) {
					repo.getRepo();
				}
				contentList = repo.searchMetadata(terms, nodeID);
				status = "Success: Retrieved Content Definition Map.";
			}
		} catch (Exception e) {
			status = "Failed: Could not retrieve Content Definition Map due to: "
					+ e.getMessage() + ".";
		}

		/*
		 * Put the results of the search, and the status into the pipeline.
		 */
		cursor = pipeline.getCursor();
		IDataUtil.put(cursor, "status", status);
		// on 9/2013 changed this to match the actual output listed in the
		// service's properties in Designer
		IDataUtil.put(cursor, "contentList",
				contentList.toArray(new String[0]));
		cursor.destroy();
		// --- <<IS-END>> ---

                
	}
}

