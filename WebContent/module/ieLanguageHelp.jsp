<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BundleManagerFactory,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        java.util.Properties,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.*"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 
<%@ taglib uri="/bbUI" prefix="bbUI"%>

<bbNG:genericPage ctxId="ctx" title="Test Browser IE Language Help Page">
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

        String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");
    %>
    <bbNG:cssFile href="<%=cssUrl%>"/>

    <%
    // use the BbLocale to select appropriate text to display to the user
        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);

        final String pageTitle = rBundle.getString("languages.fix.title");
        final String pageInstructions = rBundle.getString("languages.fix.pageInstructions");

        String bodyText = hOptions.getLanguageText(); // rBundle.getString("languages.fix.text");

    // get variables needed for navigation
        String backWindow = rBundle.getString("language.back");
        String backUrl = "javascript:history.go(-1);";

        String closeWindow = rBundle.getString("language.close");
        String closeUrl = "javascript:window.close();";
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-ie.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>
	<div class="vtbegenerated">
    	<p><%=bodyText%></p>
    	<br>
	</div>
    <bbNG:button label="<%=backWindow%>" url="<%=backUrl%>"/>&nbsp;<bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>

</bbNG:genericPage>