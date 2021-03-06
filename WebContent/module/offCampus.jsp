<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        java.util.Properties,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.HelpOptions"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser Off Campus Page">
    <%
//Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;

// Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
        Properties pConfig = (Properties) this.getServletContext().getAttribute(handle + "_pConfig");
//use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
        String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");
    %>
    <bbNG:cssFile href="<%=cssUrl%>"/>

    <%

        final String breadcrumbName = rBundle.getString("root_Breadcrumb");
        final String pageTitle = rBundle.getString("testBrowser.offCampus");
        final String pageInstructions = rBundle.getString("offCampus.pageInstructions");

        // get variables needed to construct the breadCrumb trail
        final String tabUrl = request.getParameter("tabUrl");

        final String backUrl = "testBrowser.jsp?tabUrl=" + tabUrl;

        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);

    %>
    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:breadcrumbBar environment="PORTAL" >
            <bbNG:breadcrumb href="<%=backUrl%>"> <%=breadcrumbName%></bbNG:breadcrumb>
            <bbNG:breadcrumb> <%=pageTitle%></bbNG:breadcrumb>
        </bbNG:breadcrumbBar>
        <bbNG:pageTitleBar iconUrl="../images/bt-off.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <p><span class="browserSectionHeader"><%=rBundle.getString("offCampus.LocalInfo")%></span><br>
        <%=hOptions.getOffCampusText()%></p>
    <p><%=rBundle.getString("offCampus.MoreInfo")%>&nbsp;<%=hOptions.getOffCampusUrlAsLink()%><br>
        <%=rBundle.getString("offCampus.or.contact")%>&nbsp;<%=hOptions.getHelpEmailAsLink()%></p>
    <hr>    
    <br>  
    <p><span class="browserSectionHeader"><%=rBundle.getString("offCampus.from.home")%></span><br>
        <i><%=rBundle.getString("offCampus.from.home.text")%></i></p>

    <%
        // set up some Strings to populate the entries:
        final String proxyTitle = rBundle.getString("offCampus.Proxy");
        final String proxyUrl = "http://" + hOptions.getWikiCountryCode() + "wikipedia.org/wiki/Proxy_Server";
        String proxyBody = rBundle.getString("offCampus.Proxy.text");
        if (hOptions.getProxyAdvice().length() > 0) {
            proxyBody += "<br><br>" + hOptions.getProxyAdvice();
        }

        final String virusTitle = rBundle.getString("offCampus.Virus");
        final String virusUrl = "http://" + hOptions.getWikiCountryCode() + "wikipedia.org/wiki/Anti-virus_software";
        String virusBody = rBundle.getString("offCampus.Virus.text");
        if (hOptions.getVirusAdvice().length() > 0) {
            virusBody += "<br><br>" + hOptions.getVirusAdvice();
        }

        final String firewallTitle = rBundle.getString("offCampus.FireWall");
        final String firewallUrl = "http://" + hOptions.getWikiCountryCode() + "wikipedia.org/wiki/Firewall_%28networking%29";
        String firewallBody = rBundle.getString("offCampus.Firewall.text");
        if (hOptions.getFirewallAdvice().length() > 0) {
            firewallBody += "<br><br>" + hOptions.getFirewallAdvice();
        }
    %>
    <bbNG:contentList>
        <bbNG:contentListItem iconUrl="../images/server.png" id="proxy" title="<%=proxyTitle%>" titleColor="#660066" url="<%=proxyUrl%>"><%=proxyBody%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/virus.png" id="virus" title="<%=virusTitle%>" titleColor="#660066" url="<%=virusUrl%>"><%=virusBody%></bbNG:contentListItem>
        <bbNG:contentListItem iconUrl="../images/logo_firewall.gif" id="firewall" title="<%=firewallTitle%>" titleColor="#660066" url="<%=firewallUrl%>"><%=firewallBody%></bbNG:contentListItem>
    </bbNG:contentList>




    <bbNG:okButton url="<%=backUrl%>"/>

</bbNG:genericPage>