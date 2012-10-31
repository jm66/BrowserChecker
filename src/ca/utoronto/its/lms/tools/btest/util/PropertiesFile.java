package ca.utoronto.its.lms.tools.btest.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Locale;
import java.util.Properties;
import java.util.ResourceBundle;

import durham.ng.browser.HelpOptions;

/** This class extends the java.util.Properties class by associating an instance of such class
 * with a unique file location that is used in IO operations.
 * 
 * @author Patricia Goldweic
 *
 */

public class PropertiesFile extends Properties {
	final String vendorId = BuildingBlockHelper.VENDOR_ID;
	final String handle = BuildingBlockHelper.HANDLE;
	final String interFileName = BuildingBlockHelper.SETTINGS_INTERNATIONAL;
	final String appName = BuildingBlockHelper.TOOL_NAME;

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/** A File object specifying the pathname of the folder that holds the associated file */
	File m_folderLocation;
	
	/** A string holding the pathname of the file associated to this object. */
	String m_filename;
	
	/** The time when the properties were last read from file */
	long m_lastRead = 0L;
	
	/** Keeps track of initialization status. An instance is considered initialized when it has been assigned an associated file. */
	protected boolean m_initialized = false;
	
	// ************* Constructors and initialization ****************//
	
	/** Constructor.
	 * 
	 */
	public PropertiesFile() {
		super();
	}
	
	/** Constructor.
	 * 
	 * @param folderLocation A File instance representing the folder that will hold the associated properties
	 * @param name The name of the file that will hold the associated properties
	 * @throws IOException
	 */
	public PropertiesFile(File folderLocation, String name) throws IOException {
		super();
		synchronized(this) {
			m_folderLocation = folderLocation;
			m_filename = name;
			
			if (folderLocation != null && name != null) setInitialized();
			
			FileInputStream fi  = null;
			boolean created = false;
			if (!m_folderLocation.exists()) {
				created = true;
				m_folderLocation.mkdirs();
			}
			File newFile = new File(folderLocation, name);
			if (!newFile.exists()) {
				created = true;
				newFile.createNewFile();
				save();
				setLastRead();
			}
			if (!created) { // need to load existing properties
				try {
					fi = new FileInputStream(newFile);
					load(fi);
					setLastRead();
				} finally {
					if (fi != null) fi.close();
				}
			}
		}
	} 
	
	/** Initializes instance with a particular configuration file location.
	 * <p> If the configuration file already exists, then loads its properties onto this object; otherwise, it creates the file and/or folder </p>
	 * @param folderLocation A File instance representing the folder that will hold the associated properties
	 * @param filename The name of the file that will hold the associated properties
	 * @throws IOException
	 */
	public synchronized void init(File folderLocation, String filename) throws IOException {
		m_folderLocation = folderLocation;
		m_filename = filename;
		
		if (folderLocation != null && filename != null) setInitialized();
		
		FileInputStream fi  = null;
		boolean created = false;
		if (!m_folderLocation.exists()) {
			created = true;
			m_folderLocation.mkdirs();
		}
		File newFile = new File(folderLocation, filename);
		if (!newFile.exists()) {
			created = true;
			newFile.createNewFile();
			save(); // save current properties in file
			setLastRead();
		}
		// if the file already existed, load its properties ONLY if the file has been modified after it was last read
		if (!created) { 
			if (newFile.lastModified() > getLastRead()) {
				try {
					fi = new FileInputStream(newFile);
					load(fi);
					setLastRead();
				} finally {
					if (fi != null) fi.close();
				}
			}
		}
	}
		
	
	/** Initializes instance with a particular configuration file location.
	 * <p> If the configuration file already exists, then loads its properties onto this object; otherwise, it creates the file </p>
	 * @param configFile
	 * @throws IOException
	 */
	public synchronized void init(File configFile) throws IOException {
		m_folderLocation = configFile.getParentFile();
		m_filename = configFile.getName();
		
		if (m_folderLocation != null && m_filename != null) setInitialized();
		
		FileInputStream fi  = null;
		boolean created = false;
		if (!configFile.exists()) {
			created = true;
			configFile.createNewFile();
			save();
			setLastRead();
		}
		if (!created) { // need to load existing properties from file
			if (configFile.lastModified() > getLastRead()) {
				try {
					fi = new FileInputStream(configFile);
					load(fi);
					setLastRead();
				} finally {
					if (fi != null) fi.close();
				}
			}
		}
		
	}

	
	public synchronized void init(String configFilePath, Locale locale) throws IOException {
		System.out.println(new StringBuffer().append(appName).append("- Debug -").append(" will read"));
		
		File configFile = new File (configFilePath);
		m_folderLocation = configFile.getParentFile();
		m_filename = configFile.getName();
		
		if (m_folderLocation != null && m_filename != null) setInitialized();
		
		FileInputStream fi  = null;
		boolean created = false;
		if (!configFile.exists()) {
			// Creating config file
			created = true;
			configFile.createNewFile();
			save(); 
	        setLastRead();
	        System.out.println(new StringBuffer().append(appName).append("- Debug -").append(" file created"));
			// Filling config file
	        HelpOptions hOptions = new HelpOptions(locale);
	        hOptions.persist(this.getClass().getName(), configFile);
	        
	        System.out.println(new StringBuffer().append(appName).append("- Debug -").append(" default options persisted "));
	        System.out.println(new StringBuffer().append(appName).append("- Debug -").append(" Error persisting: ").append(hOptions.getErrorLog()));
	        
	    	try {
	    		System.out.println(new StringBuffer().append(appName).append("- Debug -").append(" Now Loading: ").append(m_filename));
				fi = new FileInputStream(configFile);
				load(fi);
				setLastRead();
			} finally {
				if (fi != null) fi.close();
			}
			
			
		}
		if (!created) { // need to load existing properties from file
			System.out.println(new StringBuffer().append("Debug - Reading ").append(configFilePath));
			if (configFile.lastModified() > getLastRead()) {
				try {
					fi = new FileInputStream(configFile);
					load(fi);
					setLastRead();
				} finally {
					if (fi != null) fi.close();
				}
			}
		}
	}
	// ************ Getters and Setters ***************//
	
