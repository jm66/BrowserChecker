package durham.ng.browser;

import blackboard.data.registry.UserRegistryEntry;
import blackboard.data.user.User;
import blackboard.persist.KeyNotFoundException;
import blackboard.persist.PersistenceException;
import blackboard.persist.registry.UserRegistryEntryDbLoader;
import blackboard.platform.plugin.PlugInConfig;
import blackboard.platform.plugin.PlugInException;
import ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper;
import java.io.*;
import java.util.*;
import edu.northwestern.at.logging.*;

public class HelpOptions {

    private String helpEmail;
    private String helpUrl;
    private boolean helpDisplayedInNewWindow;
    private String helpText;
    private String wikiCountryCode;
    private boolean offCampusButtonDisplayed;
    private String offCampusUrl;
    private boolean offCampusDisplayedInNewWindow;
    private String offCampusText;
    private String proxyAdvice;
    private String virusAdvice;
    private String firewallAdvice;
    private boolean exceptionThrown;
    private StringBuffer errorLog;
    private Locale locale;
    private ResourceBundle rBundle;
    private String replaceText;
    private String languageText;
    private String moduleButtonText;
    private String moduleBodyText;
    private boolean bbWikiLinkDisplayed;
    private String bbWikiUrl;
    // Added by UT
    private String speedUpload;
    private String speedDownload;
    private String bwInstructions;
    private String javaInstructions;
    private String thirdPInstructions;
    
    final String vendorId = BuildingBlockHelper.VENDOR_ID;
    final String handle = BuildingBlockHelper.HANDLE;
    final String fileName = BuildingBlockHelper.SETTINGS_CUSTOM;

    public HelpOptions(Locale locale) {
        setHelpText("");
        setHelpEmail("");
        setHelpUrl("");
        setHelpDisplayedInNewWindow(true);
        setWikiCountryCode("en");
        setOffCampusButtonDisplayed(false);
        setOffCampusUrl("");
        setProxyAdvice("");
        setVirusAdvice("");
        setFirewallAdvice("");
        setOffCampusDisplayedInNewWindow(false);
        setOffCampusText("");
        setExceptionThrown(false);
        setErrorLog(new StringBuffer(""));
        setLocale(locale);
        setRBundle(ResourceBundle.getBundle(BuildingBlockHelper.SETTINGS_INTERNATIONAL, getLocale()));
        setLanguageText(rBundle.getString("helpOptions.languageText.default"));
        setReplaceText(rBundle.getString("helpOptions.replaceText"));
        setModuleBodyText(rBundle.getString("helpOptions.module.bodyText.default"));
        setModuleButtonText(rBundle.getString("helpOptions.module.buttonText.default"));
        setBbWikiLinkDisplayed(false);
        setBbWikiUrl("http://kb.blackboard.com/display/IDSR/Faculty+Support+Resource+Center");

        // UofT
        setSpeedUpload(rBundle.getString("testBand.RecomSpeedUpload"));
        setSpeedDownload(rBundle.getString("testBand.RecomSpeedDownload"));
        setBwInstructions(rBundle.getString("testBand.pageInstructions"));
        setJavaInstructions(rBundle.getString("testJava.pageInstructions"));
        setThirdPInstructions(rBundle.getString("testTParty.CommonFilesInstructions"));
    }

    public String getHelpEmail() {
        return trapNulls(helpEmail);
    }

    public String getHelpEmailAsLink() {
        if (trapNulls(getHelpEmail()).length() == 0) {
            return rBundle.getString("helpOptions.blankHelpEmail");
        } else {
            StringBuffer linkText = new StringBuffer("");
            linkText.append("<a href='mailto:");
            linkText.append(getHelpEmail());
            linkText.append("'>");
            linkText.append(getHelpEmail());
            linkText.append("</a>");
            return linkText.toString();
        }
    }

    public String getHelpUrl() {
        return trapNulls(helpUrl);
    }

    public String getHelpUrlAsLink() {
        if (trapNulls(getHelpUrl()).length() == 0) {
            return rBundle.getString("helpOptions.blankHelpUrl");
        }
        StringBuffer linkText = new StringBuffer("");
        linkText.append("<a href='");
        linkText.append(getHelpUrl());
        linkText.append("'");
        if (getOpenInANewWindow("newHelpWindow")) {
            linkText.append(" target='_blank'");
        }
        linkText.append(">");
        linkText.append(getHelpUrl());
        linkText.append("</a>");
        return linkText.toString();
    }

