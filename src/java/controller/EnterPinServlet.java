package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name ="EnterPinServlet", urlPatterns = {"/EnterPinServlet"})
public class EnterPinServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       response.sendRedirect(request.getContextPath() + "/views/enterPin.jsp?action=" + request.getContextPath() + "/ProcessTransferServlet");

    }
}
