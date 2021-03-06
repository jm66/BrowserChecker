<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BundleManagerFactory,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        java.util.ArrayList,
        java.util.Iterator,
        java.util.Locale,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.*"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 
<%@ taglib uri="/bbUI" prefix="bbUI"%>

<bbNG:genericPage ctxId="ctx" title="Test Browser Languages Page">
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

        final String pageTitle = rBundle.getString("languages.languages");
        final String pageInstructions = rBundle.getString("languages.pageInstructions");

        String paragraphTitle = rBundle.getString("languages.available");
        String bodyText = rBundle.getString("languages.bodyText");
        String listTitleName = rBundle.getString("languages.miniList.Name");
        String listTitleCode = rBundle.getString("languages.miniList.Code");
        String ieHelp = rBundle.getString("languages.fix.title");

        // get variables needed for navigation
        final String tabUrl = request.getParameter("tabUrl");
        final String backUrl = "testBrowser.jsp?tabUrl=" + tabUrl;
        String ieHelpUrl = "ieLanguageHelp.jsp?tabUrl=" + tabUrl;

        String closeWindow = rBundle.getString("language.close");
        String closeUrl = "javascript:window.close();";
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-lang.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>
	
    <bbNG:actionControlBar>
        <bbNG:actionButton title="<%=ieHelp%>" url="<%=ieHelpUrl%>" primary="true"/>
    </bbNG:actionControlBar>
	<%
        ArrayList<BbLocale> aList = JspUtil.loadBbLocales();

        // add: rowHeaderId="name"
        // to the miniList declaration to make this work in 9.1
	%>
	<h2><%=paragraphTitle%></h2>
	<br/>
	<bbUI:instructionBar><%=bodyText%></bbUI:instructionBar>
	<br/>
	<bbNG:miniList
		className="blackboard.platform.intl.BbLocale" items="<%=aList%>"
		rowHeaderId="name" var="loc">
		<bbNG:miniListElement id="name" title="<%=listTitleName%>">
			<%=bbLocale.getName()%>
		</bbNG:miniListElement>
		<bbNG:miniListElement id="code" title="<%=listTitleCode%>">
			<%=bbLocale.getLocaleObject().getDisplayName()%>
		</bbNG:miniListElement>
	</bbNG:miniList>
	<br/><br/>
    <bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>
</bbNG:genericPage>