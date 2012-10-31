<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        blackboard.data.user.User,
        blackboard.data.user.User.SystemRole,
        java.util.Properties,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.HelpOptions"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser PopUp Test Page" onLoad="Feedback.init();">
   
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

        final String breadcrumbName = rBundle.getString("root_Breadcrumb");
        final String pageTitle = rBundle.getString("testBrowser.moreInfo");
        final String pageInstructions = rBundle.getString("moreInfo.pageInstructions");

        // get variables needed to construct the breadCrumb trail
        final String tabUrl = request.getParameter("tabUrl");

        final String backUrl = "testBrowser.jsp?tabUrl=" + tabUrl;

        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);

        User user = ctx.getUser();
        boolean isSysAdmin = false;
        if (user.getSystemRole() == SystemRole.SYSTEM_ADMIN) {
            isSysAdmin = true;
        }
        
        // set up some Strings to populate the entries:
        final String jsTitle = rBundle.getString("moreInfo.JavaScript");
        final String jsUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/JavaScript";
        final String jsBody = rBundle.getString("moreInfo.JavaScript.text");
        final String cookiesTitle = rBundle.getString("moreInfo.Cookies");
        final String cookiesUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/HTTP_cookie";
        final String cookiesBody = rBundle.getString("moreInfo.Cookies.text");
        final String javaTitle = rBundle.getString("moreInfo.Java");
        final String javaUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/Java_programming_language";
        final String javaBody = rBundle.getString("moreInfo.Java.text") + System.getProperty("java.version") + rBundle.getString("moreInfo.Java.text2") + " " + hOptions.getHelpEmailAsLink() + rBundle.getString("moreInfo.Java.text3");
        
        // set up some Strings to populate the entries:
        final String flashTitle = rBundle.getString("moreInfo.Flash");
        final String flashUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/Macromedia_Flash_Player";
        final String flashBody = rBundle.getString("moreInfo.Flash.text");
        final String shockTitle = rBundle.getString("moreInfo.Shock");
        final String shockUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/Macromedia_Shockwave";
        final String shockBody = rBundle.getString("moreInfo.Shock.text");
        final String wmpTitle = rBundle.getString("moreInfo.WMP");
        final String wmpUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/Windows_Media_Player";
        final String wmpBody = rBundle.getString("moreInfo.WMP.text");
        final String realTitle = rBundle.getString("moreInfo.Real");
        final String realUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/RealPlayer";
        final String realBody = rBundle.getString("moreInfo.Real.text");
        final String qtTitle = rBundle.getString("moreInfo.QT");
        final String qtUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/QuickTime";
        final String qtBody = rBundle.getString("moreInfo.QT.text");
        final String svgTitle = rBundle.getString("moreInfo.SVG");
        final String svgUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/SVG";
        final String svgBody = rBundle.getString("moreInfo.SVG.text");
        final String acrobatTitle = rBundle.getString("moreInfo.Acrobat");
        final String acrobatUrl = "http://" + hOptions.getWikiCountryCode() + ".wikipedia.org/wiki/Acrobat_Reader";
        final String acrobatBody = rBundle.getString("moreInfo.Acrobat.text");
        
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
        <bbNG:pageTitleBar iconUrl="../images/info.png" showTitleBar="true" title="<%=pageTitle%>" />
    </bbNG:pageHeader>
	
	<bbNG:dataCollection markUnsavedChanges="false" showSubmitButtons="false" >
		<bbNG:step title="<%=rBundle.getString(\"moreInfo.Local.Help\")%>" hideNumber="true" >
	                 	<bbNG:dataElement label="" isRequired="false">	
	                 		<p><%=hOptions.getHelpTextWithWarning(isSysAdmin)%></p>	
							<p>
								<%=rBundle.getString("moreInfo.Local.Help.Website")%>&nbsp;<%=hOptions.getHelpUrlAsLink()%>
	        					<%=rBundle.getString("moreInfo.Local.Help.Contact")%> <%=hOptions.getHelpEmailAsLink()%>
	        				</p>
	                    </bbNG:dataElement>
	
	    </bbNG:step>
		<bbNG:step title="Reminder" hideNumber="true" >
	                 	<bbNG:dataElement label="" isRequired="false">	
							<p>
							<%=rBundle.getString("moreInfo.Remainder")%>
							<%=rBundle.getString("moreInfo.Wikipedia")%>&nbsp;<a href='http://<%=hOptions.getWikiCountryCode()%>.wikipedia.org' target='_blank'>Wikipedia</a>.
							</p>
	                    </bbNG:dataElement>
	    </bbNG:step>
		<bbNG:step title="<%=rBundle.getString(\"testBrowser.Required\")%>" hideNumber="true" instructions="<%=rBundle.getString(\"testBrowser.Required.text\")%>">
			<bbNG:contentList>
        		<bbNG:contentListItem iconUrl="../images/bt-javascript.png" id="javascript" title="<%=jsTitle%>" url="<%=jsUrl%>"><%=jsBody%></bbNG:contentListItem>
        		<bbNG:contentListItem iconUrl="../images/bt-cookies.png" id="cookies" title="<%=cookiesTitle%>" url="<%=cookiesUrl%>"><%=cookiesBody%></bbNG:contentListItem>
        		<bbNG:contentListItem iconUrl="../images/bt-java.png" id="java" title="<%=javaTitle%>" url="<%=javaUrl%>"><%=javaBody%></bbNG:contentListItem>
    		</bbNG:contentList>
		</bbNG:step>
		<bbNG:step title="<%=rBundle.getString(\"testBrowser.Optional\")%>" hideNumber="true" instructions="<%=rBundle.getString(\"testBrowser.Optional.text\")%>">
   		 	<bbNG:contentList>
				<bbNG:contentListItem iconUrl="../images/logo_flash.png" id="flash" title="<%=flashTitle%>" url="<%=flashUrl%>"><%=flashBody%></bbNG:contentListItem>
		        <bbNG:contentListItem iconUrl="../images/logo_shock.png" id="shockwave" title="<%=shockTitle%>" url="<%=shockUrl%>"><%=shockBody%></bbNG:contentListItem>
		        <bbNG:contentListItem iconUrl="../images/logo_wm.png" id="windows_media_player" title="<%=wmpTitle%>" url="<%=wmpUrl%>"><%=wmpBody%></bbNG:contentListItem>
		        <bbNG:contentListItem iconUrl="../images/logo_real.png" id="real_player" title="<%=realTitle%>"url="<%=realUrl%>"><%=realBody%></bbNG:contentListItem>
		        <bbNG:contentListItem iconUrl="../images/logo_qt.png" id="quicktime" title="<%=qtTitle%>" url="<%=qtUrl%>"><%=qtBody%></bbNG:contentListItem>
		        <bbNG:contentListItem iconUrl="../images/logo_svg.png" id="svg" title="<%=svgTitle%>" url="<%=svgUrl%>"><%=svgBody%></bbNG:contentListItem>
		        <bbNG:contentListItem iconUrl="../images/logo_pdf.png" id="acrobat" title="<%=acrobatTitle%>" url="<%=acrobatUrl%>"><%=acrobatBody%></bbNG:contentListItem>
			</bbNG:contentList>		
	    </bbNG:step>
		<bbNG:step title="<%=rBundle.getString(\"testPopUp.Title\")%>" hideNumber="true" instructions="<%=rBundle.getString(\"moreInfo.PopUp.text\")%>">
			<bbNG:dataElement label="" isRequired="false">
					<p><%=rBundle.getString("moreInfo.PassAlert.Text")%></p>
				<br/>
   			  	<p><%=rBundle.getString("moreInfo.PassPopUp.Text")%></p>
   			  	
					<img src="../images/bt-popupscreen.png" style="display:block; margin-left: auto;margin-right: auto;"/>
			    
			</bbNG:dataElement>
		</bbNG:step>
	</bbNG:dataCollection>
		
<bbNG:okButton url="<%=backUrl%>"/>

</bbNG:genericPage>