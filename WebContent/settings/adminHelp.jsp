<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%-- 
    Document   : adminHelp
    Created on : 06-Nov-2008, 00:23:54
    Author     : Dr Malcolm Murray
--%>
<%@ page import="blackboard.platform.intl.LocaleManagerFactory,
         blackboard.platform.intl.BbLocale,
         blackboard.platform.intl.BundleManagerFactory,
         blackboard.platform.intl.BbResourceBundle,
         java.util.ResourceBundle,
         java.util.Properties,
         ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper"
         errorPage="../error.jsp"
         %>
<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage entitlement="system.admin.VIEW" ctxId="ctx">
    <%
        // Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;
        BbResourceBundle bbHelpBundle = BundleManagerFactory.getInstance().getBundle("help");
        // use the BbLocale to select appropriate text to display to the user
        final String help = bbHelpBundle.getString("default.help.page.title"); // "Help"
        final String closeHelp = bbHelpBundle.getString("help.page.close.button.label"); // "Close Help"
        final String closeButton1Url = "javascript:window.close();";

        // Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
        final String pageInstructions = rBundle.getString("adminHelp.pageInstructions");
    %>
    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/help32.gif" showTitleBar="true" title="<%=help%>"/>
    </bbNG:pageHeader>
    <%
        // now display an actionBar with the Close Help button:
        String actionButton1Url = "javascript:window.close();";
    %>
    <bbNG:actionControlBar>
        <bbNG:actionButton title="<%=closeHelp%>" url="<%=actionButton1Url%>" primary="true"/>
    </bbNG:actionControlBar>

    <p><%=rBundle.getString("adminHelp.module.intro")%></p>


    <p><%=rBundle.getString("adminHelp.browserTest")%></p>

    <p><%=rBundle.getString("adminHelp.tests")%></p>

    <p><%=rBundle.getString("adminHelp.tests.optional")%></p>

    <p><%=rBundle.getString("adminHelp.popups")%></p>

    <p><%=rBundle.getString("adminHelp.actionBar")%></p>

    <p><%=rBundle.getString("adminHelp.otherTests")%></p>

    <p><%=rBundle.getString("adminHelp.footer")%></p>
    <hr>
    <%=rBundle.getString("adminHelp.detail")%>
    <br/>
    <br/>

    <bbNG:button id="close" label="<%=closeHelp%>" onClick="<%=closeButton1Url%>"/>

</bbNG:genericPage>
