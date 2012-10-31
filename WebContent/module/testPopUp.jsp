
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import ="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.intl.BundleManagerFactory,
        java.util.ResourceBundle,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        blackboard.platform.plugin.PlugInUtil,
        durham.ng.browser.HelpOptions"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser PopUp Test Page">
    <%
    //Set Blackboard b2 properties
        final String vendorId = BuildingBlockHelper.VENDOR_ID;
        final String handle = BuildingBlockHelper.HANDLE;
        final String toolName = BuildingBlockHelper.TOOL_NAME;

    // Get Servlet Context Attribute
        ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
    //use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();

        final String pageInstructions = rBundle.getString("testPopUp.pageInstructions");
        final String pageTitle = rBundle.getString("testPopUp.Title");

        final String closeButtonTitle = rBundle.getString("testPopUp.CloseButtonTitle");
        final String closeButton1Url = "javascript:window.close();";

        String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");
    %>
    <bbNG:cssFile href="<%=cssUrl%>"/>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-pop.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>


    <p><%=rBundle.getString("testPopUp.Text")%></p>
    <script type="text/javascript">
        document.write("");
    </script>
    <noscript>
        <div class="failedTest">
            <%=rBundle.getString("testPopUp.Required.javascriptFail")%>
        </div>
    </noscript>
    <br>


    <div align=right>
        <bbNG:button id="close" label="<%=closeButtonTitle%>" onClick="<%=closeButton1Url%>"/>
    </div>

</bbNG:genericPage>