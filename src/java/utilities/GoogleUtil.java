/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utilities;

import java.io.IOException;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Form;
import org.apache.http.client.fluent.Request;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import entity.UserGoogle;

/**
 *
 * @author Admin
 */
public class GoogleUtil {

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String uri = "https://accounts.google.com/o/oauth2/token?code=" + code + "&client_id=1037340877364-3grh6jb6cinv86g71hnjdl8ki3ruqijg.apps.googleusercontent.com&client_secret=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&redirect_uri=http://localhost:8080/SWP391_Group3/loginwithgg&grant_type=authorization_code";
        String response = Request.Post(uri).execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserGoogle getUserInfo(final String accessToken) throws ClientProtocolException, IOException {
        String link = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        UserGoogle googlePojo = new Gson().fromJson(response, UserGoogle.class);
        return googlePojo;
    }
}

