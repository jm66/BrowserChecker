package durham.ng.browser;

import blackboard.data.navigation.NavigationItem;
import blackboard.data.user.User;
import blackboard.persist.navigation.NavigationItemDbLoader;
import blackboard.platform.context.Context;
import blackboard.platform.context.ContextManager;
import blackboard.platform.context.ContextManagerFactory;
import blackboard.platform.intl.BbLocale;
import blackboard.platform.intl.LocaleManagerFactory;
import blackboard.platform.servlet.InlineReceiptUtil;
import ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.ResourceBundle;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet to handle changes submitted by a Sys Admin
 *
 * @author Dr Malcolm Murray, Durham University
 */
public class ConfigServlet extends HttpServlet {

    final String vendorId = BuildingBlockHelper.VENDOR_ID;
    final String handle = BuildingBlockHelper.HANDLE;

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException
     * @throws IOException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        StringBuffer returnUrl = new StringBuffer("");
        // generate a final cancelUrl using the code suggested by Eric:
        try {
            NavigationItemDbLoader niLoader = NavigationItemDbLoader.Default.getInstance();
            NavigationItem navItem = niLoader.loadByInternalHandle("admin_plugin_manage");
            // set this in a safer manner
            returnUrl.append(navItem.getHref());
        } catch (blackboard.persist.KeyNotFoundException kE) {
            // no match for this tag
            returnUrl.append("/webapps/blackboard/admin/manage_plugins.jsp");
        } catch (blackboard.persist.PersistenceException pE) {
            // no match for this tag
            returnUrl.append("/webapps/blackboard/admin/manage_plugins.jsp");
        }

        // get the user from the context
        ContextManager cManager = ContextManagerFactory.getInstance();
        Context ctx = cManager.getContext();
        User user = ctx.getUser();

        // use the BbLocale to select appropriate text to display to the user
        BbLocale bbLocale = LocaleManagerFactory.getInstance().getLocale();
        ResourceBundle rBundle = ResourceBundle.getBundle(BuildingBlockHelper.SETTINGS_INTERNATIONAL, bbLocale.getLocaleObject());

        // get properties object from Servlet Context
        Properties pConfig = new Properties();
        pConfig.load(new FileInputStream(BuildingBlockHelper.getConfigFileFullPath(this.getServletContext())));

        HelpOptions hOptions = new HelpOptions(bbLocale.getLocaleObject());
        hOptions.load(pConfig);

        if (hOptions.getExceptionThrown()) {
            // halt and warn the user
            returnUrl.append("?");
            returnUrl.append(InlineReceiptUtil.SIMPLE_ERROR_KEY);
            returnUrl.append("=");
            returnUrl.append(encodeMessage(hOptions.getErrorLog()));
            response.sendRedirect(returnUrl.toString());
            return;

        }
        // otherwise get the details from the form
        hOptions.setModuleButtonText(trapNulls(request.getParameter("moduleButtonText")));
        hOptions.setModuleBodyText(trapNulls(request.getParameter("moduleBodyTexttext"))); // bbNG:textBox
        hOptions.setHelpText(trapNulls(request.getParameter("helpTexttext"))); // bbNG:textBox
        hOptions.setHelpEmail(trapNulls(request.getParameter("helpEmail")));
        hOptions.setHelpUrl(trapNulls(request.getParameter("helpUrl")));
        hOptions.setHelpDisplayedInNewWindow(Boolean.parseBoolean(request.getParameter("helpDisplayedInNewWindow"))); // checkbox
        hOptions.setWikiCountryCode(trapNulls(request.getParameter("wikiCountryCode")));
        hOptions.setOffCampusButtonDisplayed(Boolean.parseBoolean(request.getParameter("offCampusButtonDisplayed"))); //radio button
        hOptions.setOffCampusDisplayedInNewWindow(Boolean.parseBoolean(request.getParameter("offCampusDisplayedInNewWindow"))); // checkbox
        hOptions.setOffCampusText(trapNulls(request.getParameter("offCampusTexttext"))); // bbNG:textBox
        hOptions.setOffCampusUrl(trapNulls(request.getParameter("offCampusUrl")));
        hOptions.setProxyAdvice(trapNulls(request.getParameter("proxyAdvicetext"))); // bbNG:textBox
        hOptions.setVirusAdvice(trapNulls(request.getParameter("virusAdvicetext"))); // bbNG:textBox
        hOptions.setFirewallAdvice(trapNulls(request.getParameter("firewallAdvicetext"))); // bbNG:textBox
        hOptions.setLanguageText(trapNulls(request.getParameter("languageTexttext"))); // bbNG:textBox
        hOptions.setBbWikiLinkDisplayed(Boolean.parseBoolean(request.getParameter("bbWikiLinkDisplayed"))); // radio button
        hOptions.setBbWikiUrl(trapNulls(request.getParameter("bbWikiUrl")));

        // Added by UT
        hOptions.setBwInstructions(trapNulls(request.getParameter("bwInstructionstext")));
        hOptions.setSpeedDownload(trapNulls(request.getParameter("downloadSpeed")));
        hOptions.setSpeedUpload(trapNulls(request.getParameter("uploadSpeed")));
        hOptions.setJavaInstructions(trapNulls(request.getParameter("javaInstructionstext")));
        hOptions.setThirdPInstructions(trapNulls(request.getParameter("thirdPInstructionstext")));

        hOptions.persist(user.getUserName());
        if (hOptions.isExceptionThrown()) {
            // halt and warn the user
            returnUrl.append("?");
            returnUrl.append(InlineReceiptUtil.SIMPLE_ERROR_KEY);
            returnUrl.append("=");
            returnUrl.append(encodeMessage(hOptions.getErrorLog()));
            response.sendRedirect(returnUrl.toString());
            return;
        } else {
            returnUrl.append("?");
            returnUrl.append(InlineReceiptUtil.SIMPLE_STRING_KEY);
            returnUrl.append("=");
            returnUrl.append(encodeMessage(rBundle.getString("configServlet.persist.success")));
            response.sendRedirect(returnUrl.toString());
            return;
        }

    }

    private static String trapNulls(String candidate) {
        if (candidate == null) {
            return "";
        } else {
            return candidate.trim();
        }
    }

    private static String encodeMessage(String plainTextMessage) {
        String encodedMessage = "";
        try {
            encodedMessage = java.net.URLEncoder.encode(plainTextMessage, "UTF-8");
        } catch (java.io.UnsupportedEncodingException uEE) {
            return "The+encoding+threw+a+wobbler";
        }

        return encodedMessage;
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
