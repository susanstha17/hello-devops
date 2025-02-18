package com.techaxis;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/anotherPage")
public class AnotherPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.getWriter().write("<h1>Hello DevSecOps</h1><p>Welcome to the TechAxis DevSecOps Class!</p>");
    }package com.techaxis;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/anotherPage")
public class AnotherPageServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");

        String htmlContent = "<!DOCTYPE html>"
            + "<html lang='en'>"
            + "<head>"
            + "<meta charset='UTF-8'>"
            + "<meta name='viewport' content='width=device-width, initial-scale=1.0'>"
            + "<title>Welcome to DevSecOps</title>"
            + "<style>"
            + "body {"
            + "font-family: 'Arial', sans-serif;"
            + "background-color: #f4f7f6;"
            + "margin: 0;"
            + "padding: 0;"
            + "text-align: center;"
            + "}"
            + "header {"
            + "background-color: #2d3e50;"
            + "color: white;"
            + "padding: 20px;"
            + "}"
            + "header h1 {"
            + "margin: 0;"
            + "font-size: 40px;"
            + "}"
            + ".content {"
            + "background-color: #fff;"
            + "box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);"
            + "padding: 40px;"
            + "border-radius: 8px;"
            + "margin-top: 30px;"
            + "}"
            + ".content h2 {"
            + "color: #2d3e50;"
            + "font-size: 28px;"
            + "}"
            + ".content p {"
            + "font-size: 18px;"
            + "color: #555;"
            + "line-height: 1.6;"
            + "}"
            + "footer {"
            + "background-color: #2d3e50;"
            + "color: white;"
            + "padding: 15px;"
            + "position: fixed;"
            + "width: 100%;"
            + "bottom: 0;"
            + "text-align: center;"
            + "}"
            + "</style>"
            + "</head>"
            + "<body>"
            + "<header>"
            + "<h1>TechAxis DevSecOps Class</h1>"
            + "</header>"
            + "<div class='content'>"
            + "<h2>Hello, DevSecOps Enthusiast!</h2>"
            + "<p>Welcome to the TechAxis DevSecOps Class! Here we explore the intersection of development, security, and operations, preparing you for the future of IT.</p>"
            + "</div>"
            + "<footer>"
            + "&copy; 2025 TechAxis | All Rights Reserved"
            + "</footer>"
            + "</body>"
            + "</html>";

        resp.getWriter().write(htmlContent);
    }
}

}
