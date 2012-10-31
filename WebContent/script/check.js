/* 
 * Version 2.9
 * contributor: Jose M. Lopez, jm.lopez@utoronto.ca
 * Compatiblity Requirements for Bb 9.1 SP8
 * 
 * Version 2.8 
 * 12-14-2011
 * author: Shannon Meisenheimer, meisenheimer@ucmo.edu
 * Compatiblity Requirements for Bb 9.1 SP7
 * 
**/


var browserAgent, browserUserAgent, browserUserAgentLowerCase, browserVersion, browserPlatform, OSVersion, OSBit, platformVersion, safariVersion, browserPass;

browserUserAgent = navigator.userAgent;
browserUserAgentLowerCase = browserUserAgent.toLowerCase();
browserAgent = "Unknown Browser";
browserVersion = safariVersion = "Unknown Version";
browserPlatform = "Unknown Platform";
platformVersion = "Unknown OS";

switch (true) // OSBitSwitch - Check for 64 or 32 bit
{
	case browserUserAgentLowerCase.indexOf('wow64') >= 0:
		OSBit = "64";
		break;
	case browserUserAgentLowerCase.indexOf('win64') >= 0:
		OSBit = "64";
		break;
	case browserUserAgentLowerCase.indexOf('x64') >= 0:
		OSBit = "64";
		break;
} // End OSBitSwitch

var IMAGES = (function() {
    var private = {
        'PASS' : '../images/pass.png',
        'FAIL' : '../images/fail.png',
        'WARN' : '../images/warning.png'
    };

    return {
       get: function(name) { return private[name]; }
   };
})();

switch (true) // WinOSSwitch - Check if platform is Windows
{
	case browserUserAgentLowerCase.indexOf('win 9x 4.90') >= 0: // agent string contains "windows" and "win", this needs to go first
 		browserPlatform = "Windows";
		platformVersion = "Windows ME";
		break;
	case browserUserAgentLowerCase.indexOf('winnt') >= 0: // agent string does not contain "windows" - rare
		browserPlatform = "Windows";
		platformVersion = "Windows NT";
		break;
	case browserUserAgentLowerCase.indexOf('windows; u') >= 0: // browsers with strong security contain both Platform and OS, U = stong security
		browserPlatform = "Windows";
		OSVersion = browserUserAgentLowerCase.split("windows; u;");
		OSVersion = OSVersion[1].split("windows");
		OSVersion = OSVersion[1].split(";");
		OSVersion = OSVersion[0];
		break;
	case browserUserAgentLowerCase.indexOf('windows') >= 0:
		browserPlatform = "Windows";
		OSVersion = browserUserAgentLowerCase.split('windows');
		OSVersion = OSVersion[1].split(";");
		OSVersion = OSVersion[0];
		break;
	case browserUserAgentLowerCase.indexOf('98') >= 0: // agent string does not contain "windows" - rare
		browserPlatform = "Windows";
		platformVersion = "Windows 98";
		break;
	case browserUserAgentLowerCase.indexOf('95') >= 0: // agent string does not contain "windows" - rare
		browserPlatform = "Windows";
		platformVersion = "Windows 95";
		break;
} // End WinOSSwitch

switch (true) // OtherOSSwitch - Check non-Windows Platform
{
	case browserPlatform != "Unknown Platform": // platform is Windows
		break;
	case browserUserAgentLowerCase.indexOf('macintosh') >= 0:
		browserPlatform = platformVersion = "Macintosh";
		switch (true) // MacVersionSwitch - Check Mac OS version
		{
			case browserUserAgentLowerCase.indexOf('mac os x 10_8_0') >= 0:
				platformVersion = "Mac OSX 10.8";
			break;
			case browserUserAgentLowerCase.indexOf('mac os x 10_7_0') >= 0:
				platformVersion = "Mac OSX 10.7";
			break;
			case browserUserAgentLowerCase.indexOf('mac os x 10_6') >= 0:
				platformVersion = "Mac OSX 10.6";
				break;
			case browserUserAgentLowerCase.indexOf('mac os x 10.6') >= 0:
				platformVersion = "Mac OSX 10.6";
				break;
			case browserUserAgentLowerCase.indexOf('mac os x 10_5') >= 0:
				platformVersion = "Mac OSX 10.5";
				break;
			case browserUserAgentLowerCase.indexOf('mac os x') >= 0:
				platformVersion = "Mac OSX";
				break;
			case browserUserAgentLowerCase.indexOf('powerPC') >= 0:
				platformVersion = "Mac PowerPC";
				break;
		}
		break;
	case browserUserAgentLowerCase.indexOf('linux') >= 0:
		browserPlatform = platformVersion = "Linux";
		break;
	case browserUserAgentLowerCase.indexOf('sunos') >= 0:
		browserPlatform = platformVersion = "Sun OS";
		break;
	case browserUserAgentLowerCase.indexOf('x11') >= 0: // *NIX or UNIX-like platform
		browserPlatform = platformVersion = "UNIX";
		break;
} // End OtherOSSwitch

