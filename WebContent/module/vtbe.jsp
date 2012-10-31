<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import="blackboard.platform.intl.LocaleManagerFactory,
        blackboard.platform.intl.BbLocale,
        blackboard.platform.intl.BundleManagerFactory,
        blackboard.platform.intl.BbResourceBundle,
        blackboard.platform.plugin.PlugInUtil,
        java.util.ResourceBundle,
        ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
        durham.ng.browser.*"
        errorPage="../error.jsp"
        %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="VTBE Test Page">
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

        String suppliedText = request.getParameter("sampleTexttext");
        if (suppliedText == null) {
            suppliedText = "";
        }

        final String pageTitle = rBundle.getString("vtbe.title");
        String pageInstructions = rBundle.getString("vtbe.pageInstructions");

        // get variables needed for navigation
        String closeWindow = rBundle.getString("vtbe.close");
        String closeUrl = "javascript:window.close();";

        final String stepOneTitle = rBundle.getString("vtbe.stepOne.Title"); // Test the VTBE
        String stepOneInstructions = rBundle.getString("vtbe.stepOne.Instructions"); // Enter soome text here - between 5 and 500 characters
        final String dataElementLabel = rBundle.getString("vtbe.stepOne.dataElement.Label"); //Text

        if (suppliedText.length() > 0) {
            // change some of the messages
            pageInstructions = rBundle.getString("vtbe.suppliedText.Instructions"); // This is what you typed
            stepOneInstructions = rBundle.getString("vtbe.suppliedText"); // This is what you typed
        }
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-vtbe.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>


    <%
        if (suppliedText.length() > 0) {
            // show the user what they typed:
            out.print("<p><span class=\"browserSectionHeader\">");
            out.print(stepOneInstructions);
            out.print("</span><br>");
            out.print(suppliedText);
            out.print("</p>");
            out.print("<br><br>");
    %>
    <bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>
    <%
    } else {
    %>
    <bbNG:form action="" name="vtbeForm" id="vtbeForm" method="post" onsubmit="return validateForm();">
        <bbNG:dataCollection markUnsavedChanges="true" showSubmitButtons="true">
            <bbNG:step title="<%=stepOneTitle%>" instructions="<%=stepOneInstructions%>" >
                <bbNG:dataElement isRequired="true" label="<%=dataElementLabel%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="sampleText"
                        rows="10"
                        cols="80"
                        minLength="5"
                        maxLength="500"
                        text=""
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="false"
                        showArtifactVTBEFooter="true"
                        />
                </bbNG:dataElement>
            </bbNG:step>

            <bbNG:stepSubmit showCancelButton="true" cancelUrl="javascript:window.close();"/>
        </bbNG:dataCollection>

    </bbNG:form>
    <% }%>
</bbNG:genericPage>