package com.fuem.controllers;

import com.fuem.dao.UserDAO;
import com.fuem.models.User;
import com.fuem.utils.Cookies;

import jakarta.json.Json;
import jakarta.json.JsonObject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.StringReader; // Added import for StringReader
import java.net.HttpURLConnection;
import java.net.URL;
import javax.net.ssl.HttpsURLConnection;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/LoginGoogleHandler")
public class LoginGoogleHandler extends HttpServlet {

    private static final String CLIENT_ID = "89142229238-cu1tiul7dl16gs4qigcjsgd0emkk3j0d.apps.googleusercontent.com";
    private static final String CLIENT_SECRET = "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";
    private static final String REDIRECT_URI = "http://localhost:8080/event-management/LoginGoogleHandler";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");
        if (code != null) {
            String accessToken = getAccessToken(code);
            if (accessToken != null) {
                JsonObject userInfo = getUserInfo(accessToken);
                if (userInfo != null) {
                    String email = userInfo.getString("email");
                    UserDAO userDAO = new UserDAO();
                    User user = userDAO.getUserByEmail(email);
                    System.out.println(email);
                    System.out.println(user);

                    if (user != null) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", user);
                        Cookies.add("userInfo", user, 120, response);
                        response.sendRedirect("home");
                    } else {
                        request.getRequestDispatcher("authentication/sign-in.jsp?error=email_not_registered").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "Unable to fetch user information");
                    request.getRequestDispatcher("authentication/sign-in.jsp?error=email_not_registered").forward(request, response);

                }
            } else {
                request.getRequestDispatcher("authentication/sign-in.jsp?error=email_not_registered").forward(request, response);

            }
        } else {
            request.getRequestDispatcher("authentication/sign-in.jsp?error=email_not_registered").forward(request, response);

        }
    }

    private String getAccessToken(String code) throws IOException {
        String url = "https://oauth2.googleapis.com/token";
        URL obj = new URL(url);
        HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
        con.setRequestMethod("POST");
        con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

        String urlParameters = "code=" + code
                + "&client_id=" + CLIENT_ID
                + "&client_secret=" + CLIENT_SECRET
                + "&redirect_uri=" + REDIRECT_URI
                + "&grant_type=authorization_code";

        con.setDoOutput(true);
        try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
            wr.writeBytes(urlParameters);
            wr.flush();
        }

        int responseCode = con.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                StringBuilder response = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                // Parse JSON response to get access token
                JsonObject jsonObject = Json.createReader(new StringReader(response.toString())).readObject();
                return jsonObject.getString("access_token");
            } catch (IOException e) {
                Logger.getLogger(LoginGoogleHandler.class.getName()).log(Level.SEVERE, null, e);
            }
        } else {
            return null;
        }
        return null;
    }

    private JsonObject getUserInfo(String accessToken) throws IOException {
        String url = "https://www.googleapis.com/oauth2/v1/userinfo?access_token=" + accessToken;
        URL obj = new URL(url);
        HttpsURLConnection con = (HttpsURLConnection) obj.openConnection();
        con.setRequestMethod("GET");

        int responseCode = con.getResponseCode();
        if (responseCode == HttpURLConnection.HTTP_OK) {
            try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
                StringBuilder response = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                // Parse JSON response to get user info
                return Json.createReader(new StringReader(response.toString())).readObject();
            }
        } else {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Handles Google login";
    }
}
