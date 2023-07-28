/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import entity.Course;
import entity.News;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author Admin
 */
public class NoticeNews {

    public void sendEmail(List<String> gmail, String subject, String body) {
        try {
            final String fromEmail = "academyswpg3@gmail.com";
            final String password = "fbxasrlxnovxwptf";
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com"); //SMTP Host
            props.put("mail.smtp.port", "587"); //TLS Port
            props.put("mail.smtp.auth", "true"); //enable authentication
            props.put("mail.smtp.starttls.enable", "true"); //enable STARTTLS
            Authenticator auth = new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            };
            Session session = Session.getInstance(props, auth);
            MimeMessage msg = new MimeMessage(session);
            //set message headers
            msg.addHeader("Content-type", "text/HTML; charset=UTF-8");
            msg.addHeader("format", "flowed");
            msg.addHeader("Content-Transfer-Encoding", "8bit");
            msg.setFrom(new InternetAddress(fromEmail, "AcademySWP3"));
            msg.setReplyTo(InternetAddress.parse(fromEmail, false));
            msg.setSubject(subject, "UTF-8");
            msg.setContent(body, "text/html; charset=UTF-8");
            msg.setSentDate(new Date());
            List<InternetAddress> ia = new ArrayList<>();
            for (String mail : gmail) {
                ia.add(new InternetAddress(mail));
            }
            InternetAddress[] recipients = ia.toArray(new InternetAddress[gmail.size()]);
            msg.setRecipients(Message.RecipientType.TO, recipients);
            Transport.send(msg);
            System.out.println("Gui mail thanh cong");
        } catch (Exception ex) {
            Logger.getLogger(SendEmail.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public String NewsContent(News news){
        String body = "<!DOCTYPE html>\n"
                    + "<html>\n"
                    + "\n"
                    + "<head>\n"
                    + "    <title></title>\n"
                    + "    <meta charset=\"UTF-8\">\n"
                    + "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                    + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                    + "    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />\n"
                    + "    <style type=\"text/css\">\n"
                    + "        @media screen {\n"
                    + "            @font-face {\n"
                    + "                font-family: 'Lato';\n"
                    + "                font-style: normal;\n"
                    + "                font-weight: 400;\n"
                    + "                src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format('woff');\n"
                    + "            }\n"
                    + "\n"
                    + "            @font-face {\n"
                    + "                font-family: 'Lato';\n"
                    + "                font-style: normal;\n"
                    + "                font-weight: 700;\n"
                    + "                src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format('woff');\n"
                    + "            }\n"
                    + "\n"
                    + "            @font-face {\n"
                    + "                font-family: 'Lato';\n"
                    + "                font-style: italic;\n"
                    + "                font-weight: 400;\n"
                    + "                src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format('woff');\n"
                    + "            }\n"
                    + "\n"
                    + "            @font-face {\n"
                    + "                font-family: 'Lato';\n"
                    + "                font-style: italic;\n"
                    + "                font-weight: 700;\n"
                    + "                src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format('woff');\n"
                    + "            }\n"
                    + "        }\n"
                    + "\n"
                    + "        /* CLIENT-SPECIFIC STYLES */\n"
                    + "        body,\n"
                    + "        table,\n"
                    + "        td,\n"
                    + "        a {\n"
                    + "            -webkit-text-size-adjust: 100%;\n"
                    + "            -ms-text-size-adjust: 100%;\n"
                    + "        }\n"
                    + "\n"
                    + "        table,\n"
                    + "        td {\n"
                    + "            mso-table-lspace: 0pt;\n"
                    + "            mso-table-rspace: 0pt;\n"
                    + "        }\n"
                    + "\n"
                    + "        img {\n"
                    + "            -ms-interpolation-mode: bicubic;\n"
                    + "        }\n"
                    + "\n"
                    + "        /* RESET STYLES */\n"
                    + "        img {\n"
                    + "            border: 0;\n"
                    + "            height: auto;\n"
                    + "            line-height: 100%;\n"
                    + "            outline: none;\n"
                    + "            text-decoration: none;\n"
                    + "        }\n"
                    + "\n"
                    + "        table {\n"
                    + "            border-collapse: collapse !important;\n"
                    + "        }\n"
                    + "\n"
                    + "        body {\n"
                    + "            height: 100% !important;\n"
                    + "            margin: 0 !important;\n"
                    + "            padding: 0 !important;\n"
                    + "            width: 100% !important;\n"
                    + "        }\n"
                    + "\n"
                    + "        /* iOS BLUE LINKS */\n"
                    + "        a[x-apple-data-detectors] {\n"
                    + "            color: inherit !important;\n"
                    + "            text-decoration: none !important;\n"
                    + "            font-size: inherit !important;\n"
                    + "            font-family: inherit !important;\n"
                    + "            font-weight: inherit !important;\n"
                    + "            line-height: inherit !important;\n"
                    + "        }\n"
                    + "\n"
                    + "        /* MOBILE STYLES */\n"
                    + "        @media screen and (max-width:600px) {\n"
                    + "            h1 {\n"
                    + "                font-size: 32px !important;\n"
                    + "                line-height: 32px !important;\n"
                    + "            }\n"
                    + "        }\n"
                    + "\n"
                    + "        /* ANDROID CENTER FIX */\n"
                    + "        div[style=\"margin: 16px 0;\"] {\n"
                    + "            margin: 0 !important;\n"
                    + "        }\n"
                    + "    </style>\n"
                    + "</head>\n"
                    + "\n"
                    + "<body style=\"background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;\">\n"
                    + "    <!-- HIDDEN PREHEADER TEXT -->\n"
                    + "    <div style=\"display: none; font-size: 1px; color: #fefefe; line-height: 1px; font-family: 'Lato' , Helvetica,\n"
                    + "        Arial, sans-serif; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden;\"> We're thrilled to have you\n"
                    + "        here! Get ready to dive into your new account.\n"
                    + "    </div>\n"
                    + "    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n"
                    + "        <!-- LOGO -->\n"
                    + "        <tr>\n"
                    + "            <td bgcolor=\"#51be78\" align=\"center\">\n"
                    + "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n"
                    + "                    <tr>\n"
                    + "                        <td align=\"center\" valign=\"top\" style=\"padding: 40px 10px 40px 10px;\"> </td>\n"
                    + "                    </tr>\n"
                    + "                </table>\n"
                    + "            </td>\n"
                    + "        </tr>\n"
                    + "        <tr>\n"
                    + "            <td bgcolor=\"#51be78\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\n"
                    + "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n"
                    + "                    <tr>\n"
                    + "                        <td bgcolor=\"#ffffff\" align=\"center\" valign=\"top\" style=\"padding: 40px 20px 20px 20px;\n"
                    + "                            border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato' , Helvetica, Arial,\n"
                    + "                            sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;\">\n"
                    + "                            <h1 style=\"font-size: 30px; font-weight: 400; margin: 2;\">"+news.getTitle()+"</h1>\n"
                    + "                        </td>\n"
                    + "                    </tr>\n"
                    + "                </table>\n"
                    + "            </td>\n"
                    + "        </tr>\n"
                    + "        <tr>\n"
                    + "            <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\n"
                    + "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n"
                    + "                    <tr>\n"
                    + "                        <td bgcolor=\"#ffffff\" align=\"left\">\n"
                    + "                            <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
                    + "                                <tr>\n"
                    + "                                    <td bgcolor=\"#ffffff\" align=\"center\" style=\"padding: 20px 30px 60px 30px;\">\n"
                    + "                                        <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n"
                    + "                                            <tr>\n"
                    + "                                                <td align=\"center\" style=\"border-radius: 3px;\" bgcolor=\"#FFA73B\">\n"
                    + "                                                    <a href=\"http://localhost:8080/SWP391_Group3/newsDetails/"+news.getSlug()+"\" target=\"_blank\"\n"
                    + "                                                        style=\"font-size: 20px; font-family: Helvetica, Arial,\n"
                    + "                                                        sans-serif; color: #ffffff; text-decoration: none; color:\n"
                    + "                                                        #ffffff; text-decoration: none; padding: 15px 25px;\n"
                    + "                                                        border-radius: 2px; border: 1px solid #FFA73B; display:\n"
                    + "                                                        inline-block;\">Read More</a></td>\n"
                    + "                                            </tr>\n"
                    + "                                        </table>\n"
                    + "                                    </td>\n"
                    + "                                </tr>\n"
                    + "                            </table>\n"
                    + "                        </td>\n"
                    + "                    </tr> <!-- COPY -->\n"
                    + "                </table>\n"
                    + "            </td>\n"
                    + "        </tr>\n"
                    + "        <tr>\n"
                    + "            <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\n"
                    + "                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n"
                    + "                    <tr>\n"
                    + "                        <td bgcolor=\"#f4f4f4\" align=\"left\" style=\"padding: 0px 30px 30px 30px; color: #666666;\n"
                    + "                            font-family: 'Lato' , Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 400;\n"
                    + "                            line-height: 18px;\"> <br>\n"
                    + "                            <p style=\"margin: 0;\">If these emails get annoying, please feel free to <a href=\"http://localhost:8080/SWP391_Group3/unfollowedpage.jsp\"\n"
                    + "                                    target=\"_blank\" style=\"color: #111111; font-weight: 700;\">unsubscribe</a>.</p>\n"
                    + "                        </td>\n"
                    + "                    </tr>\n"
                    + "                </table>\n"
                    + "            </td>\n"
                    + "        </tr>\n"
                    + "    </table>\n"
                    + "</body>\n"
                    + "\n"
                    + "</html>";
        return body;
    }
    
    public String CourseContent(Course c){
        return "<html>\n" +
"                \n" +
"                <head>\n" +
"                    <title></title>\n" +
"                    <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n" +
"                    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
"                    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\" />\n" +
"                    <style type=\"text/css\">\n" +
"                        @media screen {\n" +
"                            @font-face {\n" +
"                                font-family: 'Lato';\n" +
"                                font-style: normal;\n" +
"                                font-weight: 400;\n" +
"                                src: local('Lato Regular'), local('Lato-Regular'), url(https://fonts.gstatic.com/s/lato/v11/qIIYRU-oROkIk8vfvxw6QvesZW2xOQ-xsNqO47m55DA.woff) format('woff');\n" +
"                            }\n" +
"                \n" +
"                            @font-face {\n" +
"                                font-family: 'Lato';\n" +
"                                font-style: normal;\n" +
"                                font-weight: 700;\n" +
"                                src: local('Lato Bold'), local('Lato-Bold'), url(https://fonts.gstatic.com/s/lato/v11/qdgUG4U09HnJwhYI-uK18wLUuEpTyoUstqEm5AMlJo4.woff) format('woff');\n" +
"                            }\n" +
"                \n" +
"                            @font-face {\n" +
"                                font-family: 'Lato';\n" +
"                                font-style: italic;\n" +
"                                font-weight: 400;\n" +
"                                src: local('Lato Italic'), local('Lato-Italic'), url(https://fonts.gstatic.com/s/lato/v11/RYyZNoeFgb0l7W3Vu1aSWOvvDin1pK8aKteLpeZ5c0A.woff) format('woff');\n" +
"                            }\n" +
"                \n" +
"                            @font-face {\n" +
"                                font-family: 'Lato';\n" +
"                                font-style: italic;\n" +
"                                font-weight: 700;\n" +
"                                src: local('Lato Bold Italic'), local('Lato-BoldItalic'), url(https://fonts.gstatic.com/s/lato/v11/HkF_qI1x_noxlxhrhMQYELO3LdcAZYWl9Si6vvxL-qU.woff) format('woff');\n" +
"                            }\n" +
"                        }\n" +
"                \n" +
"                        /* CLIENT-SPECIFIC STYLES */\n" +
"                        body,\n" +
"                        table,\n" +
"                        td,\n" +
"                        a {\n" +
"                            -webkit-text-size-adjust: 100%;\n" +
"                            -ms-text-size-adjust: 100%;\n" +
"                        }\n" +
"                \n" +
"                        table,\n" +
"                        td {\n" +
"                            mso-table-lspace: 0pt;\n" +
"                            mso-table-rspace: 0pt;\n" +
"                        }\n" +
"                \n" +
"                        img {\n" +
"                            -ms-interpolation-mode: bicubic;\n" +
"                        }\n" +
"                \n" +
"                        /* RESET STYLES */\n" +
"                        img {\n" +
"                            border: 0;\n" +
"                            height: auto;\n" +
"                            line-height: 100%;\n" +
"                            outline: none;\n" +
"                            text-decoration: none;\n" +
"                        }\n" +
"                \n" +
"                        table {\n" +
"                            border-collapse: collapse !important;\n" +
"                        }\n" +
"                \n" +
"                        body {\n" +
"                            height: 100% !important;\n" +
"                            margin: 0 !important;\n" +
"                            padding: 0 !important;\n" +
"                            width: 100% !important;\n" +
"                        }\n" +
"            \n" +
"                        /* iOS BLUE LINKS */\n" +
"                        a[x-apple-data-detectors] {\n" +
"                            color: inherit !important;\n" +
"                            text-decoration: none !important;\n" +
"                            font-size: inherit !important;\n" +
"                            font-family: inherit !important;\n" +
"                            font-weight: inherit !important;\n" +
"                            line-height: inherit !important;\n" +
"                        }\n" +
"                \n" +
"                        /* MOBILE STYLES */\n" +
"                        @media screen and (max-width:600px) {\n" +
"                            h1 {\n" +
"                                font-size: 32px !important;\n" +
"                                line-height: 32px !important;\n" +
"                            }\n" +
"                        }\n" +
"                \n" +
"                        /* ANDROID CENTER FIX */\n" +
"                        div[style*=\"margin: 16px 0;\"] {\n" +
"                            margin: 0 !important;\n" +
"                        }\n" +
"                    </style>\n" +
"                </head>\n" +
"                \n" +
"                <body style=\"background-color: #f4f4f4; margin: 0 !important; padding: 0 !important;\">\n" +
"                    <!-- HIDDEN PREHEADER TEXT -->\n" +
"                    <div style=\"display: none; font-size: 1px; color: #fefefe; line-height: 1px; font-family: 'Lato', Helvetica, Arial, sans-serif; max-height: 0px; max-width: 0px; opacity: 0; overflow: hidden;\"> We're thrilled to have you here! Get ready to dive into your new account.\"\n" +
"                    </div>\n" +
"                    <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\">\n" +
"                        <!-- LOGO -->\n" +
"                        <tr>\n" +
"                            <td bgcolor=\"#51be78\" align=\"center\">\n" +
"                                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n" +
"                                    <tr>\n" +
"                                        <td align=\"center\" valign=\"top\" style=\"padding: 40px 10px 40px 10px;\"> </td>\n" +
"                                    </tr>\n" +
"                                </table>\n" +
"                            </td>\n" +
"                        </tr>\n" +
"                        <tr>\n" +
"                            <td bgcolor=\"#51be78\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\n" +
"                                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n" +
"                                    <tr>\n" +
"                                        <td bgcolor=\"#ffffff\" align=\"center\" valign=\"top\" style=\"padding: 40px 20px 20px 20px; border-radius: 4px 4px 0px 0px; color: #111111; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 48px; font-weight: 400; letter-spacing: 4px; line-height: 48px;\">\n" +
"                                            <h1 style=\"font-size: 48px; font-weight: 400; margin: 2;\">New Courses</h1> \n" +
"                                        </td>\n" +
"                                    </tr>\n" +
"                                </table>\n" +
"                            </td>\n" +
"                        </tr>\n" +
"                        <tr>\n" +
"                            <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\n" +
"                                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n" +
"                                    <tr>\n" +
"                                        <td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">\n" +
"                                            <h3 style=\"margin: 0; text-align: center;\">"+ c.getName()+"</h3>\n" +
"                                        </td>\n" +
"                                    </tr>\n" +
"                                    <tr>\n" +
"                                        <td bgcolor=\"#ffffff\" align=\"left\" style=\"padding: 20px 30px 40px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 18px; font-weight: 400; line-height: 25px;\">\n" +
"                                            <p style=\"margin: 0; text-align: center;\">"+c.getDescription()+"</p>\n" +
"                                        </td>\n" +
"                                    </tr>\n" +
"                                    <tr>\n" +
"                                        <td bgcolor=\"#ffffff\" align=\"left\">\n" +
"                                            <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" +
"                                                <tr>\n" +
"                                                    <td bgcolor=\"#ffffff\" align=\"center\" style=\"padding: 20px 30px 60px 30px;\">\n" +
"                                                        <table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n" +
"                                                            <tr>\n" +
"                                                                <td align=\"center\" style=\"border-radius: 3px;\" bgcolor=\"#51be78\"><a href=\"http://localhost:8080/SWP391_Group3/course/"+c.getSlug()+"\" target=\"_blank\" style=\"font-size: 20px; font-family: Helvetica, Arial, sans-serif; color: #ffffff; text-decoration: none; color: #ffffff; text-decoration: none; padding: 15px 25px; border-radius: 2px; border: 1px solid #51be78; display: inline-block;\">View Details</a></td>\n" +
"                                                            </tr>\n" +
"                                                        </table>\n" +
"                                                    </td>\n" +
"                                                </tr>\n" +
"                                            </table>\n" +
"                                        </td>\n" +
"                                    </tr> <!-- COPY -->\n" +
"                                    \n" +
"                                </table>\n" +
"                            </td>\n" +
"                        </tr>\n" +
"                        <tr>\n" +
"                            <td bgcolor=\"#f4f4f4\" align=\"center\" style=\"padding: 0px 10px 0px 10px;\">\n" +
"                                <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"max-width: 600px;\">\n" +
"                                    <tr>\n" +
"                                        <td bgcolor=\"#f4f4f4\" align=\"left\" style=\"padding: 0px 30px 30px 30px; color: #666666; font-family: 'Lato', Helvetica, Arial, sans-serif; font-size: 14px; font-weight: 400; line-height: 18px;\"> <br>\n" +
"                                            <p style=\"margin: 0;\">If these emails get annoying, please feel free to <a href=\"http://localhost:8080/SWP391_Group3/unfollowedpage.jsp\" target=\"_blank\" style=\"color: #111111; font-weight: 700;\">unsubscribe</a>.</p>\n" +
"                                        </td>\n" +
"                                    </tr>\n" +
"                                </table>\n" +
"                            </td>\n" +
"                        </tr>\n" +
"                    </table>\n" +
"                </body>\n" +
"                \n" +
"                </html>";
    }
}
