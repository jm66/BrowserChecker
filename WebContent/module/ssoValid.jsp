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

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ taglib uri="/bbNG" prefix="bbNG"%> 

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
final String pageInstructions = rBundle.getString("testSSO.pageInstructions");
final String pageTitle = rBundle.getString("testSSO.Title");
final String remoteHeaderInstructions = rBundle.getString("testSSO.remoteHeaderInstructions");
final String helpURL = rBundle.getString("testSSO.helpURL");
final String naRemoteUserText = rBundle.getString("testSSO.naRemoteUser");
final String okRemoteUserText = rBundle.getString("testSSO.okRemoteUser");
final String naBbUser = rBundle.getString("testSSO.naBbUser");
final String okBbUser = rBundle.getString("testSSO.okBbUser");
final String authProvId = rBundle.getString("testSSO.authProvId");
final String loginText = rBundle.getString("testSSO.loginText");
final String stepTwoInstr = rBundle.getString("testSSO.stepTwoInstructions");
final String backWindow = rBundle.getString("testSSO.BackWindowTitle");

// Testing purposes
final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
%>


<bbNG:genericPage ctxId="ctx" title="Test Browser SSO Test Page" onLoad="Feedback.init();">
	<bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
<%
// Generating Shibb Login URL
final String breadcrumbName = rBundle.getString("root_Breadcrumb");
final String ssoURL = PlugInUtil.getUri(vendorId, handle, "module/ssoValid.jsp");
final String testBURL = PlugInUtil.getUri(vendorId, handle, "module/testBrowser.jsp");
final String frameSetURL= "/webapps/portal/frameset.jsp?tab_tab_group_id=_1_1";
final StringBuilder loginURL = new StringBuilder();
	loginURL.append(PlugInUtil.getUri("bb", "auth-provider-shibboleth","execute/shibbolethLogin"));
	loginURL.append("?authProviderId=").append(authProvId);
	loginURL.append("&redirectUrl=").append(URLEncoder.encode(frameSetURL + "&url=" + ssoURL,"UTF-8"));

final String backUrl = testBURL;

// User has a SSO session? Looking for REMOTE_USER header.
String remoteUser = request.getRemoteUser();
String authType = null;
String shibbAppID = null;
String shibbSessID = null;
String shibbIDP = null;

boolean hasRemoteUser = (remoteUser == null) ? false : true;
StringBuffer okRemote = new StringBuffer ();
String remoteUserText = hasRemoteUser ? okRemote.append(okRemoteUserText).append("<b>").append(remoteUser).append("</b>").toString() : naRemoteUserText;

if (hasRemoteUser){
	authType = request.getAuthType();
	shibbAppID = request.getAttribute("Shib-Application-ID").toString() ;
	shibbSessID = request.getAttribute("Shib-Session-ID").toString();
	shibbIDP = request.getAttribute("Shib-Identity-Provider").toString();
}

// User authenticated in Blackboard?
boolean isAuthenticatedBbUser = (ctx.getSession().isAuthenticated() && ctx.getUser().getUserName().toLowerCase().equals("guest")) ? false : true;
String authenticatedUserText = isAuthenticatedBbUser ? okBbUser : naBbUser ;

%>

<bbNG:pageHeader instructions="<%=pageInstructions%>">
       <bbNG:breadcrumbBar environment="PORTAL" >
            <bbNG:breadcrumb href="<%=backUrl%>"> <%=breadcrumbName%></bbNG:breadcrumb>
            <bbNG:breadcrumb> <%=pageTitle%></bbNG:breadcrumb>
        </bbNG:breadcrumbBar>
	 <bbNG:pageTitleBar iconUrl="../images/bt-sso.png" showTitleBar="true" title="<%=pageTitle%>"/>
</bbNG:pageHeader>
  <bbNG:form action="loginBb.jsp"  id="sdmform"  name="sdmform" method="post">
	 <bbNG:dataCollection markUnsavedChanges="false" showSubmitButtons="false">
	        <bbNG:step title="Single Sign-On data" instructions="<%=remoteHeaderInstructions %>" hideNumber="true">
				<bbNG:dataElement label="UTORweblogin" isRequired="true">
					<bbNG:textElement name="remoteUser" value="<%=remoteUserText%>" size="16" displayOnly="true" isRequired="true"/>
				</bbNG:dataElement>
				<bbNG:dataElement label="Portal Session" isRequired="true">
					<bbNG:textElement name="remoteUserAuthTxt" value="<%=authenticatedUserText%>" size="16" displayOnly="true" isRequired="true"/>
					<% if (!isAuthenticatedBbUser) { %>
						<bbNG:button label="<%=loginText%>" url="<%=loginURL.toString() %>"/>
					<%} %>
				</bbNG:dataElement>
	        </bbNG:step>
	    <% if (hasRemoteUser) { %>
		   	<bbNG:step title="Portal Service Provider data" instructions="<%=stepTwoInstr %>" hideNumber="true" >
				<bbNG:dataElement label="Authentication Type" isRequired="true">
					<bbNG:textElement name="authType" value="<%=authType %>" size="16" displayOnly="true" isRequired="true"/>
				</bbNG:dataElement>
				<bbNG:dataElement label="Session ID" isRequired="true">
					<bbNG:textElement name="shibbSessID" value="<%=shibbSessID%>" size="16" displayOnly="true" isRequired="true"/>
				</bbNG:dataElement>
			</bbNG:step>
		<%} %>
	  </bbNG:dataCollection>
  </bbNG:form>
        <bbNG:button label="<%=backWindow%>" url="<%=backUrl%>" />
</bbNG:genericPage>