    public String getHelpText() {
        return helpText;
    }

    /**
     * Special method which informs Sys Admins that the tool needs configured if
     * it hasn't been already
     *
     * @param isSysAdmin true if they are
     * @return suitable text to display
     */
    public String getHelpTextWithWarning(boolean isSysAdmin) {
        if ((isSysAdmin) && (getHelpText().equalsIgnoreCase(getReplaceText()))) {
            // not yet set
            return getRBundle().getString("helpOptions.replaceText.sysadmin");
        }
        return getHelpText();
    }

    /**
     * Loads values from a properties object reference	
     */
    public void load(Properties props) {
        try {
        	if(props.size() < 1){
        		LogManager.log(this.getClass().getName(), new StringBuilder("Properties File deteceted but with no options.. Creating...").toString());
        		persist(this.getClass().getName());
        	}
        	
            // now get the values - checking a required field to see if it has been set
            if (trapNulls(props.getProperty("helpEmail")).length() > 0) {
                // load the values
                setModuleBodyText(props.getProperty("moduleBodyText"));
                setModuleButtonText(props.getProperty("moduleButtonText"));
                setHelpText(props.getProperty("helpText"));
                setHelpEmail(props.getProperty("helpEmail"));
                setHelpUrl(props.getProperty("helpUrl"));
                setHelpDisplayedInNewWindow(Boolean.parseBoolean(props.getProperty("helpDisplayedInNewWindow")));
                setWikiCountryCode(props.getProperty("wikiCountryCode"));
                setOffCampusButtonDisplayed(Boolean.parseBoolean(props.getProperty("offCampusButtonDisplayed")));
                setOffCampusDisplayedInNewWindow(Boolean.parseBoolean(props.getProperty("offCampusDisplayedInNewWindow")));
                setOffCampusText(props.getProperty("offCampusText"));
                setOffCampusUrl(props.getProperty("offCampusUrl"));
                setProxyAdvice(props.getProperty("proxyAdvice"));
                setVirusAdvice(props.getProperty("virusAdvice"));
                setFirewallAdvice(props.getProperty("firewallAdvice"));
                setLanguageText(props.getProperty("languageText"));
                setBbWikiLinkDisplayed(Boolean.parseBoolean(props.getProperty("bbWikiLinkDisplayed")));
                setBbWikiUrl(props.getProperty("bbWikiUrl"));

            }

        } catch (Exception e) {
            setExceptionThrown(true);
            errorLog.append(e.toString());
        }
    }

    /**
     * Attempts to save all user-specified settings
     *
     * @param username Username of sys admin - recorded in the properties file
     */
    public void persist(String username) {
        PlugInConfig piConfig = null;
        File theConfigFile = null;
        try {
            piConfig = new PlugInConfig(vendorId, handle);
            theConfigFile = new File(piConfig.getConfigDirectory(), fileName);
        } catch (PlugInException pppE) {
            setExceptionThrown(true);
            errorLog.append(getRBundle().getString("helpOptions.persist.plugInException"));
            return;
        }
        // don't check to see if the file exists as it won't the first time round!
        // all being well now try and save the properties to the file
        try {
            Properties props = new Properties();
            props.put("moduleBodyText", getModuleBodyText());
            props.put("moduleButtonText", getModuleButtonText());
            props.put("helpText", getHelpText());
            props.put("helpEmail", getHelpEmail());
            props.put("helpUrl", getHelpUrl());
            props.put("helpDisplayedInNewWindow", Boolean.toString(isHelpDisplayedInNewWindow()));
            props.put("wikiCountryCode", getWikiCountryCode());
            props.put("offCampusButtonDisplayed", Boolean.toString(isOffCampusButtonDisplayed()));
            props.put("offCampusDisplayedInNewWindow", Boolean.toString(isOffCampusDisplayedInNewWindow()));
            props.put("offCampusText", getOffCampusText());
            props.put("offCampusUrl", getOffCampusUrl());
            props.put("proxyAdvice", getProxyAdvice());
            props.put("virusAdvice", getVirusAdvice());
            props.put("firewallAdvice", getFirewallAdvice());
            props.put("languageText", getLanguageText());
            props.put("bbWikiLinkDisplayed", Boolean.toString(isBbWikiLinkDisplayed()));
            
            // UofT
            props.put("speedUpload", getSpeedUpload());
            props.put("speedDownload", getSpeedDownload());
            props.put("bwInstructions", getBwInstructions());
            props.put("javaInstructions", getBbWikiUrl());
            props.put("thirdPInstructions", getThirdPInstructions());
            
           // Configuration file
            FileOutputStream fos = new FileOutputStream(theConfigFile);
            String openingLine = "Browser Tester Tool Settings - last changed by " + username;
            props.store(fos, openingLine);
            fos.close();

        } catch (IOException ioe) {
            setExceptionThrown(true);
            errorLog.append(getRBundle().getString("helpOptions.persist.ioException"));
        }

    }

