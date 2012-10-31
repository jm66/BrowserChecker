package ca.utoronto.its.lms.tools.btest.web.fback;

import java.awt.image.BufferedImage;
import java.io.*;
import java.util.*;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.UUID; 

import blackboard.platform.plugin.PlugInUtil;
import ca.utoronto.its.lms.tools.btest.util.*;
import edu.northwestern.at.logging.*;
import org.apache.commons.io.IOUtils;

/**
 * Servlet implementation class GetFeedback
 */

  
public class GetFeedback extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String messageText = "";
	private String inbox = "jm.lopez@utoronto.ca";
	private String outbox = "feedback@portal.utoronto.ca";

	   
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		try {
			request.setCharacterEncoding("UTF8");
			UUID uniqueKey = UUID.randomUUID();
			
			if (request.getParameter("message") != null)
				messageText = request.getParameter("message").toString();
			
			LogManager.log(this.getClass().getName(), new StringBuilder().append("Message length: ").append(messageText.length()));
			
			String imgStrBase64 = request.getParameter("image").split(",")[1].replace(" ", "+");
			LogManager.log(this.getClass().getName(), "Image encrypted length: "+imgStrBase64.length());
			LogManager.log(this.getClass().getName(),  new StringBuilder().append("Image encrypted length: ").append(imgStrBase64.length()).toString());
			
			byte[] dataBytes = Base64.decode(imgStrBase64.getBytes("UTF-8")); 
			InputStream input = new ByteArrayInputStream( dataBytes);
			
			StringBuffer sb = new StringBuffer();
			sb.append(PlugInUtil.getConfigDirectory(BuildingBlockHelper.VENDOR_ID, BuildingBlockHelper.HANDLE)).append(BuildingBlockHelper.FS);
			sb.append(BuildingBlockHelper.UPLOAD_TEMP_FOLDER).append(BuildingBlockHelper.FS).append(uniqueKey).append(".png");
			
			OutputStream output = new FileOutputStream(sb.toString());
			IOUtils.copy(input, output);
			LogManager.log(this.getClass().getName(),  new StringBuilder().append("Uploaded file: ").append(sb.toString()).toString());

		} catch (Exception ex){
			LogManager.logError(this.getClass().getName(), ex.getMessage());
		}
		
	}	
    	 

    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFeedback() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
	
	}

	/**
	 * @see Servlet#getServletInfo()
	 */
	public String getServletInfo() {
		// TODO Auto-generated method stub
		return null; 
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		processRequest(request, response);
	}

}
