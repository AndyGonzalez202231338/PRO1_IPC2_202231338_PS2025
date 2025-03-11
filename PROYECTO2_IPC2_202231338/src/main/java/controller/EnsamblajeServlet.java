/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;
import persistence.UsuarioDAO;

/**
 *
 * @author andy
 */
@WebServlet(urlPatterns = {"/EnsamblajeServlet"})
public class EnsamblajeServlet extends HttpServlet {
    private UsuarioDAO UsuarioDAO = new UsuarioDAO();
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EnsamblajeServlet</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EnsamblajeServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Usuario user;
        try {
            user = UsuarioDAO.findById(username); // Obtener usuario de la base de datos
            if (user != null && user.getPassword().equals(password) &&
            (user.getRoleId() == 1 || user.getRoleId() == 3)) {
                System.out.println("login correcto");
            // Usuario autenticado correctamente
            request.getSession().setAttribute("user", user);

            response.sendRedirect(request.getContextPath() + "/Ensamblaje/ensamblaje.jsp");


        } else {
            // Redirigir con mensaje de error
            response.sendRedirect("/Ensamblaje/ensamblaje_login.jsp?error=1");
        }
        } catch (SQLException ex) {
            Logger.getLogger(EnsamblajeServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
