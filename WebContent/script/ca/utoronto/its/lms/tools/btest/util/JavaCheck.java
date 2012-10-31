/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package ca.utoronto.its.lms.tools.btest.util;

/**
 *
 * @author Jose Manuel Lopez Lujan, University of Toronto.
 * 
 */
import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.*;

public class JavaCheck extends Applet {

    Font f = new Font("Clibri", Font.PLAIN, 24);
    Font f1 = new Font("Calibri", Font.PLAIN, 15);
    Font f3 = new Font("Calibri", Font.PLAIN, 10);
    private static final long serialVersionUID = 1L;

    public void init() {
        setLayout(new BorderLayout());

        setFont(f);
        Label title = new Label("Your java is working");
        Label credits = new Label("University of Toronto, Information + Technology Services");
        credits.setFont(f3);
        title.setFont(f);
        credits.setAlignment(Label.CENTER);
        title.setAlignment(Label.CENTER);

        TextArea localTextArea = new TextArea("\n", 8, 20);
        localTextArea.setEnabled(false);
        localTextArea.setFont(f1);
        add(title, BorderLayout.NORTH);
        add(credits, BorderLayout.SOUTH);
        add(localTextArea, BorderLayout.CENTER);

        String[] arrayOfString = {"os.name", "browser", "browser.vendor",
            "browser.version", "java.vendor", "java.version",
            "os.arch"};
        String str = null;
        try {
            str = "Your Java Configuration is as follows: \n\n";
            localTextArea.append(str);
            str = "Operating System: " + System.getProperty(arrayOfString[0]) + "\n";
            localTextArea.append(str);
            str = "Vendor:  " + System.getProperty(arrayOfString[2]) + "\n";
            localTextArea.append(str);
            str = "Java Vendor: " + System.getProperty(arrayOfString[4]) + "\n";
            localTextArea.append(str);
            str = "Java Version: " + System.getProperty(arrayOfString[5]) + "\n";
            localTextArea.append(str);
            str = "Architecture: " + System.getProperty(arrayOfString[6]) + "\n";
            localTextArea.append(str);



        } catch (SecurityException localSecurityException) {
            str = "Security Exception Raised\n";
            System.out.println(str);
        }
    }
}