    public void persist(String username, File file) {
 
        // don't check to see if the file exists as it won't the first time round!
        // all being well now try and save the properties to the file
        try {
            Properties props = new Properties();
            props.put("moduleBodyText", getModuleBodyText());
            props.put("moduleButtonText", getModuleButtonText());
            props.put("helpText", getHelpText());
            props.put("helpEmail", getHelpEmail());
            props.put("helpUrl", getHelpUrl());
            props.put("helpDisplayedInNewWindow", Boolean.toString(isHelpDisplayedInNewWindow()));
            props.put("wikiCountryCode", getWikiCountryCode());
            props.put("offCampusButtonDisplayed", Boolean.toString(isOffCampusButtonDisplayed()));
            props.put("offCampusDisplayedInNewWindow", Boolean.toString(isOffCampusDisplayedInNewWindow()));
            props.put("offCampusText", getOffCampusText());
            props.put("offCampusUrl", getOffCampusUrl());
            props.put("proxyAdvice", getProxyAdvice());
            props.put("virusAdvice", getVirusAdvice());
            props.put("firewallAdvice", getFirewallAdvice());
            props.put("languageText", getLanguageText());
            props.put("bbWikiLinkDisplayed", Boolean.toString(isBbWikiLinkDisplayed()));
            
            // UofT
            props.put("speedUpload", getSpeedUpload());
            props.put("speedDownload", getSpeedDownload());
            props.put("bwInstructions", getBwInstructions());
            props.put("javaInstructions", getBbWikiUrl());
            props.put("thirdPInstructions", getThirdPInstructions());
            
           // Configuration file
            FileOutputStream fos = new FileOutputStream(file);
            String openingLine = "Browser Tester Tool Settings - Initialy created by " + username;
            props.store(fos, openingLine);
            fos.close();

        } catch (IOException ioe) {
            setExceptionThrown(true);
            errorLog.append(getRBundle().getString("helpOptions.persist.ioException"));
            errorLog.append(ioe.getMessage());
        }

    }
    private static String trapNulls(String candidate) {
        if (candidate == null) {
            return "";
        } else {
            return candidate.trim();
        }
    }

    public boolean isExceptionThrown() {
        return exceptionThrown;
    }

    public Locale getLocale() {
        return locale;
    }

    public ResourceBundle getRBundle() {
        return rBundle;
    }

    public void setExceptionThrown(boolean exceptionThrown) {
        this.exceptionThrown = exceptionThrown;
    }

    public void setErrorLog(StringBuffer errorLog) {
        this.errorLog = errorLog;
    }

    public void setLocale(Locale locale) {
        if (locale == null) {
            this.locale = Locale.UK;
        } else {
            this.locale = locale;
        }
    }

    public void setRBundle(ResourceBundle rBundle) {
        this.rBundle = rBundle;
    }

    public boolean useVisualTextEditor(User user) {
        boolean useEditor = true;
        UserRegistryEntry urEntry = null;
        try {
            UserRegistryEntryDbLoader ureLoader = blackboard.persist.registry.UserRegistryEntryDbLoader.Default.getInstance();
            urEntry = ureLoader.loadByKeyAndUserId("textbox.wysiwyg", user.getId());
            if (trapNulls(urEntry.getValue()).equalsIgnoreCase("N")) {
                useEditor = false;
            }
        } catch (KeyNotFoundException kE) {
            // just use it
            return true;
        } catch (PersistenceException pE) {
            // just use it
            return true;
        }
        return useEditor;
    }

