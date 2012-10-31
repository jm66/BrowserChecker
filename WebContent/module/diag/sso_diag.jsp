<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import ="blackboard.platform.intl.LocaleManagerFactory,
                blackboard.platform.intl.BbLocale,
                blackboard.platform.intl.BbResourceBundle,
                blackboard.platform.intl.BundleManagerFactory,
                java.util.ResourceBundle,
                java.net.URLEncoder,
                blackboard.platform.plugin.PlugInUtil,
                blackboard.platform.authentication.*,
                blackboard.platform.authentication.AuthenticationManager,
                ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper"
        errorPage="../error.jsp"
%>
<%
//get variables needed to construct the breadCrumb trail and other navigation tasks
String tabUrl = request.getParameter("tabUrl");
//Set Blackboard b2 properties
final String vendorId = BuildingBlockHelper.VENDOR_ID;
final String handle = BuildingBlockHelper.HANDLE;
final String toolName = BuildingBlockHelper.TOOL_NAME;

//	Get Servlet Context Attribute
ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle+"_rBundle");
//	use the BbLocale to select appropriate text to display to the user
BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
final String pageInstructions = rBundle.getString("diagSSO.pageInstructions");
final String pageTitle = rBundle.getString("diagSSO.Title");

// Testing purposes
final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
%>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser PopUp Test Page" onLoad="Feedback.init();">
	<bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-sso.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

		<b>REMOTE_USER:</b> <%=request.getRemoteUser() %> <br/>
		<b>AuthType:</b> <%=request.getAuthType() %> <br/>
		<b>Shib-Application-ID:</b> <%=request.getAttribute("Shib-Application-ID") %> <br/>
		<b>Shib-Identity-Provider:</b> <%=request.getAttribute("Shib-Identity-Provider") %> <br/>
		<b>Shib-Session-ID:</b> <%=request.getAttribute("Shib-Session-ID") %> <br/>
		<b>Shib-Authentication-Instant:</b> <%=request.getAttribute("Shib-Authentication-Instant") %> <br/>
		<b>Shib-AuthnContext-Class:</b> <%=request.getAttribute("Shib-AuthnContext-Class") %> <br/>
		<b>Shib-Authentication-Method:</b> <%=request.getAttribute("Shib-Authentication-Method") %> <br/>
		<b>Shib-AuthnContext-Decl:</b> <%=request.getAttribute("Shib-AuthnContext-Decl") %> <br/>

</bbNG:genericPage>