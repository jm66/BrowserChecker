<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%@page import ="blackboard.platform.intl.LocaleManagerFactory,
                blackboard.platform.intl.BbLocale,
                blackboard.platform.intl.BbResourceBundle,
                blackboard.platform.intl.BundleManagerFactory,
                java.util.ResourceBundle,
                blackboard.platform.plugin.PlugInUtil,
                ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper"
        errorPage="../error.jsp"
%>

<%@ taglib uri="/bbNG" prefix="bbNG"%> 

<bbNG:genericPage ctxId="ctx" title="Test Browser Connection Speed Test Page" onLoad="Feedback.init();">
<%
	//Set Blackboard b2 properties
	final String vendorId = BuildingBlockHelper.VENDOR_ID;
	final String handle = BuildingBlockHelper.HANDLE;
	final String toolName = BuildingBlockHelper.TOOL_NAME;
	
	// Get Servlet Context Attribute
	ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle+"_rBundle");
	//use the BbLocale to select appropriate text to display to the user
	BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
	final String jsFileSpeedLib = PlugInUtil.getUri(vendorId, handle, rBundle.getString("testBand.script"));
	String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");
	
	final String pageInstructions = rBundle.getString("testBand.pageInstructions");
	final String pageTitle = rBundle.getString("testBand.Title");
	final String closeButtonTitle = rBundle.getString("testBand.CloseButtonTitle");
	final String closeButton1Url = "javascript:window.close();";
	final String recomUpload = rBundle.getString("testBand.RecomSpeedUpload");
	final String recomDownload= rBundle.getString("testBand.RecomSpeedDownload");
	
	// Networking data
	String user_ipAddr = request.getRemoteHost().toString();
	String user_forwarded = request.getHeader("x-forwarded-for") ;
	// Testing purposes
	final String jsFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.jsFeedback"));
	final String cssFeedback = PlugInUtil.getUri(vendorId, handle, rBundle.getString("diagSSO.cssFeedback"));
        
    %>
    <!-- Feedback widget -->
    <bbNG:jsFile href="<%=jsFeedback%>"/>
	<bbNG:cssFile href="<%=cssFeedback%>"/>
    <!-- Feedback widget -->

<bbNG:pageHeader instructions="<%=pageInstructions%>">
    <bbNG:pageTitleBar iconUrl="../../images/bt-band.png" showTitleBar="true" title="<%=pageTitle%>"/>
     <script src="<%=jsFileSpeedLib%>"></script>
     	<script type="text/javascript">
			            var start = 0;
			            var end = 0;
			            var binfile = '';
			
			            function TestDownload() {
			                start = new Date().getTime();
			                $.ajax({
			                    type: "GET",
			                    url: "bigfile.bin?id=" + start,
			                    dataType: 'application/octet-stream',
			                    success: function(msg) {
			                        binfile = msg;
			                        end = new Date().getTime();
			                        diff = (end - start) / 1000;
			                        bytes = msg.length;
			                        speed = (bytes / diff) / 1024 * 8;
			                        speed = Math.round(speed*100)/100;
			                    	$('#dlspeed').html('<b>' + speed + ' Kb/s (You)</b>');
			                    },
			                    complete: function(xhr, textStatus) {
			                        TestUpload();
			                    }
			                });
			            }
			            function TestUpload() {
			                start = new Date().getTime();
			                $.ajax({
			                    type: "POST",
			                    url: "post.aspx?id=" + start,
			                    data: binfile,
			                    dataType: 'application/octet-stream',
			                    success: function(msg) {
			                        end = new Date().getTime();
			                        diff = (end - start) / 1000;
			                        bytes = binfile.length;
			                        speed = (bytes / diff) / 1024 * 8;
			                        speed = Math.round(speed*100)/100;
			                    	$('#ulspeed').html('<b>' + speed + ' Kb/s (You)</b>');
			                    }
			                });
			            }
			            $(document).ready(function() {
			                TestDownload();
			            });   
			            
			            </script>
</bbNG:pageHeader>

  <bbNG:dataCollection markUnsavedChanges="false" showSubmitButtons="false">
  		<bbNG:step title="Download Speed">
  		 <bbUI:instructions>Recommended <%=recomDownload %> </bbUI:instructions>
                 	<bbNG:dataElement label="Real (Kbp/s)" isRequired="false">	
	                 	 <p>
	                 	 	<span id="dlspeed"><img src="../../images/bt-load.gif"/></span>
                    	 	<span id="dlspeedInput"></span>
                    	 </p>
                    </bbNG:dataElement>
        </bbNG:step>
        <bbNG:step title="Upload Speed">
  		 <bbUI:instructions>Recommended <%=recomUpload %> </bbUI:instructions>
                 	<bbNG:dataElement label="Real (Kbp/s)" isRequired="false">	
                 		<p>
							<span id="ulspeed"><img src="../../images/bt-load.gif"/></span>
                    		<span id="ulspeedInput"></span>
                    	</p>
                    </bbNG:dataElement>
        </bbNG:step>
        <bbNG:step title="Additional network information">
        <bbUI:instructions>  </bbUI:instructions>
			<bbNG:dataElement label="IP Address" isRequired="true">
				<bbNG:textElement name="user_ipAddr" value="<%=user_ipAddr%>" size="16" displayOnly="true" isRequired="true"/>
			</bbNG:dataElement>
            <bbNG:dataElement label="Forwarded by" isRequired="true">
                 <bbNG:textElement name="user_forwarded" value="<%=user_forwarded%>" size="50" displayOnly="true" isRequired="true"/>
            </bbNG:dataElement>
        </bbNG:step>
  </bbNG:dataCollection>


<bbNG:button id="close" label="<%=closeButtonTitle%>" onClick="<%=closeButton1Url%>"/>


</bbNG:genericPage>