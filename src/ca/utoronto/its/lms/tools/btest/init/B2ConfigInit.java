/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ca.utoronto.its.lms.tools.btest.init;

import blackboard.platform.intl.BbLocale;
import blackboard.platform.intl.LocaleManagerFactory;
import ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper;
import ca.utoronto.its.lms.tools.btest.util.PropertiesFile;
import edu.northwestern.at.logging.*;
import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;
import java.util.ResourceBundle;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;



/**
 * Web application lifecycle listener.
 *
 * @author jm
 */
public class B2ConfigInit implements ServletContextListener {

    final String vendorId = BuildingBlockHelper.VENDOR_ID;
    final String handle = BuildingBlockHelper.HANDLE;
    final String interFileName = BuildingBlockHelper.SETTINGS_INTERNATIONAL;
    final String appName = BuildingBlockHelper.TOOL_NAME;
    
    public void B2ConfigInit(ServletContext sc) {
        // TODO Auto-generated constructor stub\
        try {     
        	System.out.println(new StringBuffer().append("****** ").append(appName).append(" Initializing ..."));
            // use the BbLocale to select appropriate text to display to the user
            BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
            
            System.out.println(new StringBuffer().append(appName).append(" - Debug -").append(bbLocale.getName()));       
            System.out.println(new StringBuffer().append(appName).append(" - Debug -").append(BuildingBlockHelper.getConfigFileFullPath(sc)));

            // Loading international.properties file
            System.out.println(new StringBuffer().append(appName).append(" - Debug -").append(interFileName));
            ResourceBundle rBundle = ResourceBundle.getBundle(interFileName, bbLocale.getLocaleObject());

            // Loading or creating browserTester.properties file
            PropertiesFile pConfig = new PropertiesFile();
            pConfig.init(BuildingBlockHelper.getConfigFileFullPath(sc), bbLocale.getLocaleObject());
           
            System.out.println(new StringBuffer().append(appName).append(" - Bundle Keys Loaded - ").append(rBundle.keySet().size()));
            System.out.println(new StringBuffer().append(appName).append(" - Properties Keys Loaded - ").append(pConfig.keySet().size()));
            System.out.println(new StringBuffer().append(appName).append(" - Configuring Servlet Context ..."));
            
            // Setting objects in context
            sc.setAttribute(handle + "_rBundle", rBundle);
            sc.setAttribute(handle + "_pConfig", pConfig);
            System.out.println(new StringBuffer().append("****** ").append(appName).append(" - All ready ..."));

        } catch (Exception ex) {
        	System.out.println(new StringBuffer().append(appName).append(" - ERROR -").append(" - Registered an exception during startup - " + ex.getMessage()));
        	System.out.println(new StringBuffer().append(appName).append(" - ERROR -").append(" - Please review Blackboard logs for further data."));
            //ex.printStackTrace();
        }
    }

    /**
     * @see ServletContextListener#contextInitialized(ServletContextEvent)
     */
    public void contextInitialized(ServletContextEvent arg0) {
        B2ConfigInit(arg0.getServletContext());
    }

    /**
     * @see ServletContextListener#contextDestroyed(ServletContextEvent)
     */
    public void contextDestroyed(ServletContextEvent arg0) {
    	System.out.println(new StringBuffer().append("******").append(appName).append(" - Destroying Servlet Context Objects ..."));
        ServletContext sc = arg0.getServletContext();
        sc.removeAttribute(handle + "_rBundle");
        sc.removeAttribute(handle + "_pConfig");
    	System.out.println(new StringBuffer().append("******").append(appName).append(" - All done ..."));
    }


}