    /**
     * Private method used to access a localised version of the text <p>Replace
     * this with your text</p>
     *
     * @return localised replace me text
     */
    private String getReplaceText() {
        return replaceText;
    }

    /**
     * Private setter
     *
     * @param replaceText localised version
     */
    private void setReplaceText(String replaceText) {
        this.replaceText = replaceText;
    }

    /**
     *
     * /**
     * Access a String set by the Sys Admin giving local information about the
     * use of proxies
     *
     * @return Proxy configuration advice
     */
    public String getProxyAdvice() {
        return proxyAdvice;
    }

    /**
     * Set a String giving local information about the use of proxies
     *
     * @param proxyAdvice Proxy configuration advice
     */
    public void setProxyAdvice(String proxyAdvice) {
        this.proxyAdvice = trapNulls(proxyAdvice);
    }

    /**
     * Access a String set by the Sys Admin giving local information about the
     * use of anti-virus software
     *
     * @return Anti-virus software configuration advice
     */
    public String getVirusAdvice() {
        return virusAdvice;
    }

    /**
     * Set a String giving local information about the use of anti-virus
     * software
     *
     * @param virusAdvice Anti-virus software configuration advice
     */
    public void setVirusAdvice(String virusAdvice) {
        this.virusAdvice = trapNulls(virusAdvice);
    }

    /**
     * Access a String set by the Sys Admin giving local information about the
     * use of firewalls
     *
     * @return Firewall configuration advice
     */
    public String getFirewallAdvice() {
        return firewallAdvice;
    }

    /**
     * Set a String giving local information about the use of firewalls
     *
     * @param firewallAdvice Firewall configuration advice
     */
    public void setFirewallAdvice(String firewallAdvice) {
        this.firewallAdvice = trapNulls(firewallAdvice);
    }

    public boolean isHelpDisplayedInNewWindow() {
        return helpDisplayedInNewWindow;
    }

    public void setHelpDisplayedInNewWindow(boolean helpDisplayedInNewWindow) {
        this.helpDisplayedInNewWindow = helpDisplayedInNewWindow;
    }

    public boolean isOffCampusButtonDisplayed() {
        return offCampusButtonDisplayed;
    }

    public void setOffCampusButtonDisplayed(boolean offCampusButtonDisplayed) {
        this.offCampusButtonDisplayed = offCampusButtonDisplayed;
    }

    public String getLanguageText() {
        return languageText;
    }

    public void setLanguageText(String languageText) {
        this.languageText = languageText;
    }

    public boolean getOffCampusDisplayedInNewWindow() {
        return isOffCampusDisplayedInNewWindow();
    }

    public void setOffCampusDisplayedInNewWindow(boolean offCampusDisplayedInNewWindow) {
        this.offCampusDisplayedInNewWindow = offCampusDisplayedInNewWindow;
    }

    public boolean isOffCampusDisplayedInNewWindow() {
        return offCampusDisplayedInNewWindow;
    }

    public String getModuleButtonText() {
        return moduleButtonText;
    }

    public void setModuleButtonText(String moduleButtonText) {
        if (trapNulls(moduleButtonText).length() > 0) {
            this.moduleButtonText = moduleButtonText;
        }
    }

    public String getModuleBodyText() {
        return moduleBodyText;
    }

    public void setModuleBodyText(String moduleBodyText) {
        if (trapNulls(moduleBodyText).length() > 0) {
            this.moduleBodyText = moduleBodyText;
        }
    }

    /**
     * Access a flag which determines whether or not to show a link to Bb's own
     * support wiki, displaying the various certified and compatible browsers
     * for different versions of Bb
     *
     * @return true if link is to be shown
     */
    public boolean isBbWikiLinkDisplayed() {
        return bbWikiLinkDisplayed;
    }

    /**
     * Set a flag which determines whether or not to show a link to Bb's own
     * support wiki, displaying the various certified and compatible browsers
     * for different versions of Bb
     *
     * @param bbWikiLinkDisplayed true if link is to be shown
     */
    public void setBbWikiLinkDisplayed(boolean bbWikiLinkDisplayed) {
        this.bbWikiLinkDisplayed = bbWikiLinkDisplayed;
    }

