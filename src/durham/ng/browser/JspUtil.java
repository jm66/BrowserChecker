package durham.ng.browser;

import blackboard.platform.intl.BbLocale;
import blackboard.platform.intl.BbLocaleDbLoader;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Utility class to help acheive
 * some common effects on JSPs
 * @author Dr Malcolm Murray, Durham University
 */
public class JspUtil {

   /** 
     * Create a new instance of JspUtil
     */
     public JspUtil() {
    }

     /**
      * Convenience method for ensuring no errors
      * arise from getting nulls when you expected a String
      * @param string the String to test (can be null)
      * @return a String of zero or more characters in length
      */
     private static String trapNulls(String string) {
        if (string == null) {
            return "";
        } else {
            return string.trim();
        }
    }
     
     /**
      * Convenience method to add a More Help link
      * onto some instructions.
      * Required because this function has not been exposed to developers.
      * @param instructions Text to display
      * @param localMoreHelp localised version of the String More Help
      * @param helpPageUrl name of the JSP containing the help data (including the course_id) e.g. help.jsp?course_id=_123_1
      * @return a String which can be entered into the instructions field of a &lt;bbNG:PageHeader&gt; object
      */
    public static String createPageHeaderInstructions(String instructions, String localMoreHelp, String helpPageUrl){
        StringBuffer sBuffer = new StringBuffer("");
        sBuffer.append(instructions);
        if(trapNulls(helpPageUrl).length() > 0){
            // build up the More Help link
            // after this check
            if(trapNulls(localMoreHelp).length() == 0){
                // no local version supplied
                localMoreHelp = "More Help";
            }
            sBuffer.append(" <a href=\"javascript:ShowMoreHelp('");
            sBuffer.append(helpPageUrl);
            sBuffer.append("');\">");
            sBuffer.append(localMoreHelp);
            sBuffer.append("</a>");
        }
        return sBuffer.toString();
    }
    
    public static ArrayList loadBbLocales(){
        ArrayList localeList = new ArrayList();
        try {
            BbLocaleDbLoader localeLoader = BbLocaleDbLoader.Default.getInstance();
            localeList.addAll(localeLoader.loadAll());
        } catch (blackboard.persist.PersistenceException pE){
            return localeList;
        }
        //Now filter the list to only show those that are currently enabled...
        BbLocaleFilter blFilter = new BbLocaleFilter();
        ArrayList filteredList = new ArrayList();
        Iterator itr = localeList.listIterator();
        while(itr.hasNext()){
            BbLocale locale = (BbLocale) itr.next();
            if(blFilter.passesFilter(locale)){
                filteredList.add(locale);
            }
        }
        return filteredList;
    }
    
    
}
