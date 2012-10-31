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

/**
 * @author Patricia Goldweic
 * @version September, 2003
 *
 *  This class wrapps some of the logging functionality provided by log4j. 
 */

import org.apache.log4j.Level;
import org.apache.log4j.Logger;

public class LogManager {
	
	public static final int DEBUG_LEVEL = Level.DEBUG.toInt();
	
	public static final int INFO_LEVEL = Level.INFO.toInt();
	
	public static final int WARN_LEVEL = Level.WARN.toInt();
	
	public static final int ERROR_LEVEL = Level.ERROR.toInt();
	
	public static final int FATAL_LEVEL = Level.FATAL.toInt();
	
	public static void log(String loggerName, int debugLevel, Object message) {
		Logger thislogger = Logger.getLogger(loggerName);
		thislogger.log(Level.toLevel(debugLevel), message);
	}
	
	// By default, assume an INFO level
	public static void log(String loggerName, Object message) {
		Logger thislogger = Logger.getLogger(loggerName);
		thislogger.info(message);
	}
	
	// If additional contextual information is provided, then add it to the original message
	// before log4j gets involved.
	public static void log(String loggerName, Object context, Object message) {
		//System.out.println("Received context: " + context);
		Logger thislogger = Logger.getLogger(loggerName);
		thislogger.info(context.toString() + " " + message.toString());
	}
	
	public static void log(String loggerName, int debugLevel, Object context, Object message) {
		log(loggerName, debugLevel, context.toString() + " " + message.toString());
	}
	
	public static void logError(String loggerName, String message, Throwable e) {
		Logger thislogger = Logger.getLogger(loggerName);
		thislogger.error(message, e);
	}
	
	public static void logError(String loggerName, String message) {
		Logger thislogger = Logger.getLogger(loggerName);
		thislogger.error(message);
	}

}
