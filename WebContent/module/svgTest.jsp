<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BundleManagerFactory,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.*"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser ISVG Test Page">
    <%
		//Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;

		// Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
		
		//use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
        String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");
    %>
    <bbNG:cssFile href="<%=cssUrl%>"/>

    <%
        final String pageTitle = rBundle.getString("svgTest.title");
        final String pageInstructions = rBundle.getString("svgTest.pageInstructions");

        final String bodyText = rBundle.getString("svgTest.text");

        // get variables needed for navigation

        final String closeWindow = rBundle.getString("language.close");
        final String closeUrl = "javascript:window.close();";
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-svg.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <p><%=bodyText%></p>
    <br>

    <bbNG:okButton url="<%=closeUrl%>" />

</bbNG:genericPage>