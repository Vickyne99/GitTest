package wm.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.util.Date;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.sag.eform.repo.CSPConnection;
import com.sag.eform.repo.EContentRepository;

public final class util {
	// ---( internal utility methods )---

	final static util _instance = new util();

	static util _newInstance() { return new util(); }

	static util _cast(Object o) { return (util)o; }

	// ---( server methods )---

	// --- <<IS-START-SHARED>> ---
	public static EContentRepository getRepo(String friendlyName) throws Exception {
		CSPConnection connection = repoMap.get(friendlyName);
		EContentRepository repo = null;
		if (connection != null) {
			repo = connection.getRepo();
		}
		return repo;
	}

	public static String[] convertObjectToStringArray(Object value) {
		String[] result = null;
		if (value instanceof String[]) {
			result = (String[]) value;
		} else if (value instanceof String) {
			result = ((String) value).split(",");
		} else if (value == null) {
			result = new String[1];
			result[0] = "";
		}
		return result;
	}

	public static HashMap<String, CSPConnection> repoMap = new HashMap<String, CSPConnection>();

	public static String EXT = ".csp";

	public static Logger logger = Logger.getLogger("CSPutils");

	public static Date startTime = null;
	// --- <<IS-END-SHARED>> ---
}

