<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import ="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.intl.BundleManagerFactory,
        java.util.ResourceBundle,
        java.util.Iterator, java.util.ArrayList,
        blackboard.platform.plugin.PlugInUtil,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser Java Test Page" onLoad="Feedback.init();">
    <%
    //Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;

    	// Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
    	//use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
        final String pageInstructions = rBundle.getString("testJava.pageInstructions");
        final String pageTitle = rBundle.getString("testJava.Title");
        final String pageStepTwoInstructions = rBundle.getString("testJava.StepTwoInstructions");
        final String enableBrowserTitle = rBundle.getString("testJava.enableBrowser.Title");
        final String enableBrowserURL = rBundle.getString("testJava.enableBrowser.URL");
        final String enablePluginTitle = rBundle.getString("testJava.enablePlugin.Title");
        final String enablePluginURL = rBundle.getString("testJava.enablePlugin.URL");
        final String clearCacheTitle = rBundle.getString("testJava.clearCache.Title");
        final String clearCacheURL = rBundle.getString("testJava.clearCache.URL");
        final String specialBrowser1Title = rBundle.getString("testJava.specialBrowser1.Title");
        final String specialBrowser1URL =  rBundle.getString("testJava.specialBrowser1.URL");
        final String specialBrowser2Title  = rBundle.getString("testJava.specialBrowser2.Title");
        final String specialBrowser2URL = rBundle.getString("testJava.specialBrowser2.URL");
        final String supportedSystemTitle = rBundle.getString("testJava.supportedSystem.Title");
        final String supportedSystemURL = rBundle.getString("testJava.supportedSystem.URL");
        String closeWindow = rBundle.getString("testJava.close");
		String closeUrl = "javascript:window.close();";
        String iconURL = "../images/bt-java.png";
        
        String appletUrl = PlugInUtil.getUri(vendorId, handle, "script/");
        
       	// Testing purposes
     	final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
     	final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
        
    %>
    <!-- Feedback widget -->
    <bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
    <!-- Feedback widget -->


    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="<%=iconURL %>" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>
	<bbNG:dataCollection markUnsavedChanges="false" showSubmitButtons="false" >
		<bbNG:step title="Java Applet tester" hideNumber="true">
                 	<bbNG:dataElement label="" isRequired="false">	
						<applet code="ca.utoronto.its.lms.tools.btest.util.JavaCheck" 
    					    archive="../script/JavaCheckUtil.jar"
		                    width="500"
		                    height="250" >
						</applet>
                    </bbNG:dataElement>
        </bbNG:step>
        <bbNG:step title="Recommendations" instructions="<%=pageStepTwoInstructions %>" hideNumber="true">
        <div class="vtbegenerated">
        	<ul>
        		<li><a href="<%=enableBrowserURL %>"><%=enableBrowserTitle %></a></li>
        		<li><a href="<%=enablePluginURL %>"><%=enablePluginTitle %></a></li>
				<li><a href="<%=clearCacheURL %>"><%=clearCacheTitle %></a></li>
        		<li><a href="<%=specialBrowser1URL %>"><%=specialBrowser1Title %></a></li>
        		<li><a href="<%=specialBrowser2URL %>"><%=specialBrowser2Title %></a></li>
        		<li><a href="<%=supportedSystemURL %>"><%=supportedSystemTitle %></a></li>
        	</ul>
        </div>
		</bbNG:step>
	</bbNG:dataCollection>

    <bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>

</bbNG:genericPage>