    /**
     * Access a String set by the Sys Admin giving a link to a page on Bb's wiki
     * giving supported browser configurations. At the time of writing this was:
     * http://kb.blackboard.com/display/IDSR/Faculty+Support+Resource+Ceneter
     *
     * @return URL to public Bb wiki page
     */
    public String getBbWikiUrl() {
        return bbWikiUrl;
    }

    /**
     * Creates an HTML paragraph which should be displayed on the page and
     * points to the Bb browser config wiki page
     *
     * @return HTML paragraph
     */
    public String getBbWikiUrlAsParagraph() {
        if (getBbWikiUrl().length() == 0) {
            return "&nbsp;";
        }
        StringBuffer sBuffer = new StringBuffer("");
        sBuffer.append("<p>");
        sBuffer.append(getRBundle().getString("helpOptions.bbWiki.paragraph"));
        sBuffer.append(" <a href=\"");
        sBuffer.append(getBbWikiUrl());
        sBuffer.append("\" target=\"_blank\">");
        sBuffer.append(getRBundle().getString("helpOptions.bbWiki.link"));
        sBuffer.append("</a></p>");
        return sBuffer.toString();
    }
    public String getOffCampusUrl() {
        return trapNulls(offCampusUrl);
    }

    public String getOffCampusUrlAsLink() {
        if (trapNulls(getOffCampusUrl()).length() == 0) {
            return rBundle.getString("helpOptions.blankOffCampusUrl");
        }
        StringBuffer linkText = new StringBuffer("");
        linkText.append("<a href='");
        linkText.append(getOffCampusUrl());
        linkText.append("'");
        if (getOpenInANewWindow("newOffCampusWindow")) {
            linkText.append(" target='_blank'");
        }
        linkText.append(">");
        linkText.append(getOffCampusUrl());
        linkText.append("</a>");
        return linkText.toString();
    }

    public String getOffCampusText() {
        return offCampusText;
    }

    public boolean getOpenInANewWindow(String windowType) {
        if ((windowType.equalsIgnoreCase("newHelpWindow")) && isHelpDisplayedInNewWindow()) {
            return true;
        }
        if ((windowType.equalsIgnoreCase("newOffCampusWindow")) && isOffCampusDisplayedInNewWindow()) {
            return true;
        }
        return false;
    }

    public String getWikiCountryCode() {
        if (trapNulls(wikiCountryCode).length() == 0) {
            return "en";
        } else {
            return wikiCountryCode;
        }
    }

    public String getWikiCountryCodeSelect() {
        StringBuffer sBuffer = new StringBuffer("");
        sBuffer.append("<select name='wikiCountryCode'>");
        for (int i = 0; i < 21; i++) {
            sBuffer.append(getSelectRow(i));
        }

        sBuffer.append("</select>");
        return sBuffer.toString();
    }

