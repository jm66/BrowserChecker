/* 
 * Version 2.5
 * contributor: Jose M. Lopez, jm.lopez@utoronto.ca
 * 	Added functionality when no plug in is detected, 
 * 	instead of "Unknown" displays "Download" with each 
 * 	Plugin download page
 * 
 * Version 2.4 
 * 08-02-2010
 * author: Shannon Meisenheimer, meisenheimer@ucmo.edu
 * 
**/

//UofT
//If plugin not installed display where to get it
var URLS = (function() {
    var private = {
        'GET_PDF': '<a href=\"http://get.adobe.com/reader/\" target=\"_blank\">Download</a>',
        'GET_REAL': '<a href=\"http://www.real.com/realplayer?src=null&pcode=rn\" target=\"_blank\">Download</a>',
        'GET_REALMAC': '<a href=\"http://asia.real.com/?mode=rp_mac\" target=\"_blank\">Download</a>',
        'GET_QT':'<a href=\"http://www.apple.com/quicktime/\" target=\"_blank\">Download</a>',
        'GET_SHOCK': '<a href=\"http://get.adobe.com/shockwave/\" target=\"_blank\">Download</a>',
        'GET_FLASH': '<a href=\"http://get.adobe.com/flashplayer/\" target=\"_blank\">Download</a>',
        'GET_SILVER': '<a href=\"http://www.microsoft.com/getsilverlight/Get-Started/Install/Default.aspx\" target=\"_blank\">Download</a>',
        'GET_JAVA':'<a href=\"http://www.java.com/en/download/\" target=\"_blank\">Download</a>'
    };

    return {
       get: function(name) { return private[name]; }
   };
})();

var pluginDesc, pluginName, flashVersion, pdfVersion, shockwaveVersion, qtVersion, realVersion, wmpVersion, silverlightVersion, flashInstalled, pdfInstalled,
	shockwaveInstalled,	qtInstalled, realInstalled, wmpInstalled, silverlightInstalled; 
var pluginArray = [];
	
javaInstalled = flashInstalled = pdfInstalled = shockwaveInstalled = qtInstalled = realInstalled = wmpInstalled = silverlightInstalled = "No"; // assume plugins are not installed
javaVersion = flashVersion = pdfVersion = shockwaveVersion = qtVersion = realVersion = wmpVersion = silverlightVersion = " "; // assume no version/not isntalled

//UofT
//If plugin not installed display where to get it
realVersion = URLS.get('GET_REAL');
qtVersion = URLS.get('GET_QT');
shockwaveVersion = URLS.get('GET_SHOCK');
flashVersion = URLS.get('GET_FLASH');
silverlightVersion = URLS.get('GET_SILVER');
flashVersion = URLS.get('GET_FLASH');
pdfVersion = URLS.get('GET_PDF');
wmpVersion = URLS.get('GET_SILVER');
javaVersion = URLS.get('GET_JAVA')
function checkPlugins() // Runs the appropriate check function for IE or non-IE browsers
{
	switch (true)
	{
		case (navigator.plugins.length == 0): // this array is empty in Internet Explorer, but should have at least 1 plugin in other browsers
			pluginDetectIE();
			break;
		default:
			pluginDetect("windows media",
						 "shockwave flash",
						 "realplayer version",
						 "quicktime plug-in",
						 "adobe pdf",
						 "shockwave for director",
						 "realplayer plugin", // RealPlayer on a Mac
						 "adobe acrobat", // Older verison of Adobe Reader and Reader on a Mac
						 "silverlight",
						 "java"
						 ); 
			break;
	}
} // End checkPlugins



