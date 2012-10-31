package durham.ng.browser;

import java.util.ArrayList;

/**
 * Loader to create a list of SampleResource objects
 *
 * @author Dr Malcolm Murray, Durham University
 */
public class SampleResourceLoader {

    private ArrayList sampleList;
    private boolean exceptionCaught;
    private StringBuffer errorLog;

    /**
     * Create a new instance of SampleResourceLoader
     */
    public SampleResourceLoader() {
        setSampleList(new ArrayList(7));
        setExceptionCaught(false);
        setErrorLog(new StringBuffer(""));
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

    public void loadAll() {
        // add a series of SampleResource items

        // Word
        SampleResource docResource = new SampleResource();
        docResource.setFileExtension("doc");
        docResource.setResourceName("Microsoft Word (97 - 2003 Format)");
        docResource.setResourceFile("sample.doc");
        docResource.setResourceIcon("doc.png");
        sampleList.add(docResource);

        SampleResource docxResource = new SampleResource();
        docxResource.setFileExtension("docx");
        docxResource.setResourceName("Microsoft Word (2007/XML Format)");
        docxResource.setResourceFile("sample.docx");
        docxResource.setResourceIcon("docx.png");
        sampleList.add(docxResource);

        // Excel
        SampleResource xlsResource = new SampleResource();
        xlsResource.setFileExtension("xls");
        xlsResource.setResourceName("Microsoft Excel (97 - 2003 Format)");
        xlsResource.setResourceFile("sample.xls");
        xlsResource.setResourceIcon("xls.png");
        sampleList.add(xlsResource);

        SampleResource xlsxResource = new SampleResource();
        xlsxResource.setFileExtension("xlsx");
        xlsxResource.setResourceName("Microsoft Excel (2007/XML Format)");
        xlsxResource.setResourceFile("sample.xlsx");
        xlsxResource.setResourceIcon("xlsx.png");
        sampleList.add(xlsxResource);

        // PowerPoint
        SampleResource pptResource = new SampleResource();
        pptResource.setFileExtension("ppt");
        pptResource.setResourceName("Microsoft PowerPoint (97 - 2003 Format)");
        pptResource.setResourceFile("sample.ppt");
        pptResource.setResourceIcon("ppt.png");
        sampleList.add(pptResource);

        SampleResource pptxResource = new SampleResource();
        pptxResource.setFileExtension("pptx");
        pptxResource.setResourceName("Microsoft PowerPoint (2007/XML Format)");
        pptxResource.setResourceFile("sample.pptx");
        pptxResource.setResourceIcon("pptx.png");
        sampleList.add(pptxResource);

        // Acrobat
        SampleResource pdfResource = new SampleResource();
        pdfResource.setFileExtension("pdf");
        pdfResource.setResourceName("Adobe Acrobat (Portable Document Format)");
        pdfResource.setResourceFile("sample.pdf");
        pdfResource.setResourceIcon("pdf.png");
        sampleList.add(pdfResource);


    }

    public ArrayList getSampleList() {
        return sampleList;
    }

    public void setSampleList(ArrayList sampleList) {
        this.sampleList = sampleList;
    }
}
