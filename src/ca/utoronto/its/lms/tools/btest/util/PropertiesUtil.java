/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ca.utoronto.its.lms.tools.btest.util;

/**
*
* @author Jose Manuel Lopez Lujan, University of Toronto.
* 
*/

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PropertiesUtil extends Properties{

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	final static String vendorId = BuildingBlockHelper.VENDOR_ID;
    final static String handle = BuildingBlockHelper.HANDLE;
    final static String configFileName = BuildingBlockHelper.SETTINGS_FILE_NAME;
    private static Properties prop = null;

    public PropertiesUtil() {
    }

    public static void saveProperties(HttpServletRequest request, HttpServletResponse response, ServletContext sce) {
        try {
            Properties properties = new Properties();

            properties.store(new FileOutputStream(GetConfigPath(sce)), null);
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }

    }

    public static Properties getProperties(ServletContext sce) {
        try {
            prop = new Properties();
            prop.load(new FileInputStream(GetConfigPath(sce)));
            //System.out.println("Size of properties: "+prop.size());
            return prop;
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
            return null;
        }
    }

    public static String GetConfigPath(ServletContext sce) {
        String fileSeparator = System.getProperty("file.separator");
        StringBuilder fullConfigPath = new StringBuilder();
        fullConfigPath.append(sce.getRealPath("")).append(fileSeparator);
        fullConfigPath.append("config").append(fileSeparator).append(configFileName);
        return fullConfigPath.toString();
    }
}