switch (true) // WinVersionSwitch - Check Windows version
{
	case platformVersion != "Unknown OS": // version was assigned in WinOSSwitch or platform is non-Windows
		break;
	case OSVersion == " nt 6.1" && OSBit == "64":
		platformVersion = "Windows 7 64-bit";
		break;
	case OSVersion == " nt 6.1":
		platformVersion = "Windows 7";
		break;
	case OSVersion == " nt 6.0" && OSBit == "64":
		platformVersion = "Windows Vista 64-bit";
		break;
	case OSVersion == " nt 6.0":
		platformVersion = "Windows Vista";
		break;
	case OSVersion == " nt 5.2":
		platformVersion = "Windows .NET Server";
		break;
	case OSVersion == " nt 5.1" && OSBit == "64":
		platformVersion = "Windows XP 64-bit";
		break;
	case OSVersion == " nt 5.1":
		platformVersion = "Windows XP";
		break;
	case (OSVersion == " nt 5.0") || (OSVersion == " 2000"):
		platformVersion = "Windows 2000";
		break;
	case (OSVersion == " nt") || (OSVersion == " nt 4.0"):
		platformVersion = "Windows NT";
		break;
	case OSVersion == " 98":
		platformVersion = "Windows 98";
		break;
	case OSVersion == " 95":
		platformVersion = "Windows 95";
		break;
	case OSVersion == " 3.1":
		platformVersion = "Windows 3.1";
		break;
	case OSVersion == " ce":
		platformVersion = "Windows CE";
		break;
} // End WinVersionSwitch

switch (true) // BrowserSwitch - Checks browser and browser version
{
	case browserUserAgentLowerCase.indexOf('msie') >= 0: // browser is Internet Explorer, check the gorilla first
		browserAgent = "Internet Explorer";
  		browserVersion = browserUserAgentLowerCase.split('msie');
  		browserVersion = browserVersion[1].split(";");
  		browserVersion = browserVersion[0];
		break;
	case browserUserAgentLowerCase.indexOf('firefox') >= 0 && browserUserAgentLowerCase.indexOf('navigator') < 0: // browser is Firefox
		browserAgent = "Firefox";
  		browserVersion = browserUserAgentLowerCase.split('firefox/');
		browserVersion = browserVersion[1].substring(0,5);
		break;
	case browserUserAgentLowerCase.indexOf('chrome') >= 0: // browser is Chrome, this must be checked before Safari
		browserAgent = "Chrome";
		browserVersion = browserUserAgentLowerCase.split('chrome/');
		browserVersion = browserVersion[1].substring(0,4);
		break;
	case browserUserAgentLowerCase.indexOf('safari') >= 0: // browser is Safari
		browserAgent = "Safari";
		switch (true) // SafariVersionSwitch - Checks Safari version
		{
			case browserUserAgentLowerCase.indexOf('version') >= 0: // Checks if agent contains "version"
				browserVersion = browserUserAgentLowerCase.split('version/');
				browserVersion = browserVersion[1].split(" ");
				browserVersion = browserVersion[0];
				break;
			default: 
				browserVersion = browserUserAgentLowerCase.split('safari/');
				browserVersion = browserVersion[1].substring(0,3);
				switch (true) // SafariVersion2.0Switch - Checks Safari versions 2.04 and lower
				{
					case (browserVersion == "419") || (browserVersion == "417") || (browserVersion == "416") || (browserVersion == "412"):
						safariVersion = "2.0";
						break;
					case browserVersion == "312":
						safariVersion = "1.3";
						break;
					case browserVersion == "125":
						safariVersion = "1.2";
						break;
					case browserVersion == "100":
						safariVersion = "1.1";
						break;
					case browserVersion.substring(0,2) == "85":
						safariVersion = "1.0";
						break;
				}
				browserVersion = safariVersion;
				break;
		}
		break;
	case browserUserAgentLowerCase.indexOf('navigator') >= 0:  // browser is Netscape 9.x
		browserAgent = "Netscape";
		browserVersion = "9.0";
		break;
	case browserUserAgentLowerCase.indexOf('netscape') >= 0:  // browser is Netscape 6.x - 8.x
		browserAgent = "Netscape";
		browserVersion = browserUserAgentLowerCase.split('netscape/');
		browserVersion = browserVersion[1].substring(0,3);
		break;	
} // End BrowserSwitch

