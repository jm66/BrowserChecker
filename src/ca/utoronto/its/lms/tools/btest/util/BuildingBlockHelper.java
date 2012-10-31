package ca.utoronto.its.lms.tools.btest.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletContext;

import blackboard.platform.config.ConfigurationServiceFactory;
import blackboard.platform.plugin.PlugInException;
import blackboard.platform.plugin.PlugInUtil;

/**
 * This is a helper class for your building block. Feel free to modify it to meet the needs
 * of this building block. 
 *
 */
public class BuildingBlockHelper {

    public static final String VENDOR_ID = "ut";
    public static final String VENDOR_NAME = "University of Toronto, Information + Technology Services";
    public static final String DOMAIN = "lms.utoronto.ca";
    public static final String HANDLE = "browserCheck";
    public static final String TOOL_NAME = "Browser Settings Tester";
    public static final String SETTINGS_FILE_NAME = "config.properties";
    public static final String SETTINGS_INTERNATIONAL = "durham/ng/browser/international";
    public static final String SETTINGS_CUSTOM = "browserTester.properties";
    public static final String UPLOAD_TEMP_FOLDER = "temp";
    public static final String FS = System.getProperty("file.separator");
    
    public static File getConfigDirectory() throws PlugInException {
        File configDir = PlugInUtil.getConfigDirectory(VENDOR_ID, HANDLE);
        if (!configDir.exists()) {
            configDir.mkdir();
        }
        return configDir;
    }

    public static Properties loadBuildingBlockSettings() throws PlugInException, IOException {
        File settingsFile = new File(getConfigDirectory(), SETTINGS_FILE_NAME);
        if (!settingsFile.exists()) {
            settingsFile.createNewFile();
        }
        Properties settings = new Properties();
        settings.load(new FileInputStream(settingsFile));
        return settings;
    }

    public static void saveBuildingBlockSettings(Properties props) throws PlugInException, IOException {
        File settingsFile = new File(getConfigDirectory(), SETTINGS_FILE_NAME);
        if (!settingsFile.exists()) {
            settingsFile.createNewFile();
        }
        props.store(new FileOutputStream(settingsFile), "Building Block Properties File");;
    }

    public static String getConfigFileFullPath(ServletContext sce) {
        String fileSeparator = System.getProperty("file.separator");
        StringBuilder fullConfigPath = new StringBuilder();
        File cfgDir = new File(sce.getRealPath(""), "../config");
        fullConfigPath.append(cfgDir.getAbsolutePath()).append(fileSeparator).append(SETTINGS_CUSTOM);
        return fullConfigPath.toString();
    }
    public static String getFullHostName(){
    	return ConfigurationServiceFactory.getInstance().getBbProperty("bbconfig.appserver.fullhostname");
    }
    
    public static String getSMTPServer(){
    	return ConfigurationServiceFactory.getInstance().getBbProperty("bbconfig.smtpserver.hostname");
    }
    
    public static String getHostname(String hostName) {
        hostName = hostName.toLowerCase();
        System.out.println("hostName: "+hostName);
        int firstDotIndex = hostName.indexOf('.');
        if (firstDotIndex < 0) {
            return hostName;
        } else {
            return hostName.substring(0, firstDotIndex);
        }
    }
}
