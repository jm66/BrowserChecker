<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%--
    Document   : module/testBrowser.jsp
    Created on : 30-Oct-2008, 10:31:46
    Author     : Dr Malcolm Murray
--%>
<%@ page info="Browser Test Tool" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="java.text.DecimalFormat,
        blackboard.platform.plugin.PlugInUtil,
        blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        java.util.ResourceBundle,
        java.util.ArrayList,
        java.util.Iterator,
        java.util.Properties,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.*"
        errorPage="../error.jsp"%>

<%@ taglib uri="/bbNG" prefix="bbNG"%>
<bbNG:genericPage ctxId="ctx" title="Test Browser Page" onLoad="setTechnical(); Feedback.init();">
    <%
        // Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;
        Properties pConfig = (Properties) this.getServletContext().getAttribute(handle + "_pConfig");
        // Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
        //use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
		
        // JS & CSS resources
        String jsFile = PlugInUtil.getUri(vendorId, handle, "script/check.js");
        String jsFilePlugins = PlugInUtil.getUri(vendorId, handle, "script/plugins.js");
        String jsFileBT = PlugInUtil.getUri(vendorId, handle, "script/browserTests.js");
        String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");

     	// Testing purposes
     	final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
     	final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
    %>
    <!-- Feedback widget -->
    <bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
    <!-- Feedback widget -->
    
    <bbNG:cssFile href="<%=cssUrl%>"/>
    <bbNG:jsFile href="<%=jsFile%>"/>
    <bbNG:jsFile href="<%=jsFilePlugins%>"/>
    <bbNG:jsFile href="<%=jsFileBT%>"/>
    <%

        // get variables needed to construct the breadCrumb trail and other navigation tasks
        String tabUrl = request.getParameter("tabUrl");

        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);
        boolean displayOffCampusButton = hOptions.isOffCampusButtonDisplayed();

        // now declare all the standard text items to keep Tomcat 6 happy:
        final String breadcrumbName = rBundle.getString("root_Breadcrumb");
        final String pageInstructions = rBundle.getString("testBrowser.pageInstructions");
        final String helpPage = "help.jsp?tabUrl=" + tabUrl;
        final String popUpUrl = "testPopUp.jsp";

        final String actionButton1Title = rBundle.getString("testBrowser.moreInfo");
        final String actionButton1Url = "moreInfo.jsp?tabUrl=" + tabUrl;
        final String actionButton2Title = rBundle.getString("testBrowser.offCampus");
        final String actionButton2Url = "offCampus.jsp?tabUrl=" + tabUrl;
        final String actionButton3Title = rBundle.getString("testBrowser.credits");
        final String actionButton3Url = "credits.jsp?tabUrl=" + tabUrl;

        final String otherTests = rBundle.getString("testBrowser.otherTests");
        final String languagesText = rBundle.getString("languages.languages");
        final String languagesUrl = "javascript:checkBigPopUp('languages.jsp?tabUrl=" + tabUrl + "');";
        final String mediaText = rBundle.getString("testBrowser.Audio.Video");
        final String mediaUrl = "javascript:checkBigPopUp('media.jsp?tabUrl=" + tabUrl + "');";
        final String vtbeText = rBundle.getString("testBrowser.vtbe");
        final String vtbeUrl = "javascript:checkBigPopUp('vtbe.jsp?tabUrl=" + tabUrl + "');";
        final String bandwText = rBundle.getString("testBrowser.bandwidth");
        final String bandwUrl = "javascript:checkBigPopUp('bwidth/bandwidth.jsp?tabUrl=" + tabUrl + "');";
        final String thirdPText = rBundle.getString("testBrowser.thirdParty");
        final String thirdPUrl = "javascript:checkBigPopUp('thirdParty.jsp?tabUrl=" + tabUrl + "');";
        final String JavaText = rBundle.getString("testBrowser.Java");
        final String JavaUrl = "javascript:checkBigPopUp('java.jsp?tabUrl=" + tabUrl + "');";
        final String ssoText = rBundle.getString("testBrowser.SSO");

        //final String ssoUrl = "javascript:checkBigPopUp('ssoValid.jsp?tabUrl=" + tabUrl + "');";
        final String ssoUrl = "ssoValid.jsp?tabUrl=" + tabUrl + "');";

        // need to add these fields to the request as the actionMenuItem tag is scriptless :-(
        // use JSTL tags to set them later in the bbNG entry
        request.setAttribute("otherTests", otherTests);
        request.setAttribute("languagesText", languagesText);
        request.setAttribute("languagesUrl", languagesUrl);
        request.setAttribute("mediaText", mediaText);
        request.setAttribute("mediaUrl", mediaUrl);
        request.setAttribute("vtbeText", vtbeText);
        request.setAttribute("vtbeUrl", vtbeUrl);
        request.setAttribute("bandwText", bandwText);
        request.setAttribute("bandwUrl", bandwUrl);
        request.setAttribute("thirdPText", thirdPText);
        request.setAttribute("thirdPUrl", thirdPUrl);
        request.setAttribute("JavaText", JavaText);
        request.setAttribute("JavaUrl", JavaUrl);
        request.setAttribute("ssoText", ssoText);
        request.setAttribute("ssoUrl", ssoUrl);

        String user_agent = "returnBrowserAgent();";
        String user_agentVersion = "returnBrowserVersion();";
        String user_os = "returnBrowserPlatform();";
        String plug_flash= "returnFlashVersion();";
        String plug_shockwave= "returnShockwaveVersion();";
        String plug_reader = "returnAdobeReaderVersion()";
        String plug_qtime = "returnQTVersion()";
        String plug_rp = "returnRealPlayerVersion();";
        String plug_wmv = "returnWMPVersion();";
        String plug_silver= "returnSilverlightVersion();";
        
        final String testAlert = rBundle.getString("testBrowser.alertTest");
        final String alertClick = "javascript:alert('" + rBundle.getString("testBrowser.AlertMessage") + "');";
        final String testPopup = rBundle.getString("testBrowser.popupTest");
        final String popupClick = "javascript:checkPopUp('" + popUpUrl + "');";

    %>
    <bbNG:jsBlock>
        <script language="JavaScript" type="text/JavaScript">
            function setTechnical() {
                document.getElementById('user_agent').innerHTML = <%=user_agent%>;
                document.getElementById('user_agentVersion').innerHTML = <%=user_agentVersion%>;
                document.getElementById('user_os').innerHTML = <%=user_os%>;
                document.getElementById('flash').innerHTML = <%=plug_flash%>;
                document.getElementById('shockwave').innerHTML = <%=plug_shockwave%>;
                document.getElementById('reader').innerHTML = <%=plug_reader%>;
                document.getElementById('qtime').innerHTML = <%=plug_qtime%>;
                document.getElementById('wmv').innerHTML = <%=plug_wmv%>;
                document.getElementById('realp').innerHTML = <%=plug_rp%>;
                document.getElementById('silver').innerHTML = <%=plug_silver%>;
                document.getElementById('resol').innerHTML = screen.width+" x "+screen.height;
                
				// Javascript Test 
                if (document.getElementById('javaScriptImg').alt == "Pass") 
                	document.getElementById('js-txt').innerHTML = "<%=rBundle.getString("testBrowser.Required.javascript") %>";
                else
                	document.getElementById('js-txt').innerHTML = "<%=rBundle.getString("testBrowser.Required.javascriptFail.text") %>";
                	
                // Screen Resoultion
                if(screen.width<800){
                	document.getElementById('resol-txt').innerHTML = "<%=rBundle.getString("testBrowser.resolution.warning") %>;";
                }
                
                // JS Java test
                if(javaInstalled == "Yes"){
                	document.getElementById('javaImg').src = '../images/pass.png';
                	document.getElementById('javaImg').alt = 'Pass';
                	document.getElementById('java-txt').innerHTML = "<%=rBundle.getString("testBrowser.Required.Java") %>;";
                }
                else
                	document.getElementById('java-txt').innerHTML = "<%=rBundle.getString("testBrowser.Required.JavaFail") %>;";
                
                // Cookies Validation Message
                if (checkCookies())
                	document.getElementById('cookies-txt').innerHTML = "<%=rBundle.getString("testBrowser.Required.Cookies") %>";
                 else 
                	document.getElementById('cookies-txt').innerHTML = "<%=rBundle.getString("testBrowser.Required.CookiesFail") %>";


                <%
                // new: get the browser from the request
                String browserSettings = request.getHeader("User-Agent");
                if (browserSettings.toLowerCase().contains("msie")) {
                    // warn the user they may be swamped with security warnings
                    out.print("document.getElementById('user-agent-ie').innerHTML=\""+
                    rBundle.getString("testBrowser.ie.security.warning")+"\";");
                }
           	   %>
               
            }
        </script>
    </bbNG:jsBlock>
    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:breadcrumbBar environment="PORTAL" >
            <bbNG:breadcrumb> <%=breadcrumbName%></bbNG:breadcrumb>
        </bbNG:breadcrumbBar>
        <bbNG:pageTitleBar iconUrl="../images/bt-main.png" showTitleBar="true" title="<%=breadcrumbName%>"/>
    </bbNG:pageHeader>

    <bbNG:actionControlBar>
        <bbNG:actionMenu title="<%=otherTests%>" primary="true">
            <bbNG:actionMenuItem title="${ thirdPText }" href="${ thirdPUrl }"/>
            <bbNG:actionMenuItem title="${ bandwText }" href="${ bandwUrl }"/>
            <bbNG:actionMenuItem title="${ languagesText }" href="${ languagesUrl }"/>
            <bbNG:actionMenuItem title="${ mediaText }" href="${ mediaUrl }"/>
            <bbNG:actionMenuItem title="${ vtbeText }" href="${ vtbeUrl }"/>
            <bbNG:actionMenuItem title="${ JavaText }" href="${ JavaUrl }"/>
            <bbNG:actionMenuItem title="${ ssoText }" href="${ ssoUrl }"/>
        </bbNG:actionMenu>
        <bbNG:actionButton title="<%=actionButton1Title%>" url="<%=actionButton1Url%>" primary="false"/>
        <% if (displayOffCampusButton) {%>
        <bbNG:actionButton title="<%=actionButton2Title%>" url="<%=actionButton2Url%>" primary="false"/>
        <% }%>

        <bbNG:actionButton title="<%=actionButton3Title%>" url="<%=actionButton3Url%>" primary="false"/>
    </bbNG:actionControlBar>
	<%
		StringBuffer computerText = new StringBuffer();
		computerText.append(rBundle.getString("testBrowser.yourComputer.text"));

        if (hOptions.isBbWikiLinkDisplayed()) {
           computerText.append(hOptions.getBbWikiUrlAsParagraph());
        }
    %>
 
    <bbNG:dataCollection markUnsavedChanges="false" showSubmitButtons="false">
        <bbNG:step title="<%=rBundle.getString(\"testBrowser.yourComputer\") %>" 
        instructions="<%=computerText.toString() %>" 
        hideNumber="true">
            <bbNG:dataElement label="<%=rBundle.getString(\"testBrowser.BrowserName\") %>" isRequired="false" >
            	<div class="field" id="user_agent"></div>
            </bbNG:dataElement>
            <bbNG:dataElement label="<%=rBundle.getString(\"testBrowser.BrowserVersion\") %>" isRequired="false">
            	<div class="field" id="user_agentVersion"></div>
            </bbNG:dataElement>
            <bbNG:dataElement label="<%=rBundle.getString(\"testBrowser.Platform\") %>" isRequired="false">
                <div class="field" id="user_os"></div>
            </bbNG:dataElement>
            <bbNG:dataElement label="<%=rBundle.getString(\"testBrowser.resolution\") %>" isRequired="false">
                <div class="field" id="resol"></div>
                <div class="field" id="resol-txt"></div>
            </bbNG:dataElement>
			<span class="fieldErrorText" id="user-agent-ie"></span>
        </bbNG:step>
        <bbNG:step title="<%=rBundle.getString(\"testBrowser.Required\")%>" 
        instructions="<%=rBundle.getString(\"testBrowser.Required.text\")%>" 
        hideNumber="true"> 
	        <bbNG:dataElement label="JavaScript" isRequired="false">
	        	<img src="../images/fail.png" name="javaScriptImg" id="javaScriptImg" alt="Fail" />
	        	<div class="field" id="js-txt"></div>
	        </bbNG:dataElement>
	        <bbNG:dataElement label="Cookies" isRequired="false">
	        	<img src="../images/fail.png" name="cookiesImg" id="cookiesImg" alt="Fail" />
	        	<div class="field" id="cookies-txt"></div>
	        </bbNG:dataElement>
	        <bbNG:dataElement label="Java" isRequired="false">
	        	<img src="../images/fail.png" name="javaImg" id="javaImg" alt="Fail" />
	        	<div class="field" id="java-txt"></div>
	        	<div class="field" id="java-test">
		        	 <%=rBundle.getString("testBrowser.Required.JavaTest") %>
		        	 <bbNG:button url="${ JavaUrl }" label="${ JavaText }"/>
	        	</div>
	        </bbNG:dataElement>
        </bbNG:step>
        <bbNG:step title="<%=rBundle.getString(\"testBrowser.Optional\")%>" 
        instructions="<%=rBundle.getString(\"testBrowser.Optional.text\")%>" 
        hideNumber="true"> 
	        <div style="visibility:hidden;">
		        <script language="JavaScript" type="text/JavaScript">
		        	document.write(returnCheckPlugins());
		        </script>
	        </div>
	        <bbNG:dataElement label="Adobe Flash" isRequired="false">
	        	<div class="flash" id="flash"></div>
	        </bbNG:dataElement>
	        <bbNG:dataElement label="Adobe Shockwave" isRequired="false">
	        	<div class="field" id="shockwave"></div>
	        </bbNG:dataElement>
	        <bbNG:dataElement label="Adobe Reader" isRequired="false">
	        	<div class="field" id="reader"></div>
	        </bbNG:dataElement>
        	<bbNG:dataElement label="Apple QuickTime" isRequired="false">
        		<div class="field" id="qtime"></div>
        	</bbNG:dataElement>
        	<bbNG:dataElement label="RealPlayer" isRequired="false">
        		<div class="field" id="realp"></div>
        	</bbNG:dataElement>
        	<bbNG:dataElement label="Windows Media Player" isRequired="false">
        		<div class="field" id="wmv"></div>
        	</bbNG:dataElement>
        	<bbNG:dataElement label="Microsoft Silverlight" isRequired="false">
        		<div class="field" id="silver"></div>
        	</bbNG:dataElement>
        </bbNG:step>
        <bbNG:step title="<%=rBundle.getString(\"testBrowser.PopUp\")%>" 
        instructions="<%=rBundle.getString(\"testBrowser.PopUp.text\")%>" 
        hideNumber="true"> 
        	<bbNG:dataElement label="" isRequired="false">
			    <bbNG:button id="alertTest" label="<%=testAlert%>" onClick="<%=alertClick%>"/>&nbsp;
			    <bbNG:button id="popupTest" label="<%=testPopup%>" onClick="<%=popupClick%>"/>
		    </bbNG:dataElement>
        </bbNG:step>
        
    </bbNG:dataCollection>


<bbNG:okButton url="<%=tabUrl%>"/>

</bbNG:genericPage>
