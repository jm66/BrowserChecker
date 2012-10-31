<%--
    Document   : module/view.jsp
    Created on : 30-Oct-2008, 10:31:46
    Author     : Dr Malcolm Murray
--%>
<%@ page info="Browser Test Tool" language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@page import="blackboard.platform.plugin.PlugInUtil,
        blackboard.portal.servlet.*,
        blackboard.portal.data.*,
        blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        java.util.ResourceBundle,
        java.util.Properties,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.HelpOptions"
        errorPage="/error.jsp"%>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 
<bbNG:includedPage ctxId="ctx">
    <%
        //Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;
        Properties pConfig = (Properties) this.getServletContext().getAttribute(handle + "_pConfig");
        // Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
        //use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();

        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);

        // get the tab details for use in later breadcrumbs
        PortalRequestContext prc = PortalUtil.getPortalRequestContext(pageContext);
        String tabUrl = prc.getRootRelativeUrl("index.jsp");

        // now declare all the standard text items to keep Tomcat 6 happy:
        final String bodyText = hOptions.getModuleBodyText();
        final String submitUrl = PlugInUtil.getUri(vendorId, handle, "module/testBrowser.jsp") + "?tabUrl=" + tabUrl;
        final String submitTitle = hOptions.getModuleButtonText();
    %>
    <div id="testBrowserModule" style="padding: 5px;">
        <%=bodyText%><br><br>
        <bbNG:button id="submitBrowserTest" label="<%=submitTitle%>" url="<%=submitUrl%>"/>
    </div>
</bbNG:includedPage>
