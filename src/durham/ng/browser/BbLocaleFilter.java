/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package durham.ng.browser;

import blackboard.base.ListFilter;
import blackboard.platform.intl.BbLocale;

/**
 *
 * @author Dr Malcolm Murray, Durham University
 */
public class BbLocaleFilter extends ListFilter {

    
    /** 
     * Create a new instance of BbLocaleFilter
     * which filters the list to only show available locales
     */
     public BbLocaleFilter() {
         
     }
     
      protected boolean passesFilter(Object listElement) {
        
        if (listElement instanceof blackboard.platform.intl.BbLocale) {
            blackboard.platform.intl.BbLocale bbLocale = (BbLocale) listElement;
            if(bbLocale.getIsAvailable()){
                // General - show
                return true;
            }
        } 
        return false;
    }


     /**
      * Convenience method for ensuring no errors
      * arise from getting nulls when you expected a String
      * @param string the String to test (can be null)
      * @return a String of zero or more characters in length
      */
     private String trapNulls(String string) {
        if (string == null) {
            return "";
        } else {
            return string.trim();
        }
    }
     
    
}
