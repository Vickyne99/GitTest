package wm.csp;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2012-08-12 02:37:43 PDT
// -----( ON-HOST: Software AG

import java.io.File;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Unmarshaller;

import org.apache.log4j.PropertyConfigurator;

import com.sag.eform.repo.CSPConnection;
import com.wm.app.b2b.server.Server;
import com.wm.app.b2b.server.ServiceException;
import com.wm.data.IData;

public final class admin {
	// ---( internal utility methods )---

	final static admin _instance = new admin();

	static admin _newInstance() { return new admin(); }

	static admin _cast(Object o) { return (admin)o; }

	// ---( server methods )---

	public static final void initialize(IData pipeline) throws ServiceException {
		// --- <<IS-START(initialize)>> ---
		// @sigtype java 3.5
		try {
			PropertyConfigurator.configure(new File(Server.getResources()
					.getPackageDir("WmContentServicePlatform"), "log4j.prop")
					.getAbsolutePath());
			util.startTime = new Date(System.currentTimeMillis());
			util.logger.info("<--- Start logging WmContentServicePlatform " + util.startTime);
			JAXBContext jc = JAXBContext.newInstance(CSPConnection.class);
			Unmarshaller unmarshall = jc.createUnmarshaller();
			File cfg = Server.getResources().getPackageConfigDir(
					"WmContentServicePlatform");
			String[] fileNameList = cfg.list();
			if (fileNameList != null) {
				for (int lp = 0; lp < fileNameList.length; lp++) {
					String fileName = fileNameList[lp];
					if (fileName != null) {
						File cfgFile = new File(cfg, fileName);
						try {
							if (fileName.endsWith(util.EXT)) {
								CSPConnection connection = (CSPConnection) unmarshall
										.unmarshal(cfgFile);
								if (connection != null) {
									util.repoMap.put(connection.getRepoName(),
											connection);
								}
							}
						} catch (Exception repoException) {
							System.out.println("Repo Exception");
							StringWriter result = new StringWriter();
							PrintWriter printWriter = new PrintWriter(result);
							repoException.printStackTrace(printWriter);
							util.logger.error(result.toString());
							System.out.println("Error?");
						}
					}
				}
			}
		} catch (Exception e) {
			System.out.println("Repo Exception?");
			StringWriter result = new StringWriter();
			PrintWriter printWriter = new PrintWriter(result);
			e.printStackTrace(printWriter);
			util.logger.error(result.toString());
			System.out.println("Error?");
			// e.printStackTrace();
		}
		// --- <<IS-END>> ---

                
	}

	public static final void cleanup(IData pipeline) throws ServiceException {
		// --- <<IS-START(cleanup)>> ---
		// @sigtype java 3.5
		util.logger.info("Stop logging WmContentServicePlatform " + util.startTime  + "--->");
		// --- <<IS-END>> ---

                
	}
}

