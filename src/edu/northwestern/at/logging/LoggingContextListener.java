/*********************************************************************************************
BBoogle (Google Apps Blackboard Integration)

Copyright 2009-2011 Academic and Research Technologies, Northwestern University.

Licensed under the	Educational Community License, Version 2.0 (the "License"). 
You may not use this file except in compliance with the License. You may	obtain 
a copy of the License at http://www.osedu.org/licenses/ECL-2.0.

Unless required by applicable law or agreed to in writing, software distributed 
under the License is distributed on an "AS IS"	BASIS, WITHOUT WARRANTIES 
OR CONDITIONS OF ANY KIND, either express or implied. See the License for 
the specific language governing permissions and limitations under the License.

***********************************************************************************************/
package edu.northwestern.at.logging;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Enumeration;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.log4j.PropertyConfigurator;

import blackboard.platform.config.ConfigurationServiceFactory;

import ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper;

/** LoggingContextListener initializes the log4j framework when the application starts
 * 
 * <p>This class listens to the startup and shutdown events of this web application, and
 *  properly initialize log4j. It works irrespectively of whether the servlet container
 *  uses log4j for its own internal logging purposes. </p>
 *  
 * @author Patricia Goldweic
 * @version April 2007
 *
 */
public class LoggingContextListener implements ServletContextListener {

    final String vendorId = BuildingBlockHelper.VENDOR_ID;
    final String handle = BuildingBlockHelper.HANDLE;
    final String interFileName = BuildingBlockHelper.SETTINGS_INTERNATIONAL;
    final String appName = BuildingBlockHelper.TOOL_NAME;
    
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	/** Overrides superclass's method in order to initialize log4j logging.
	 * 
	 */
	public void contextInitialized(ServletContextEvent event) {
		System.out.println(new StringBuffer().append("****** ").append(appName).append(" Initializing log4j...")); 
		ServletContext context = event.getServletContext();
		String prefix = context.getRealPath("/");
		String file = context.getInitParameter("logging-init-file");
		String filePrefix = context.getInitParameter("logging-file-prefix");
		String clusteredLog = context.getInitParameter("clusteredLog");
		if (filePrefix == null) filePrefix = "";
		if (file != null) {
			// we need to configure log4j using that file and interpreting correctly the 
			// location of the log files.
			Properties properties = new Properties();
			try {
			properties.load( new FileInputStream( prefix + file ) );

			for	(	Enumeration<?> enumerate = properties.propertyNames();
					enumerate.hasMoreElements(); )
			{
				String key = (String)enumerate.nextElement();

				if	(	key.startsWith( "log4j.appender" ) &&
						key.endsWith( ".File" ) )
				{
					String val = properties.getProperty( key );
					// 6/20/12 modify value to include hostname if clustered log is used
					if (clusteredLog != null && clusteredLog.equalsIgnoreCase("true")) {
						int dot = val.lastIndexOf(".");
						if (dot > 0)  {
							val = val.substring(0,dot) + getLocalHostName() + val.substring(dot, val.length());
							// Original Line - System.out.println("****** : log filename determined as: " + val);
							System.out.println(new StringBuffer().append(appName).append(" - Log filename determined as: ").append(val)); 
						}
					}
					
					// PG 10/28/11 val = prefix + "../config/" + val; generalized so that it can be used outside of B2's
					val = prefix + filePrefix + val;
					properties.setProperty( key , val );
					System.out.println(new StringBuffer().append(appName).append(" - set log4j property: ").append(key).append(" to: ").append(val));
				}
			}

			PropertyConfigurator.configure( properties );
			System.out.println("Just initialized log4j within LoggingContextListener");
			} catch (IOException e) {
				System.out.println("IOException while initializing logging functionality within LoggingContextListener. Ignoring...");
				e.printStackTrace();
			} catch (Exception e) {
				System.out.println("Exception while initializing logging functionality within LoggingContextListener. Ignoring...");
				e.printStackTrace();
			}
		}
	}
	
	// ****************** Helpers ********************** //
	
	/** Finds the local host name.
     * 
     * @return a string holding the 'local' portion of the local hostname
     */
    protected String getLocalHostName() throws UnknownHostException {
        System.out.println("App server fullhostname: " + BuildingBlockHelper.getFullHostName());
        return BuildingBlockHelper.getHostname(BuildingBlockHelper.getFullHostName());
    }

}