    private String getSelectRow(int loopCounter) {
        StringBuffer rowText = new StringBuffer("");
        rowText.append("<option value='");
        switch (loopCounter) {
            case 0:
                rowText.append("cs'");
                if (getWikiCountryCode().equalsIgnoreCase("cs")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Cesky");
                break;

            case 1:
                rowText.append("de'");
                if (getWikiCountryCode().equalsIgnoreCase("de")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Deutsch");
                break;

            case 2:
                rowText.append("en'");
                if (getWikiCountryCode().equalsIgnoreCase("en")) {
                    rowText.append(" selected ");
                }
                rowText.append(">English");
                break;

            case 3:
                rowText.append("es'");
                if (getWikiCountryCode().equalsIgnoreCase("es")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Espa\361ol");
                break;

            case 4:
                rowText.append("fr'");
                if (getWikiCountryCode().equalsIgnoreCase("fr")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Fran\347ais");
                break;

            case 5:
                rowText.append("ia'");
                if (getWikiCountryCode().equalsIgnoreCase("ia")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Interlingua");
                break;

            case 6:
                rowText.append("is'");
                if (getWikiCountryCode().equalsIgnoreCase("is")) {
                    rowText.append(" selected ");
                }
                rowText.append(">\315slenska");
                break;

            case 7:
                rowText.append("it'");
                if (getWikiCountryCode().equalsIgnoreCase("it")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Italiano");
                break;

            case 8:
                rowText.append("lv'");
                if (getWikiCountryCode().equalsIgnoreCase("lv")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Latvieau");
                break;

            case 9:
                rowText.append("lt'");
                if (getWikiCountryCode().equalsIgnoreCase("lt")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Lietuvis");
                break;

            case 10:
                rowText.append("hu'");
                if (getWikiCountryCode().equalsIgnoreCase("hu")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Magyar");
                break;

            case 11:
                rowText.append("nl'");
                if (getWikiCountryCode().equalsIgnoreCase("nl")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Nederlands");
                break;

            case 12:
                rowText.append("ja'");
                if (getWikiCountryCode().equalsIgnoreCase("ja")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Japanese");
                break;

            case 13:
                rowText.append("no'");
                if (getWikiCountryCode().equalsIgnoreCase("no")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Norsk (bokm\345l)");
                break;

            case 14:
                rowText.append("pl'");
                if (getWikiCountryCode().equalsIgnoreCase("pl")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Polski");
                break;

            case 15:
                rowText.append("pt'");
                if (getWikiCountryCode().equalsIgnoreCase("pt")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Portugu\352s");
                break;

            case 16:
                rowText.append("ru'");
                if (getWikiCountryCode().equalsIgnoreCase("ru")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Russian");
                break;

            case 17:
                rowText.append("sk'");
                if (getWikiCountryCode().equalsIgnoreCase("sk")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Slovencina");
                break;

            case 18:
                rowText.append("sl'");
                if (getWikiCountryCode().equalsIgnoreCase("sl")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Slovenscina");
                break;

            case 19:
                rowText.append("sv'");
                if (getWikiCountryCode().equalsIgnoreCase("sv")) {
                    rowText.append(" selected ");
                }
                rowText.append(">Svenska");
                break;

            case 20:
                rowText.append("tr'");
                if (getWikiCountryCode().equalsIgnoreCase("tr")) {
                    rowText.append(" selected ");
                }
                rowText.append(">T\374rk\347e");
                break;

            default:
                rowText.append("en'");
                if (getWikiCountryCode().equalsIgnoreCase("en")) {
                    rowText.append(" selected ");
                }
                rowText.append(">English");
                break;
        }
        rowText.append("</option>");
        return rowText.toString();
    }

    public boolean getExceptionThrown() {
        return isExceptionThrown();
    }

    public String getErrorLog() {
        return errorLog.toString();
    }

    public void setHelpEmail(String newValue) {
        helpEmail = trapNulls(newValue);
    }

    public void setHelpUrl(String newValue) {
        helpUrl = trapNulls(newValue);
    }

    public void setHelpText(String newValue) {
        helpText = trapNulls(newValue);
    }

    public void setOffCampusUrl(String newValue) {
        offCampusUrl = trapNulls(newValue);
    }

    public void setOffCampusText(String newValue) {
        offCampusText = trapNulls(newValue);
    }

    public void setWikiCountryCode(String newValue) {
        wikiCountryCode = trapNulls(newValue);
    }
    /**
     * Set the link to a page on Bb's wiki giving supported browser
     * configurations. At the time of writing this was:
     * http://kb.blackboard.com/display/IDSR/Faculty+Support+Resource+Ceneter
     *
     * @param bbWikiUrl URL to public Bb wiki page
     */
    public void setBbWikiUrl(String bbWikiUrl) {
        this.bbWikiUrl = trapNulls(bbWikiUrl);
    }

    public String getSpeedUpload() {
        return speedUpload;
    }

    public void setSpeedUpload(String speedUpload) {
        this.speedUpload = speedUpload;
    }

    public String getSpeedDownload() {
        return speedDownload;
    }

    public void setSpeedDownload(String speedDownload) {
        this.speedDownload = speedDownload;
    }

    public String getBwInstructions() {
        return bwInstructions;
    }

    public void setBwInstructions(String bwInstructions) {
        this.bwInstructions = bwInstructions;
    }

    public String getJavaInstructions() {
        return javaInstructions;
    }

    public void setJavaInstructions(String javaInstructions) {
        this.javaInstructions = javaInstructions;
    }

    public String getThirdPInstructions() {
        return thirdPInstructions;
    }

    public void setThirdPInstructions(String thirdPInstructions) {
        this.thirdPInstructions = thirdPInstructions;
    }
}