package durham.ng.browser;

import blackboard.platform.plugin.PlugInUtil;
import ca.utoronto.its.lms.tools.btest.util.BuildingBlockHelper;

/**
 * Models sample content items such as a Word document
 *
 * @author Dr Malcolm Murray, Durham University
 */
public class SampleResource {

    private String resourceName;
    private String fileExtension;
    private String resourceFile;
    private String resourceIcon;
    private boolean exceptionCaught;
    private StringBuffer errorLog;
    final String vendorId = BuildingBlockHelper.VENDOR_ID;
    final String handle = BuildingBlockHelper.HANDLE;

    /**
     * Create a new instance of SampleResource
     */
    public SampleResource() {
        setResourceName("");
        setFileExtension("");
        setResourceFile("");
        setResourceIcon("");

        setExceptionCaught(false);
        setErrorLog(new StringBuffer(""));
    }

    /**
     * Convenience method for ensuring no errors arise from getting nulls when
     * you expected a String
     *
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

    /**
     * Indicates whether an exception was thrown and caught during method calls
     * in this class. Default is false.
     *
     * @return true if an exception was caught.
     */
    public boolean isExceptionCaught() {
        return exceptionCaught;
    }

    /**
     * Private setter used within this class
     *
     * @param exceptionCaught Set to true if one has
     */
    private void setExceptionCaught(boolean exceptionCaught) {
        this.exceptionCaught = exceptionCaught;
    }

    /**
     * Internal method for getting the ErrorLog. Outside the class use
     *
     * @see getErrorMessage to display the details to a user.
     * @return StringBuffer containing details of any exceptions
     */
    private StringBuffer getErrorLog() {
        return errorLog;
    }

    /**
     * Provides details of the error to display to the user
     *
     * @return HTML paragraph object
     */
    public String getErrorMessage() {
        if (getErrorLog().length() == 0) {
            return "";
        } else {
            return "<p>" + getErrorLog().toString() + "</p>";
        }
    }

    /**
     * Private setter (normally only called when the class is initiated).
     *
     * @param errorLog
     */
    private void setErrorLog(StringBuffer errorLog) {
        this.errorLog = errorLog;
    }

    /**
     * Access a human readable version of the item's name, e.g. 'Microsoft Word
     * 2007'
     *
     * @return human readable version of the name
     */
    public String getResourceName() {
        return resourceName;
    }

    public void setResourceName(String resourceName) {
        this.resourceName = trapNulls(resourceName);
    }

    /**
     * Access the common file extension e.g. pdf, ppt, docx, etc.
     *
     * @return the common file extension
     */
    public String getFileExtension() {
        return fileExtension;
    }

    public void setFileExtension(String fileExtension) {
        this.fileExtension = trapNulls(fileExtension);
    }

    /**
     * Access the name of the corresponding sample file in the /samples folder
     *
     * @return filename
     */
    public String getResourceFile() {
        return resourceFile;
    }

    /**
     * Method to generate a full URL for the appropriare icon
     *
     * @return Fully qualified URL
     */
    public String getResourceFileUrl() {
        if (getResourceFile().length() == 0) {
            return "";
        }
        String imageUrl = "samples/" + getResourceFile();
        return PlugInUtil.getUri(vendorId, handle, imageUrl);
    }

    public void setResourceFile(String resourceFile) {
        this.resourceFile = trapNulls(resourceFile);
    }

    /**
     * Access a link to a 30 x 30 px image (icon) representing this sample type
     *
     * @return URL to an icon file
     */
    public String getResourceIcon() {
        return resourceIcon;
    }

    /**
     * Method to generate a full URL for the appropriare icon
     *
     * @return Fully qualified URL
     */
    public String getResourceIconUrl() {
        if (getResourceIcon().length() == 0) {
            return "";
        }
        String imageUrl = "images/" + getResourceIcon();
        return PlugInUtil.getUri(vendorId, handle, imageUrl);
    }

    public void setResourceIcon(String resourceIcon) {
        this.resourceIcon = trapNulls(resourceIcon);
    }

    /**
     * Method to create a clickable link to the document. Will display either a
     * 30 x 30px icon or the file extension (e.g. doc) depending on the value of
     * the flag asIcon
     *
     * @param asIcon if true returns an icon, else the text of the file
     * extension
     * @return HTML for a linksBuffer.append(getResourceIconUrl());
     */
    private String createLink(boolean asIcon) {
        StringBuffer sBuffer = new StringBuffer("");
        sBuffer.append("<a href=\"");
        sBuffer.append(getResourceFileUrl());
        sBuffer.append("\" target=\"_blank\" title=\"Open a ");
        sBuffer.append(getFileExtension());
        sBuffer.append(" file\">");
        if (asIcon) {
            sBuffer.append("<img align=\"left\" width=\"30\" height=\"30\" border=\"0\" src=\"");
            sBuffer.append(getResourceIconUrl());
            sBuffer.append("\">");
        } else {
            sBuffer.append(getFileExtension());
        }
        sBuffer.append("</a>");
        return sBuffer.toString();
    }

    /**
     * Get the HTML to display the icon which is a clickable link to point to
     * the appropriate file
     *
     * @return HTML for icon and link
     */
    public String getIconAsLink() {
        return createLink(true);
    }

    /**
     * Get the HTML to display the appropriate extension, e.g. doc, ppt which is
     * a clickable link to point to the appropriate file
     *
     * @return HTML for link
     */
    public String getExtensionAsLink() {
        return createLink(false);
    }

    /**
     * Displays all the entries required to display in a miniList object
     *
     * @return HTML for a bbNG:miniListElement
     */
    public String getMiniListEntry() {
        StringBuffer sBuffer = new StringBuffer("");
        sBuffer.append(getIconAsLink());
        sBuffer.append("&nbsp;");
        sBuffer.append(getExtensionAsLink());
        sBuffer.append("&nbsp;");
        sBuffer.append(getResourceName());
        return sBuffer.toString();
    }
}
