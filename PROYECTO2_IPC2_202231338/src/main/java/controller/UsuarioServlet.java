/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Rol;
import model.Usuario;
import persistence.RolDAO;
import persistence.UsuarioDAO;

/**
 *
 * @author andy
 */
@WebServlet(urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {
    private UsuarioDAO UsuarioDAO = new UsuarioDAO();
    private RolDAO rolDAO = new RolDAO();
    //private final Encript encript = new Encript();

        protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.reset(); 
        try {
            List<Usuario> users = UsuarioDAO.findAll();
            request.setAttribute("users", users);
            List<Rol> roles = this.rolDAO.findAll();
            request.setAttribute("roles", roles);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        /*if (!response.isCommitted()) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Administracion/personal.jsp?view=list");
            dispatcher.forward(request, response);
        }*/

        RequestDispatcher dispatcher = request.getRequestDispatcher("/Administracion/personal.jsp?view=list");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String method = request.getParameter("_method");
        if (method != null && method.equalsIgnoreCase("PUT")) {
            doPut(request, response);
            return;
        }

        String name = request.getParameter("name");//nombre segun el html las cajas que piden datos
        String password = request.getParameter("password");
        String roleId = request.getParameter("rolId");
        System.out.println(name+password+roleId);
        //String passwordEncript = this.encript.ecnode(password);

        Usuario userForm = new Usuario(name, password, Integer.valueOf(roleId));

        try {
            this.UsuarioDAO.insert(userForm);
            
            //response.sendRedirect("/personal.jsp?view=create&success=true");
            response.sendRedirect(request.getContextPath() + "/Administracion/personal.jsp?view=create&success=true");
            //response.sendRedirect(request.getContextPath() + "/personal.jsp?view=create&success=true");

            // mostrar un swetAlert de usuario guardado 
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

        String action = request.getParameter("action");

        if ("darDeBaja".equals(action)) {
            //int userId = Integer.parseInt(request.getParameter("userId"));
            String userId = request.getParameter("userId");
            try {
                Usuario user = UsuarioDAO.findById(userId);
                if (user != null) {
                    //user.setState("DISABLED");
                    //UsuarioDAO.update(user);
                    response.sendRedirect("/Administracion/personal.jsp?view=list&enable=true");
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } else {
            processRequest(request, response);
        }

    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