function pluginDetect() // Only used for non-IE browsers
{
	var argumentArray, npLength, plugName, plugDesc, plugNameLower, plugDescLower, realBuildVersion;
	argumentArray = pluginDetect.arguments; // creates an array of plugin names being checked for
	
	for (h=0; h<argumentArray.length; h++) // Pre-populate pluginArray with "No" values (assume no plugins are installed)
	{
		pluginArray[h] = "No--No--No";
	}
	
	npLength = navigator.plugins.length;
	
	for (i=0; i<npLength; i++) // cycles through installed plugins
	{
		plugName = navigator.plugins[i].name; // retrieve plugin name
		plugDesc = navigator.plugins[i].description; // retrieve plugin description
		plugNameLower = plugName.toLowerCase(); // convert to lowercase
		plugDescLower = plugDesc.toLowerCase(); // convert to lowercase
	
		for (j=0; j<argumentArray.length; j++) // cycle through provided arguments (plugins to check for)
		{
			if ((plugNameLower.indexOf(argumentArray[j]) >= 0) || (plugDescLower.indexOf(argumentArray[j]) >= 0)) // if match is found
			{
				pluginArray[j] = argumentArray[j] + "--" + plugNameLower + "--" + plugDescLower; // Append current plugin info into the array
			}
		}
	}
	for (q=0; q<pluginArray.length; q++)
	{
		var tempArray = pluginArray[q].split("--");
		switch (true) // need a case for each argument passed to pluginDetect()
		{
			case tempArray[0] == "windows media":
				wmpVersion = "Not available"; // WMP version is difficult to determine in non-IE browsers 
				wmpInstalled = "Yes";
				break;
			case tempArray[0] == "shockwave flash":
				flashVersion = tempArray[2].match(/[\d]+/g);
				flashVersion.length = 2;
				flashVersion = flashVersion.join('.');
				flashInstalled = "Yes";
				break; 
			case tempArray[0] == "realplayer version": 
				realVersion = tempArray[2].match(/[\d]+/g); // creates an array of single digits contained in the plugin name
				realVersion.length = 3; // shortens array length to 3 elements
				switch (true)
				{
					case realVersion[0] == "12":
						realVersion.length = 2; // shortens array length to 2 elements
						realVersion = realVersion.join('.'); // joins all array elements to a single string and separates by a period
						break;
					case realVersion[0] == "6":
						realBuildVersion  = parseInt(realVersion[2]);
						switch (true)
						{
							case realBuildVersion >= 12:
								realVersion = "10 or Higher"; // RealPlayer version detection through navigator.plugins is not reliable
								break;
							case realBuildVersion <= 9:
								realVersion = "8 or Lower"; // RealPlayer version detection through navigator.plugins is not reliable
								break;
							default:
								
								realVersion = URLS.get('GET_REAL');
								break;
						}
						break;
					default:
						realVersion = URLS.get('GET_REAL');
						break;
				}
				realInstalled = "Yes";
				break; 
			case tempArray[0] == "realplayer plugin": // RealPlayer plugin on a Mac
				realVersion = URLS.get('GET_REAL');
				realInstalled = "Yes";
				break; 
			case tempArray[0] == "quicktime plug-in":
				qtVersion = tempArray[1].match(/[\d]+/g); // creates an array of single digits contained in the plugin name
				qtVersion.length = 2; // shortens array length to 2 elements
				qtVersion = qtVersion.join('.'); // joins all array elements to a single string and separates by a period
				qtInstalled = "Yes";
				break; 
			case tempArray[0] == "adobe pdf":
				pdfVersion = parseFloat(tempArray[2].split('version ')[1]); // get Adobe Reader Version
				if (isNaN(pdfVersion)) // if version was not found (not-a-number)
				{
					pdfVersion = URLS.get('GET_PDF');
				}
				pdfInstalled = "Yes";
				break; 
			case tempArray[0] == "adobe acrobat": // Adobe Reader plugin for Safari on a Mac, or older version of Reader
				pdfVersion = parseFloat(tempArray[2].split('version ')[1]); // get Adobe Reader Version
				if (isNaN(pdfVersion)) // if version was not found (not-a-number)
				{
					pdfVersion = URLS.get('GET_PDF');
				}
				pdfInstalled = "Yes";
				break; 
			case tempArray[0] == "shockwave for director":
				shockwaveVersion = tempArray[2].match(/[\d]+/g); // creates an array of single digits contained in the plugin description
				shockwaveVersion.length = 2; // shortens array length to 2 elements
				shockwaveVersion = shockwaveVersion.join('.'); // joins all array elements to a single string and separates by a period	
				shockwaveInstalled = "Yes";
				break; 
			case tempArray[0] == "silverlight":
				silverlightVersion = tempArray[2];
				silverlightVersion = silverlightVersion.substring(0,3); // shorten version to one decimal place
				silverlightInstalled = "Yes";
			case tempArray[0] == "java":
				javaVersion = "Use the above applet";
				//javaVersion = javaVersion.substring(0,3); // shorten version to one decimal place
				javaInstalled = "Yes";
			default:
				break;
		} 
	}
} // End pluginDetect() 

