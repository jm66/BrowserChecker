
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import ="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.intl.BundleManagerFactory,
        java.util.ResourceBundle,
        java.util.Iterator,
        java.util.ArrayList,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        blackboard.platform.plugin.PlugInUtil,
        durham.ng.browser.*"
        errorPage="../error.jsp"
        %>
<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser Third Party Components Test Page" onLoad="Feedback.init();">
    <%
        //Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;

        // Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
        //use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();

        final String pageInstructions = rBundle.getString("testTParty.CommonFilesInstructions");
        final String pageTitle = rBundle.getString("testTParty.CommonFiles");

        String closeWindow = rBundle.getString("language.close");
        String closeUrl = "javascript:window.close();";

       	// Testing purposes
     	final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
     	final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
        
    %>
    <!-- Feedback widget -->
    <bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
    <!-- Feedback widget -->
 

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-tp.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <%
        // now get a set of sample files to show
        SampleResourceLoader srLoader = new SampleResourceLoader();
        // create an empty Collection:
        ArrayList sampleList = null;
        srLoader.loadAll();
        if (srLoader.isExceptionCaught()) {
            out.println(srLoader.getErrorMessage());
        } else {
            // populate the Collection
            sampleList = srLoader.getSampleList();
        }
    %>

    <bbNG:contentList>
        <%
            // now iterate through the list and get the samples:
            Iterator itr = sampleList.iterator();
            while (itr.hasNext()) {
                SampleResource sResource = (SampleResource) itr.next();
                String iconUrlValue = sResource.getResourceIconUrl();
                String idValue = sResource.getFileExtension();
                String titleValue = sResource.getFileExtension();
                String urlValue = sResource.getResourceFileUrl();
                String bodyValue = sResource.getResourceName();
        %>
        <bbNG:contentListItem iconUrl="<%=iconUrlValue%>" id="<%=idValue%>" title="<%=titleValue%>" url="<%=urlValue%>"><%=bodyValue%></bbNG:contentListItem>
        <%
            }
        %>
    </bbNG:contentList>

	<br/><br/>
    <bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>

</bbNG:genericPage>