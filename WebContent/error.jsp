<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<%--
    Document   : tool/error.jsp
    Created on : 14-Oct-2008, 10:31:46
    Author     : Dr Malcolm Murray
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="blackboard.platform.intl.LocaleManagerFactory,
         blackboard.platform.intl.BbLocale,
         blackboard.platform.plugin.PlugInUtil,
         java.util.ResourceBundle,
         ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper,
         java.io.PrintWriter"%>
<%@ taglib uri="/bbNG" prefix="bbNG" %>
<%@ page isErrorPage="true" %>
<%
    String strException = exception.getMessage();

//Set Blackboard b2 properties
    final String vendorId = BuildingBlockHelper.VENDOR_ID;
    final String handle = BuildingBlockHelper.HANDLE;
    final String toolName = BuildingBlockHelper.TOOL_NAME;

// Get Servlet Context Attribute
    ResourceBundle rBundle = (ResourceBundle) this.getServletContext().getAttribute(handle + "_rBundle");
//use the BbLocale to select appropriate text to display to the user
    BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
    String pageTitle = rBundle.getString("error.title");

    String cssUrl = PlugInUtil.getUri(vendorId, handle, "styles/browserCheck.css");
%>
<bbNG:genericPage title="Unexpected Error">
    <bbNG:cssFile href="<%=cssUrl%>"/>

    <bbNG:pageHeader>
        <bbNG:breadcrumbBar/>
        <bbNG:pageTitleBar iconUrl="../images/error.png" showTitleBar="true" title="<%=pageTitle%>"/>
    </bbNG:pageHeader>

    <div class="adminWarning"><%=strException%></div>
    <p><%=rBundle.getString("error.paragraph1")%></p>

    <p><%=rBundle.getString("error.paragraph2")%></p>
    <pre>
        <%
            // now display a stack trace of the exception
            PrintWriter pw = new PrintWriter(out);
            exception.printStackTrace(pw);
        %>
    </pre>

</bbNG:genericPage>
