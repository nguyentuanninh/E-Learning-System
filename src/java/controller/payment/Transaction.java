/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.payment;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import entity.AboutType;
import entity.Recharge;
import entity.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.List;
import model.AboutDAO;
import model.AboutTypeDAO;
import model.RechargeDAO;
import model.UserDAO;

/**
 *
 * @author MSII
 */
@WebServlet(name = "transaction", urlPatterns = {"/transaction"})
public class Transaction extends HttpServlet {
    private static final String ACCOUNT = "account";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute(ACCOUNT) == null) {
            response.sendRedirect("/SWP391_Group3/login.jsp");
            return;
        }
        UserAccount user = (UserAccount) session.getAttribute(ACCOUNT);
        UserDAO udao = new UserDAO();
        session.setAttribute(ACCOUNT, udao.getUserById(user.getId()));
        user = (UserAccount) session.getAttribute("account");
        String uri = "https://api.vietqr.io/image/BIDV-42710000799609-8jVaRSc.jpg?addInfo=recharge%20" + user.getId();
        request.setAttribute("uri", uri);

        //about category
        AboutDAO abD = new AboutDAO();
        AboutTypeDAO abtD = new AboutTypeDAO();
        List<AboutType> listaboutgroup = abtD.getTypeOfAbout();
        request.setAttribute("listaboutgroup", listaboutgroup);
        //end category

        controller.share.NewServlet.headerFooter(request);
        request.getRequestDispatcher("payment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String securetoken = request.getHeader("secure-token");
        if (!securetoken.equals("elearning")) {
            return;
        }
        try {
            int contentLength = Integer.parseInt(request.getHeader("Content-Length"));
            InputStream inputStream = request.getInputStream();
            byte[] bytes = new byte[contentLength];
            inputStream.read(bytes);
            String text = new String(bytes, StandardCharsets.UTF_8);
            Gson gson = new Gson();
            JsonObject jobj = gson.fromJson(text, JsonObject.class).getAsJsonArray("data").get(0).getAsJsonObject();
            String status = "Error";

            //get the Transaction data            
            int amount = Integer.parseInt(jobj.get("amount").toString());
            String content = jobj.get("description").toString().replaceAll("[\\\\,\\.,\"]", "");
            String bankAccount = jobj.get("bank_sub_acc_id").toString().replaceAll("[\\\\,\\.,\"]", "");
            String[] description = jobj.get("description").toString().replaceAll("[\\\\,\\.]", "").split("\\s+");
            int userid = -1;
            for (int i = 0; i < description.length; i++) {
                if (description[i].equalsIgnoreCase("recharge") && (i + 1) <= description.length) {
                    try {
                        if (Integer.parseInt(description[i + 1]) % 1 == 0) {
                            userid = Integer.parseInt(description[i + 1]);
                            break;
                        }
                    } catch (NumberFormatException e) {
                        break;
                    }
                }
            }
            String when = jobj.get("when").toString().replaceAll("\"", "");
            SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            java.util.Date date = dateFormatter.parse(when);
            java.sql.Timestamp sqldate = new java.sql.Timestamp(date.getTime());

            //cộng tiền vào tài khoản user
            RechargeDAO rechargeDAO = new RechargeDAO();
            if (userDAO.getUserById(userid) != null) {
                status = "Success";
                UserAccount user = userDAO.getUserById(userid);
                userDAO.updateUserAmount(user.getId(), (user.getAmount() + amount));
            }

            rechargeDAO.addRecharge(new Recharge(-1, userid, status, sqldate, amount, bankAccount, content));
        } catch (Exception e) {
            response.sendRedirect("/home");
        }
    }

}