function pluginDetectIE() // this detects plugins for Internet Explorer
{
	var control, error;
	control = null;
	
	if (window.ActiveXObject) // if ActiveX capable
	{
		// check for Flash
		try
		{
			control = new ActiveXObject('ShockwaveFlash.ShockwaveFlash');
		}
		catch (e)
		{
			error = true;
		}
		if (control) 
		{
			flashVersion = control.GetVariable('$version').substring(4); // removes the first 4 characters "WIN " from the version
			flashVersion = flashVersion.split(','); // splits the version into an array based off a comma separator
			flashVersion.length = 2; // shortens array length to 2 elements
			flashVersion = flashVersion.join('.'); // joins all array elements to a single string and separates by a period
			flashInstalled = "Yes";
		}
		control = null;
	
		// check for Adobe Reader
		try
		{
			control = new ActiveXObject('AcroPDF.PDF'); // version 7 and later
		}
		catch (e)
		{
			error = true;
		}
		if (!control)
		{  
			try
			{  
				control = new ActiveXObject('PDF.PdfCtrl'); // version 6 and earlier
			}
			catch (e)
			{  
				error = true;
			}  
		}  
		if (control) 
		{
			pdfVersion = control.GetVersions().split(','); // creates an array of Acrobat Plug-in components
			pdfVersion = pdfVersion[0].split('='); // splits the first array element into another array based off the equal sign
			pdfVersion = parseFloat(pdfVersion[1]);  // converts the second array element to a number
			pdfInstalled = "Yes";
		}
		control = null;
	
		// check for Adobe Shockwave
		try
		{
			control = new ActiveXObject('SWCtl.SWCtl');
		}
		catch (e)
		{
			error = true;
		}
		if (control) 
		{
			shockwaveVersion = control.ShockwaveVersion('').split('r'); // creates an array of Shockwave Plug-in components
			shockwaveVersion = parseFloat(shockwaveVersion[0]); 
			shockwaveInstalled = "Yes";
		}
		control = null;
		
		// check for Java
		try
		{
			control = new ActiveXObject("JavaPlugin") ;
		}
		catch (e)
		{
			error = true;
		}
		if (control) 
		{
			javaInstalled = "Yes";
		}
		control = null;
		
		//check for Apple QuickTime
		try
		{
			control = new ActiveXObject('QuickTime.QuickTime');
		} 
		catch (e)
		{
			error = true;
		}
		try
		{
			// This generates a user prompt in Internet Explorer 7
			control = new ActiveXObject('QuickTimeCheckObject.QuickTimeCheck.1');
		}
		catch (e)
		{
			error = true;
		}
		if (control && control.QuickTimeVersion)
		{
			qtVersion = control.QuickTimeVersion.toString(16); // Convert to hexadecimal - using base 16
			qtVersion = parseInt(qtVersion.substring(0, 1),16) + '.' + parseInt(qtVersion.substring(1, 2),16);
			qtVersion = qtVersion;
			qtInstalled = "Yes";
		}
		else // if the above 2 are unsuccessful, use VBscript (not that it is really any different from above)
		{
			document.write('<SCRIPT LANGUAGE="VBScript"\> \n');
			document.write('on error resume next \n');
			document.write('dim obQuicktime \n');
			document.write('set obQuicktime = CreateObject("QuickTimeCheckObject.QuickTimeCheck.1") \n');
			document.write('if IsObject(obQuicktime) then \n');
			document.write('	if obQuicktime.IsQuickTimeAvailalbe(0) then \n');
			document.write('		qtVersion = (Hex(obQuicktime.QuickTimeVersion)) / 1000000 \n');
			document.write('		qtVersion = CStr(qtVersion) \n');
			document.write('		qtVersion = mid(qtVersion, 1, 3) \n');
			document.write('	end if \n');
			document.write('end if \n');
			document.write('</SCRIPT\> \n');
		}
		control = null; 
	
		// check for RealPlayer
		var definedControls = 
		[
			'rmocx.RealPlayer G2 Control',
			'rmocx.RealPlayer G2 Control.1',
			'RealPlayer.RealPlayer(tm) ActiveX Control (32-bit)',
			'RealVideo.RealVideo(tm) ActiveX Control (32-bit)',
			'RealPlayer'
		 ];
		dcLength = definedControls.length; 
		for (k=0; k<dcLength; k++)
		{
			try
			{
				control = new ActiveXObject(definedControls[k]);
			}
			catch (e)
			{
				error = true;
			}
			if (control)
			{
				break;
			}
		}
		if (control)
		{
			realVersion = control.GetVersionInfo();
			realVersion = parseFloat(realVersion);
			realInstalled = "Yes";
		}
		control = null;
	
		//check for Windows Media Player
		try
		{
			control = new ActiveXObject('WMPlayer.OCX');
		}
		catch (e)
		{
			error = true;
		}
		if (control)
		{
			wmpVersion = parseFloat(control.versionInfo);
			wmpInstalled = "Yes";
		}
		control = null;
		
		//check for Silverlight Player
		try
		{
			control = new ActiveXObject('AgControl.AgControl');
		}
		catch (e)
		{
			error = true;
		}
		if (control)
		{
			switch (true) // Silverlight has it's own isInstalled function that will return true if provided the proper version string. 
						  // Ridiculous, yes, but it works.  This will have to be updated as new versions of Silverlight are released.
			{
				case control.IsVersionSupported("3.0") == true:
					silverlightVersion = "3.0";
					break;
				case control.IsVersionSupported("2.0") == true:
					silverlightVersion = "2.0";
					break;
				default:
					silverlightVersion = URLS.get('GET_SILVER');
					break;
			}
			silverlightInstalled = "Yes";
		}
		control = null;
	}
} // End pluginDetectIE()