	/** Retrieves the 'folderLocation' member variable.
	 * 
	 */
	public File getFolderLocation() {
		return m_folderLocation;
	}
	
	/** Retrieves the 'filename' member variable.
	 * 
	 */
	public String getFilename() {
		return m_filename;
	}
	
	/** Retrieves the 'lastRead' member variable.
	 * 
	 */
	public synchronized long getLastRead() {
		return m_lastRead;
	}
	
	/** Sets the 'lastRead' member variable.
	 * 
	 */
	private synchronized void setLastRead() {
		m_lastRead = System.currentTimeMillis();
	}
	
	/** Sets the 'initialized' member variable to true.
	 * 
	 */
	private void setInitialized() {
		m_initialized = true;
	}
	
	/** Retrieves the 'initialized member variable.
	 * 
	 */
	public boolean isInitialized() {
		return m_initialized;
	}
	
	
	// ***************** Implementation **********************//
	
	/** Loads (possibly creating) properties from a given file, locking the file before reading
	 * 
	 */
	/*
	public PropertiesFile(File folderLocation, String name) throws IOException {
		super();
		synchronized(this) {
			m_folderLocation = folderLocation;
			m_filename = name;
			FileInputStream fi  = null;
			boolean created = false;
			if (!m_folderLocation.exists()) {
				created = true;
				m_folderLocation.mkdirs();
			}
			File newFile = new File(folderLocation, name);
			if (!newFile.exists()) {
				created = true;
				newFile.createNewFile();
			}
			if (!created) { // need to load existing properties
				FileLock lock = null;
				try {
					fi = new FileInputStream(newFile);
					lock = fi.getChannel().lock();
					load(fi);
				} finally {
					if (lock != null) lock.release();
					if (fi != null) fi.close();
				}
			}
		}
	}
	*/
		
	/** Saves the properties object to the associated file on disk.
	 * 
	 * <p> Ignores the call if the object has not been initialized </p>
	 */
	public synchronized void save() throws IOException {
		if (!isInitialized()) return;
		FileOutputStream fo = null;
		File thisFile = new File(m_folderLocation, m_filename);
		try {
			fo = new FileOutputStream(thisFile);
			store(fo, "Properties File");
		} finally {
			if (fo != null) fo.close();
		}
	}
	
	
	/** Saves the properties file, acquiring a FileLock on the file before writing.
	 * 
	 */
	/*
	public synchronized void save() throws IOException {
		FileOutputStream fo = null;
		File thisFile = new File(m_folderLocation, m_filename);
		FileLock lock = null;
		try {
			fo = new FileOutputStream(thisFile);
			lock = fo.getChannel().lock();
			store(fo, "Properties File");
		} finally {
			if (lock != null) lock.release();
			if (fo != null) fo.close();
		}
	}
	*/
	
	/** Sets a property value ONLY if the current value for the property is null.
	 * 
	 */
	public synchronized void safeSetProperty(String property, String value) {
		String current = getProperty(property);
		if (current == null && value != null) setProperty(property, value);
	}
	
	/** Sets a property value ONLY if the current value for the property is null.
	 * 
	 * @param property
	 * @param value
	 * @param defaultValue If 'value' is null, this value is used instead as the property's value 
	 */
	public synchronized void  safeSetProperty(String property, String value, String defaultValue) {
		String current = getProperty(property);
		if (current == null) {
			if (value != null) setProperty(property, value);
			else if (defaultValue != null) setProperty(property, defaultValue);
		}
	}
	
	/** Convenience method for retrieving a boolean property value
	 * 
	 * @param name The name of a boolean property
	 * @param defaultValue The default value of the boolean property
	 * @return a boolean value corresponding to the property in question
	 */
	public synchronized boolean getBooleanProperty(String name, boolean defaultValue) {
		String value = getProperty(name);
		if (value == null) return defaultValue;
		else return value.equalsIgnoreCase("true") || value.equalsIgnoreCase("t") ;
	}
	
	/** Convenience method for retrieving a boolean property value
	 * 
	 * @param name The name of a boolean property
	 * @return a boolean value corresponding to the property in question
	 */
	public synchronized boolean getBooleanProperty(String name) {
		String value = getProperty(name);
		return value != null && (value.equalsIgnoreCase("true") || value.equalsIgnoreCase("t")) ;
	}
	
	/** Convenience method for retrieving an integer property value
	 * 
	 * @param name The name of a integer property
	 * @param defaultValue The default value of the integer property
	 * @return an int value corresponding to the property in question
	 */
	public synchronized int getIntegerProperty(String name, int defaultValue) {
		String value = getProperty(name);
		if (value == null) return defaultValue;
		else return Integer.parseInt(value) ;
	}
	
	/** Convenience method for retrieving a long property value
	 * 
	 * @param name The name of a integer property
	 * @param defaultValue The default value of the integer property
	 * @return an int value corresponding to the property in question
	 */
	public synchronized long getLongProperty(String name, long defaultValue) {
		String value = getProperty(name);
		if (value == null) return defaultValue;
		else return Long.parseLong(value) ;
	}

}
