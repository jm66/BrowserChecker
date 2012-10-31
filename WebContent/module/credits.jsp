<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="blackboard.platform.intl.LocaleManagerFactory,
         blackboard.platform.intl.BbLocale,
         blackboard.platform.plugin.PlugInUtil,
         java.util.ResourceBundle,
         ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper"
         errorPage="../error.jsp"
         %>

<%@ taglib uri="/bbNG" prefix="bbNG"%>

<bbNG:genericPage ctxId="ctx" title="Test Browser More Info Page" onLoad="Feedback.init();">
    <%
    //Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;

    // Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
    //use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();

        String tabUrl = request.getParameter("tabUrl");
        String backUrl = "testBrowser.jsp?tabUrl=" + tabUrl;

        final String breadcrumbName = rBundle.getString("root_Breadcrumb");
        final String pageTitle = rBundle.getString("testBrowser.credits");
        final String pageInstructions = rBundle.getString("credits.pageInstructions");
        
     	// Testing purposes
     	final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
     	final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
        
    %>
    <!-- Feedback widget -->
    <bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
    <!-- Feedback widget -->

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:breadcrumbBar environment="PORTAL" >
            <bbNG:breadcrumb href="<%=backUrl%>"> <%=breadcrumbName%></bbNG:breadcrumb>
            <bbNG:breadcrumb> <%=pageTitle%></bbNG:breadcrumb>
        </bbNG:breadcrumbBar>
        <bbNG:pageTitleBar iconUrl="../images/credits.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <bbNG:contentList>
        <bbNG:contentListItem iconUrl="../images/durham.png" id="durham" title="Durham University" url="http://www.dur.ac.uk/its"><%=rBundle.getString("credits.durham")%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/seneca.png" id="seneca" title="Seneca College" url="http://www.senecac.on.ca/elc/"><%=rBundle.getString("credits.seneca")%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/utoronto.png" id="toronto" title="University of Toronto" url="http://www.its.utoronto.ca/"><%=rBundle.getString("credits.utoronto")%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/wikipedia.png" id="wikipedia" title="Wikipedia" url="http://en.wikipedia.org/"><%=rBundle.getString("credits.wikipedia")%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/photos.png" id="photos" title="Photos"><%=rBundle.getString("credits.photos")%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/oscelot.png" id="oscelot" title="Oscelot" url="http://www.oscelot.org"><%=rBundle.getString("credits.oscelot")%></bbNG:contentListItem>
    </bbNG:contentList>

    <bbNG:okButton url="<%=backUrl%>"/>

</bbNG:genericPage>