function returnBrowserPlatform() // Function returns the platform/operating system
{
	return platformVersion; 
} // End returnBrowserPlatform()

function returnBrowserAgent() // Function returns the browser
{
  return browserAgent;  
} // End returnBrowserAgent

function returnBrowserVersion() // Function returns the browser version
{
  return browserVersion;  
} // End returnBrowserVersion

function checkBrowser() // Function checks for browser/OS compatibility with Bb
{
	switch (true) // BrowserCompatibilitySwitch
	{
		case browserAgent == "Internet Explorer": // browser is IE
			switch (true) // IECompatibilitySwitch
			{
				case browserPlatform == "Windows": // platform is Windows
					switch (true) // IEWindowsSwitch
					{
						case platformVersion == "Windows 7 64-bit":
							switch (true) // IEVersionWin7-64Switch - what versions of IE are OK for Windows 7-64
							{
								case parseFloat(browserVersion) > 9.0:
									browserPass = "warning";
									break;
								case parseFloat(browserVersion) == 9.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 8.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows 7":
							switch (true) // IEVersionWin7Switch - what versions of IE are OK for Windows 7
							{
								case parseFloat(browserVersion) > 9.0:
									browserPass = "warning";
									break;
								case parseFloat(browserVersion) == 9.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 8.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows Vista 64-bit":
							switch (true) // IEVersionVista-64Switch - what versions of IE are OK for Vista-64
							{
								case parseFloat(browserVersion) > 9.0:
									browserPass = "warning";
									break;
								case parseFloat(browserVersion) == 9.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 8.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows Vista":
							switch (true) // IEVersionVistaSwitch - what versions of IE are OK for Vista
							{
								case parseFloat(browserVersion) > 9.0:
									browserPass = "warning";
									break;
								case parseFloat(browserVersion) == 9.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 8.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows XP":
							switch (true) // IEVersionXPSwitch - what versions of IE are OK for XP
							{
								case parseFloat(browserVersion) >= 9.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) == 8.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						default: // Other versions of Windows are not supported
							browserPass = "fail";
							break;
					}
					break;
				default: // IE (of any version) does not pass for any OS other than Windows
					browserPass = "fail";
					break;
			}
			break;
		case browserAgent == "Firefox":  // browser is Firefox
			switch (true) // FirefoxCompatibilitySwitch
			{
				case browserPlatform == "Windows": // platform is Windows
					switch (true) // FirefoxWindowsSwitch
					{
						case platformVersion == "Windows 7 64-bit":
							switch (true) // FirefoxVersionWin7-64Switch - what versions of Firefox are OK for Win7-64
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows 7":
							switch (true) // FirefoxVersionWin7Switch - what versions of Firefox are OK for Win7
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows Vista 64-bit":
							switch (true) // FirefoxVersionVista-64Switch - what versions of Firefox are OK for Vista-64
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;	
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows Vista":
							switch (true) // FirefoxVersionVistaSwitch - what versions of Firefox are OK for Vista
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "warning";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows XP":
							switch (true) // FirefoxVersionXPSwitch - what versions of Firefox are OK for XP
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "warning";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						default: // Other versions of Windows are not supported
							browserPass = "fail";
							break;
					}
					break;
				case browserPlatform == "Macintosh": // platform is Mac
					switch (true) // FirefoxMacSwitch
					{
					// Added by JM - UofT
						case platformVersion == "Mac OSX 10.7":
							switch (true) // FirefoxVersionOSX10.7Switch - what versions of Firefox are OK for OSX 10.6
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "warning";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Mac OSX 10.6":
							switch (true) // FirefoxVersionOSX10.6Switch - what versions of Firefox are OK for OSX 10.6
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "warning";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Mac OSX 10.5":
							switch (true) // FirefoxVersionOSX10.5Switch - what versions of Firefox are OK for OSX 10.5
							{
								case parseFloat(browserVersion) > 14.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 4.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) >= 3.6:
									browserPass = "warning";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						default: // Other versions of Mac OS are not supported 
								 // Mac OS 10.8 not supported yet
							browserPass = "fail";
							break;
					}
					break;
				default: // OS other than Mac or Windows are not supported
						 // Unfortunately
					browserPass = "fail";
					break;
			}
			break;
		case browserAgent == "Safari": // browser is Safari
			switch (true) // SafariCompatibilitySwitch
			{
				case browserPlatform == "Macintosh":
				switch (true) // SafariMacSwitch
					{
						case platformVersion == "Mac OSX 10.7":
							switch (true) // SafariVersionOSX10.6Switch - what versions of Safari are OK for OSX 10.6
							{
								case parseFloat(browserVersion) == 5.1:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) == 5.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) == 4.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Mac OSX 10.6":
							switch (true) // SafariVersionOSX10.6Switch - what versions of Safari are OK for OSX 10.6
							{
								case parseFloat(browserVersion) == 5.1:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) == 5.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) == 4.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Mac OSX 10.5":
							switch (true) // SafariVersionOSX10.5Switch - what versions of Safari are OK for OSX 10.5
							{
								case parseFloat(browserVersion) == 5.1:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) == 5.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) == 4.0:
									browserPass = "pass";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						default: // Other versions of Mac OS are not supported
							browserPass = "fail";
							break;
					}
					break;
				default: // OS other than Mac are not supported
					browserPass = "fail";
					break;
			}
			break;
		case browserAgent == "Chrome": // Browser is Chrome
		
			switch (true) // ChromeCompatibilitySwitch
			{
				case browserPlatform == "Windows": // platform is Windows
					switch (true) // ChromeWindowsSwitch
					{
						case platformVersion == "Windows 7 64-bit":
							switch (true) // ChromeVersionWin7-64Switch - what versions of Chrome are OK for Win7-64
							{
								case parseFloat(browserVersion) > 22.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows 7":
							switch (true) // ChromeVersionWin7Switch - what versions of Chrome are OK for Win7
							{
								case parseFloat(browserVersion) > 22.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows Vista 64-bit":
							switch (true) // ChromeVersionVista-64Switch - what versions of Chrome are OK for Vista-64
							{
								case parseFloat(browserVersion) > 22.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows Vista":
							switch (true) // ChromeVersionVistaSwitch - what versions of Chrome are OK for Vista
							{
								case parseFloat(browserVersion) > 22.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Windows XP":
							switch (true) // ChromeVersionXPSwitch - what versions of Chrome are OK for XP
							{
								case parseFloat(browserVersion) > 22.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						default: // Other versions of Windows are not supported
							browserPass = "fail";
							break;
					}
					break;
				case browserPlatform == "Macintosh": // platform is Mac
					switch (true) // ChromeMacSwitch
					{
						case platformVersion == "Mac OSX 10.6":
							switch (true) // ChromeVersionOSX10.6Switch - what versions of Chrome are OK for OSX 10.6
							{
								case parseFloat(browserVersion) > 15.0:
									browserPass = "warning";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						case platformVersion == "Mac OSX 10.5":
							switch (true) // ChromeVersionOSX10.5Switch - what versions of Chrome are OK for OSX 10.5
							{
								case parseFloat(browserVersion) > 22.0:
									browserPass = "fail";
									break;
								case parseFloat(browserVersion) >= 15.0:
									browserPass = "pass";
									break;
								case parseFloat(browserVersion) < 10.0:
									browserPass = "fail";
									break;
								default:
									browserPass = "fail";
									break;
							}
							break;
						default: // Other versions of Mac OS are not supported
							browserPass = "fail";
							break;
					}
					break;
				default: // OS other than Mac or Windows are not supported
					browserPass = "fail";
					break;
			}
			break;
			
		case browserAgent == "Netscape": // Browser is Netscape
			browserPass = "fail";
			break;
	}
	/*
	switch (true)
	{
		case browserPass == "pass": // if check passes load a pass image
			document["browserImg"].src = IMAGES.get('PASS');
			document["browserImg"].alt = "Pass";
			break;
		case browserPass == "warning": // loads a warning image
			document["browserImg"].src = IMAGES.get('WARN');
			document["browserImg"].alt = "Warning";
			break;
		case browserPass == "fail": // loads fail image, most of the checks have a preloaded fail image in the html file - assume fail 
			document["browserImg"].src = IMAGES.get('FAIL');
		   	document["browserImg"].alt = "Fail";
			break;
	}*/
} // End checkBrowser()


function checkPopup() // Checks if pop-ups are allowed
{
	window.open("popup.html","popup","toolbar=no, width=250, height=250");
} // End checkPopup()

function checkCookies()
{
	var msg;
	msg = " ";
	navigator.cookiesAreEnabled = checkCookiesAreEnabled();
	if (navigator.cookiesAreEnabled) 
	{
		document["cookiesImg"].src = IMAGES.get('PASS');
		document["cookiesImg"].alt = "Pass";
		msg = " ";
	} 
	return msg; 
} // End checkCookies()

function checkCookiesAreEnabled() 
{
	setCookie("mo", "mule");
	if (getCookie("mo")) 
	{
    	deleteCookie("mule");
    	return true;
  	} else
	{
    	return false;
	}
} // End checkCookiesAreEnabled()

function getCookie(name)
{
	var arg = name + "=";
	var alen = arg.length;
	var clen = document.cookie.length;
	var i = 0;
	while (i < clen)
	{
    	var j = i + alen;
    	if (document.cookie.substring(i, j) == arg) return getCookieVal(j);
    	i = document.cookie.indexOf(" ", i) + 1;
    	if (i == 0) break;
	}
  	return null;
} // End getCookie()

function getCookieVal(offset) 
{
	var endstr = document.cookie.indexOf (";", offset);
	if (endstr == -1) endstr = document.cookie.length;
	return unescape(document.cookie.substring(offset, endstr));
} // End getCookieval()

function deleteCookie(name, path, domain) 
{
	if (getCookie(name)) 
	{
    	document.cookie = name + "=" +
    	((path) ? "; path=" + path : "") +
    	((domain) ? "; domain=" + domain : "") +
    	"; expires=Thu, 01-Jan-70 00:00:01 GMT";
	}
} // End deleteCookie()

function setCookie(name, value, expires, path, domain, secure)
{
	document.cookie = name + "=" + escape (value) +
  	((expires) ? "; expires=" + expires.toGMTString() : "") +
	((path) ? "; path=" + path : "") +
	((domain) ? "; domain=" + domain : "") +
	((secure) ? "; secure" : "");
} // End setCookie()

function checkPorts() // Checks for allowed ports - could also be used for 443 and/or Collaboration Server ports
{
	if (document.images) 
  	{
		imgPort80URL = IMAGES.get('PASS');
   		var imgPort80 = new Image();
		imgPort80.src = imgPort80URL;
    	if (imgPort80.width = "55") 
		{
       		document["port80Img"].src=imgPort80URL;
	   		document["port80Img"].alt="Pass";
    	}
  	}
} // End checkPorts()

function runChecks() // runs the check functions, except checkPlugins()
{
	checkBrowser();
	document["javaScriptImg"].src=IMAGES.get('PASS'); // if Javascript is enabled this will be passed to the html file
	document["javaScriptImg"].alt="Pass"; // if Javascript is enabled this will be passed to the html file
	checkCookies();
	//checkPopup();
	//checkPorts();	
} // End runChecks()

window.onload=runChecks; // this calls the runChecks() function once the html is rendered