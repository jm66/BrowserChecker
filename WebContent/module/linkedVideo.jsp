<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BundleManagerFactory,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        java.util.Locale,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.*"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser Linked Video Sample Page">
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
        String fileRequested = request.getParameter("rF");

        // get variables needed for navigation
        final String pageTitle = rBundle.getString("linkedVideo.pageTitle");
        final String pageInstructions = rBundle.getString("linkedVideo.pageInstructions");

        String paragraphTitleKey = "linkedVideo." + fileRequested + ".paragraphTitle";
        String paragraphTitle = rBundle.getString(paragraphTitleKey);

        String bodyTextKey = "linkedVideo." + fileRequested + ".bodyText";
        String bodyText = rBundle.getString(bodyTextKey);

        String contentIconKey = "linkedVideo." + fileRequested + ".iconUrl";
        String contentIcon = rBundle.getString(contentIconKey); // e.g. ../samples/mov.png

        String contentUrlKey = "linkedVideo." + fileRequested + ".contentUrl";
        String contentUrl = rBundle.getString(contentUrlKey); // e.g. ../samples/sample.mov

        String contentBodyKey = "linkedVideo." + fileRequested + ".contentBody";
        String contentBody = rBundle.getString(contentBodyKey);

        String linkTitle = rBundle.getString("linkedVideo.downloadFile");

        // get variables needed for navigation
        String backWindow = rBundle.getString("language.back");
        String backUrl = "javascript:history.go(-1);";
        String closeWindow = rBundle.getString("language.close");
        String closeUrl = "javascript:window.close();";
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-video.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>
	<div class="vtbegenerated">
		<h2><%=paragraphTitle%></h2>
		<br>
		<p><%=bodyText%></p>
	</div>
	<br>
    <bbNG:contentList>
        <bbNG:contentListItem iconUrl="<%=contentIcon%>" id="contentSample" title="<%=linkTitle%>" titleColor="#660066" url="<%=contentUrl%>"><%=contentBody%></bbNG:contentListItem>
    </bbNG:contentList>

    <br>

    <bbNG:button label="<%=backWindow%>" url="<%=backUrl%>"/>&nbsp;<bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>

</bbNG:genericPage>