function returnCheckPlugins() // Function starts the PluginCheck, called in html
{
	checkPlugins();
}

function returnFlashVersion() // Function returns Flash version, called in html
{
	return flashVersion;
	
} // End returnFlashVersion

function returnAdobeReaderVersion()  // Function returns Adobe Reader version, called in html
{
	return pdfVersion;
} // End returnAdobeReaderVersion

function returnShockwaveVersion() // Function returns Shockwave version, called in html
{
	return shockwaveVersion;
} // End returnShockwaveVersion

function returnQTVersion() // Function returns QuickTime version, called in html
{
	return qtVersion;
} // End returnQTVersion

function returnRealPlayerVersion() // Function returns RealPlayer version, called in html
{
	return realVersion;
} // End returnRealPlayerVersion()

function returnWMPVersion() // Function returns Windows Media Player version, called in html
{
	return wmpVersion;
} // End returnWMPVersion()

function returnSilverlightVersion() // Function returns Silverlight version, called in html
{
	return silverlightVersion;
} // End returnsilverlightVersion()
function returnJavaVersion(){
	return javaVersion;	
}
function plugTest(mo, mule) // Function shows the plugin div in the html file and hides the "Check Plugins" link
{
	document.getElementById(mo).style.display = "block";
	document.getElementById(mule).style.display = "none";
}
