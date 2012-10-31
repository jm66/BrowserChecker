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

<bbNG:genericPage ctxId="ctx" title="Test Browser Media Page">
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

        final String pageTitle = rBundle.getString("testBrowser.Audio.Video");
        final String pageInstructions = rBundle.getString("media.pageInstructions");

        String paragraphTitle = rBundle.getString("media.intro");
        String bodyText = rBundle.getString("media.bodyText");


        // get variables needed for navigation
        final String tabUrl = request.getParameter("tabUrl");
        final String backUrl = "testBrowser.jsp?tabUrl=" + tabUrl;

        String closeWindow = rBundle.getString("language.close");
        String closeUrl = "javascript:window.close();";

        String embeddedAudioTests = rBundle.getString("media.embeddedAudioTests"); // Embedded Audio
        String embeddedVideoTests = rBundle.getString("media.embeddedVideoTests"); // Embedded Video
        String linkedVideoTests = rBundle.getString("media.linkedVideoTests"); // Linked Video

        String qtText = rBundle.getString("media.qt");
        request.setAttribute("qtText", qtText);
        String wmaText = rBundle.getString("media.wma");
        request.setAttribute("wmaText", wmaText);
        String aviText = rBundle.getString("media.avi");
        request.setAttribute("aviText", aviText);
        String youTubeText = rBundle.getString("media.youTube");
        request.setAttribute("youTubeText", youTubeText);
        /*
         * String realText = rBundle.getString("media.rl");
         * request.setAttribute("realText", realText);
         */
        String mp3Text = rBundle.getString("media.mp3");
        request.setAttribute("mp3Text", mp3Text);
        String divXText = rBundle.getString("media.divX");
        request.setAttribute("divXText", divXText);
        String mp4Text = rBundle.getString("media.mp4");
        request.setAttribute("mp4Text", mp4Text);
        String flashText = rBundle.getString("media.flash");
        request.setAttribute("flashText", flashText);
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:pageTitleBar iconUrl="../images/bt-media.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <bbNG:actionControlBar>

        <bbNG:actionMenu title="<%=embeddedAudioTests%>" primary="true">
            <bbNG:actionMenuItem title="${ mp3Text }" href="embeddedAudio.jsp?rF=mp3"/>
            <bbNG:actionMenuItem title="${ wmaText }" href="embeddedAudio.jsp?rF=wma"/>
        </bbNG:actionMenu>

        <bbNG:actionMenu title="<%=embeddedVideoTests%>" primary="true">
            <bbNG:actionMenuItem title="${ aviText }" href="embeddedVideo.jsp?rF=avi"/>
            <bbNG:actionMenuItem title="${ qtText }" href="embeddedVideo.jsp?rF=qt"/>
            <bbNG:actionMenuItem title="${ youTubeText }" href="embeddedVideo.jsp?rF=you"/>
        </bbNG:actionMenu>

        <bbNG:actionMenu title="<%=linkedVideoTests%>" primary="true">
            <bbNG:actionMenuItem title="${ divXText }" href="linkedVideo.jsp?rF=divX"/>
            <bbNG:actionMenuItem title="${ mp4Text }" href="linkedVideo.jsp?rF=mp4"/>
            <bbNG:actionMenuItem title="${ flashText }" href="linkedVideo.jsp?rF=flash"/>
        </bbNG:actionMenu>

    </bbNG:actionControlBar>

   <h2><%=paragraphTitle%></h2>
   <br>
   <div class="vtbegenerated">
        <p><%=bodyText%></p>
    	<p><%=rBundle.getString("media.vlc")%></p>
	</div>
 	<br>
   
    <bbNG:button label="<%=closeWindow%>" url="<%=closeUrl%>"/>

</bbNG:genericPage>