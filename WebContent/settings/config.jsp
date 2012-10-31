
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@ page import="blackboard.platform.intl.LocaleManagerFactory,
         blackboard.platform.intl.BbLocale,
         blackboard.platform.intl.BundleManagerFactory,
         blackboard.platform.intl.BbResourceBundle,
         blackboard.persist.navigation.NavigationItemDbLoader,
         blackboard.data.navigation.NavigationItem,
         blackboard.platform.plugin.PlugInUtil,
         blackboard.data.user.User,
         java.util.ResourceBundle,
         java.util.Properties,
         ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
         durham.ng.browser.*"

         errorPage="../error.jsp"
         %>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage entitlement="system.admin.VIEW" ctxId="ctx">

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
        // get two standard Bb language pack entries
        BbResourceBundle bbCommonBundle = BundleManagerFactory.getInstance().getBundle("common");
        BbResourceBundle bbHelpBundle = BundleManagerFactory.getInstance().getBundle("help");
        final String localMoreHelp = bbHelpBundle.getString("extended.help.url.title"); // "More Help"

        final String ShowMoreHelpError = rBundle.getString("config.js.ShowMoreHelpError");

    %>

    <script type="text/javascript">

        /* -------------------------------------------------------------------------
      Some javascript functions used to mimic in-built NG features

      Dr Malcolm Murray, October 2008
      -------------------------------------------------------------------------
         */
        function ShowMoreHelp(helpPage){
            // display this url in a popup window 
            var popUpAllowed = window.open(helpPage, 'Help', 'height=800,width=800,toolbar=0,location=0,status=0,scrollbars=1,menubar=0,resizable=1');
            if(popUpAllowed == null){
                // failed to create the window
                alert("<%=ShowMoreHelpError%>");
            }
        }
    </script>

    <%
        final String pageTitle = rBundle.getString("root_Breadcrumb");
        final String instructions = rBundle.getString("config.pageInstructions");
        String pageInstructions = JspUtil.createPageHeaderInstructions(instructions, localMoreHelp, "adminHelp.jsp") + "</p>";

        // generate a final cancelUrl using the code suggested by Eric:
        NavigationItemDbLoader niLoader = NavigationItemDbLoader.Default.getInstance();
        NavigationItem navItem = niLoader.loadByInternalHandle("admin_plugin_manage");
        String cancelUrl = navItem.getHref();
        String formAction = "../ConfigServlet";
    %>

    <bbNG:pageHeader instructions="<%=pageInstructions%>">
        <bbNG:breadcrumbBar environment="SYS_ADMIN_PANEL" navItem="admin_plugin_manage">
            <bbNG:breadcrumb><%=pageTitle%></bbNG:breadcrumb>
        </bbNG:breadcrumbBar>
        <bbNG:pageTitleBar iconUrl="../images/config.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <%
        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);
        if (hOptions.getExceptionThrown()) {
            out.println("<p>Went Belly up :-(</p>");

        }

        // now declare the localised text to display below:

        final String moduleStepTitle = rBundle.getString("config.moduleStep.title");
        final String moduleStepInstructions = rBundle.getString("config.moduleStep.instructions");
        final String moduleButtonLabel = rBundle.getString("config.moduleStep.button.label");
        final String moduleButtonHelp = rBundle.getString("config.moduleStep.button.help");
        final String moduleBodyLabel = rBundle.getString("config.moduleStep.body.label");
        final String moduleBodyHelp = rBundle.getString("config.moduleStep.body.help");

        final String localInfo = rBundle.getString("config.step1.LocalInfo");
        final String stepOneInstructions = rBundle.getString("config.step1.instructions");
        final String stepOneEmail = rBundle.getString("config.step1.email");
        final String stepOneHelpText = rBundle.getString("config.step1.HelpText");
        final String stepOneUrl = rBundle.getString("config.step1.Url");
        final String stepOneUrlText = rBundle.getString("config.step1.Url.text");
        final String stepOneWindow = rBundle.getString("config.step1.window");

        final String wikipedia = rBundle.getString("config.step2.Wikipedia");
        final String stepTwoInstructions = rBundle.getString("config.step2.instructions");
        final String stepTwoLanguage = rBundle.getString("config.step2.language");

        final String offCampus = rBundle.getString("config.step3.offcampus");
        final String stepThreeInstructions = rBundle.getString("config.step3.instructions");
        final String stepThreeDisplay = rBundle.getString("config.step3.display");
        final String stepThreeShowTitle = rBundle.getString("config.step3.show.title");
        final String stepThreeHideTitle = rBundle.getString("config.step3.hide.title");
        final String stepThreeHelpText = rBundle.getString("config.step3.HelpText");
        final String stepThreeUrl = rBundle.getString("config.step3.Url");
        final String stepThreeUrlText = rBundle.getString("config.step3.Url.text");
        final String stepThreeProxyAdvice = rBundle.getString("config.step3.ProxyAdvice");
        final String stepThreeVirusAdvice = rBundle.getString("config.step3.VirusAdvice");
        final String stepThreeFirewallAdvice = rBundle.getString("config.step3.FirewallAdvice");


        final String stepFourTitle = rBundle.getString("config.step4.languages");
        final String stepFourInstructions = rBundle.getString("config.step4.instructions");
        final String stepFourLabel = rBundle.getString("config.step4.label");


        final String stepFiveTitle = rBundle.getString("config.step5.bbwiki"); // Links to Blackboard Pages
        final String stepFiveInstructions = rBundle.getString("config.step5.instructions"); // Determine whether or not to include a link to confluence site
        final String stepFiveDisplay = rBundle.getString("config.step5.display"); // Display Link to Bb Wiki
        final String stepFiveShowTitle = rBundle.getString("config.step5.show.title"); //
        final String stepFiveHideTitle = rBundle.getString("config.step5.hide.title"); //
        final String stepFiveUrl = rBundle.getString("config.step5.url.label"); // Url
        final String stepFiveUrlText = rBundle.getString("config.step5.url.help"); // Enter the full URL, e.g.

        final String stepSixTitle = rBundle.getString("config.step6.bandwidth");
        final String stepSixInstructions = rBundle.getString("config.step6.instructions");
        //final String stepSixLabel = rBundle.getString("config.step6.label");
        final String stepSixUploadLabel = rBundle.getString("config.step6.upload.label");
        final String stepSixDownloadLabel = rBundle.getString("config.step6.download.label");
        final String stepSixUploadText = rBundle.getString("config.step6.upload.text");
        final String stepSixDownloadText = rBundle.getString("config.step6.download.text");
        final String stepSixUpload = rBundle.getString("config.step6.upload");
        final String stepSixDownload = rBundle.getString("config.step6.download");
        final String stepSixBwTextLabel = rBundle.getString("config.step6.text.label");

        final String stepSevenTitle = rBundle.getString("config.step7.java");
        final String stepSevenInstructions = rBundle.getString("config.step7.instructions");
        final String stepSevenJavaTextLabel = rBundle.getString("config.step7.text.label");

        final String stepEightTitle = rBundle.getString("config.step8.third");
        final String stepEightInstructions = rBundle.getString("config.step8.instructions");
        final String stepEightTextLabel = rBundle.getString("config.step7.text.label");

        final String yes = bbCommonBundle.getString("action.yes");
        final String no = bbCommonBundle.getString("action.no");
    %>
    <bbNG:form action="<%=formAction%>" id="configForm" name="configForm" method="post" onsubmit="return validateForm();">
        <bbNG:dataCollection markUnsavedChanges="true" showSubmitButtons="true">
            <bbNG:step title="<%=moduleStepTitle%>" instructions="<%=moduleStepInstructions%>">

                <bbNG:dataElement label="<%=moduleButtonLabel%>" isRequired="true">
                    <bbNG:textElement name="moduleButtonText" id="moduleButtonText" size="30" value="<%=hOptions.getModuleButtonText()%>"  title="<%=moduleButtonLabel%>" isRequired="true" minLength="5" maxLength="100" helpText="<%=moduleButtonHelp%>"/>
                </bbNG:dataElement>

                <bbNG:dataElement label="<%=moduleBodyLabel%>" isRequired="true">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="moduleBodyText"
                        rows="10"
                        cols="80"
                        minLength="20"
                        maxLength="1000"
                    text="<%=hOptions.getModuleBodyText()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                    helpText="<%=moduleBodyHelp%>"
                        />

                </bbNG:dataElement>

            </bbNG:step>

            <bbNG:step title="<%=localInfo%>" instructions="<%=stepOneInstructions%>">

                <bbNG:dataElement label="<%=stepOneHelpText%>" isRequired="true">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="helpText"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="10000"
                    text="<%=hOptions.getHelpText()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />

                </bbNG:dataElement>

                <bbNG:dataElement label="<%=stepOneUrl%>" isRequired="true">
                    <bbNG:textElement name="helpUrl" id="helpUrl" size="60" value="<%=hOptions.getHelpUrl()%>" title="<%=stepOneUrl%>" isRequired="true" minLength="5" helpText="<%=stepOneUrlText%>"/>
                    <bbNG:checkboxElement id="helpDisplayedInNewWindow" name="helpDisplayedInNewWindow" value="true" optionLabel="<%=stepOneWindow%>" title="<%=stepOneWindow%>" isSelected="<%=hOptions.isHelpDisplayedInNewWindow()%>"/>
                </bbNG:dataElement>

                <bbNG:dataElement label="<%=stepOneEmail%>" isRequired="true">
                    <bbNG:textElement name="helpEmail" id="helpEmail" size="50" value="<%=hOptions.getHelpEmail()%>" title="<%=stepOneEmail%>" isRequired="true" minLength="5"/>
                </bbNG:dataElement>


            </bbNG:step>


            <bbNG:step title="<%=wikipedia%>" instructions="<%=stepTwoInstructions%>">

                <bbNG:dataElement label="<%=stepTwoLanguage%>">
                    <%=hOptions.getWikiCountryCodeSelect()%>
                </bbNG:dataElement>

            </bbNG:step>

            <bbNG:step title="<%=offCampus%>" instructions="<%=stepThreeInstructions%>">

                <bbNG:dataElement label="<%=stepThreeUrl%>" isRequired="false">
                    <bbNG:textElement name="offCampusUrl" id="offCampusUrl" size="50" value="<%=hOptions.getOffCampusUrl()%>" title="<%=stepThreeUrl%>" isRequired="false" minLength="0" helpText="<%=stepThreeUrlText%>"/>
                    <bbNG:checkboxElement id="offCampusDisplayedInNewWindow" name="offCampusDisplayedInNewWindow" value="true" optionLabel="<%=stepOneWindow%>" title="<%=stepOneWindow%>" isSelected="<%=hOptions.isOffCampusDisplayedInNewWindow()%>"/>
                </bbNG:dataElement>
                <bbNG:dataElement label="<%=stepThreeDisplay%>" isRequired="true">
                    <bbNG:radioElement id="offCampusButtonDisplayed" name="offCampusButtonDisplayed" title="<%=stepThreeShowTitle%>" value="true" isSelected="<%=hOptions.isOffCampusButtonDisplayed()%>" optionLabel="<%=yes%>"/>
                    <bbNG:radioElement id="offCampusButtonDisplayed" name="offCampusButtonDisplayed" title="<%=stepThreeHideTitle%>" value="false" isSelected="<%=!hOptions.isOffCampusButtonDisplayed()%>" optionLabel="<%=no%>"/>
                </bbNG:dataElement>



                <bbNG:dataElement label="<%=stepThreeHelpText%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="offCampusText"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getOffCampusText()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />
                </bbNG:dataElement>

                <bbNG:dataElement label="<%=stepThreeProxyAdvice%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="proxyAdvice"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getProxyAdvice()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />

                </bbNG:dataElement>

                <bbNG:dataElement label="<%=stepThreeVirusAdvice%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="virusAdvice"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getVirusAdvice()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />

                </bbNG:dataElement>

                <bbNG:dataElement label="<%=stepThreeFirewallAdvice%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="firewallAdvice"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getFirewallAdvice()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />

                </bbNG:dataElement>

            </bbNG:step>

            <bbNG:step title="<%=stepFourTitle%>" instructions="<%=stepFourInstructions%>">


                <bbNG:dataElement label="<%=stepFourLabel%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="languageText"
                        rows="10"
                        cols="80"
                        minLength="10"
                        maxLength="2000"
                    text="<%=hOptions.getLanguageText()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />

                </bbNG:dataElement>

            </bbNG:step>

            <bbNG:step title="<%=stepFiveTitle%>" instructions="<%=stepFiveInstructions%>">

                <bbNG:dataElement label="<%=stepFiveDisplay%>" isRequired="true">
                    <bbNG:radioElement id="bbWikiLinkDisplayed" name="bbWikiLinkDisplayed" title="<%=stepFiveShowTitle%>" value="true" isSelected="<%=hOptions.isBbWikiLinkDisplayed()%>" optionLabel="<%=yes%>"/>
                    <bbNG:radioElement id="bbWikiLinkDisplayed" name="bbWikiLinkDisplayed" title="<%=stepFiveHideTitle%>" value="false" isSelected="<%=!hOptions.isBbWikiLinkDisplayed()%>" optionLabel="<%=no%>"/>
                </bbNG:dataElement>

                <bbNG:dataElement label="<%=stepFiveUrl%>" isRequired="false">
                    <bbNG:textElement name="bbWikiUrl" id="bbWikiUrl" size="70" value="<%=hOptions.getBbWikiUrl()%>" title="<%=stepFiveUrl%>" isRequired="false" minLength="0" helpText="<%=stepFiveUrlText%>"/>
                </bbNG:dataElement>

            </bbNG:step>
            <bbNG:step title="<%=stepSixTitle%>" instructions="<%=stepSixInstructions%>">
                <bbNG:dataElement label="<%=stepSixUpload%>" isRequired="false">
                    <bbNG:textElement name="uploadSpeed" id="uploadSpeed" size="70" value="<%=hOptions.getSpeedUpload()%>" title="<%=stepSixUploadLabel%>" isRequired="false" minLength="0" helpText="<%=stepSixUploadText%>"/>
                </bbNG:dataElement>
                <bbNG:dataElement label="<%=stepSixDownload%>" isRequired="false">
                    <bbNG:textElement name="downloadSpeed" id="downloadSpeed" size="70" value="<%=hOptions.getSpeedDownload()%>" title="<%=stepSixDownloadLabel%>" isRequired="false" minLength="0" helpText="<%=stepSixDownloadText%>"/>
                </bbNG:dataElement>
                <bbNG:dataElement label="<%=stepSixBwTextLabel%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="bwInstructions"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getBwInstructions()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />
                </bbNG:dataElement>
            </bbNG:step>
            <bbNG:step title="<%=stepSevenTitle%>" instructions="<%=stepSevenInstructions%>">
                <bbNG:dataElement label="<%=stepSevenJavaTextLabel%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="javaInstructions"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getJavaInstructions()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />
                </bbNG:dataElement>
            </bbNG:step>
            <bbNG:step title="<%=stepEightTitle%>" instructions="<%=stepEightInstructions%>">
                <bbNG:dataElement label="<%=stepEightTextLabel%>">
                    <bbNG:textbox
                        isMathML="false"
                        isFormattedText="false"
                        isSpellcheck="true"
                        name="thirdPInstructions"
                        rows="10"
                        cols="80"
                        minLength="0"
                        maxLength="2000"
                    text="<%=hOptions.getThirdPInstructions()%>"
                        format="html"
                        isRow2Collapsed="false"
                        isRow3Collapsed="true"
                        />
                </bbNG:dataElement>
            </bbNG:step>
            <bbNG:stepSubmit showCancelButton="true" cancelUrl="<%=cancelUrl%>"/>
        </bbNG:dataCollection>
    </bbNG:form>

</bbNG:genericPage>
