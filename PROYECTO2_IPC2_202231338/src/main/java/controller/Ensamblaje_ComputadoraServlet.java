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
import model.Ensamblaje_Computadora;
import persistence.Ensamblaje_ComputadoraDAO;

/**
 *
 * @author andy
 */
@WebServlet(name = "Ensamblaje_ComputadoraServlet", urlPatterns = {"/Ensamblaje_ComputadoraServlet"})
public class Ensamblaje_ComputadoraServlet extends HttpServlet {

    private Ensamblaje_ComputadoraDAO Ensamblaje_ComputadoraDAO = new Ensamblaje_ComputadoraDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Ensamblaje_ComputadoraServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Ensamblaje_ComputadoraServlet at " + request.getContextPath() + "</h1>");
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
        try {
            // Recuperamos la lista de computadoras ensambladas
            List<Ensamblaje_Computadora> ensamblajeComputadoras = Ensamblaje_ComputadoraDAO.findAll();
            
            // Verifica si se están obteniendo datos
    System.out.println("Computadoras obtenidas:");
    for (Ensamblaje_Computadora computadora : ensamblajeComputadoras) {
        System.out.println("ID: " + computadora.getID() + ", Estado: " + computadora.getEstado());
    }

            // Seteamos la lista en la request
            request.setAttribute("ensamblajeComputadoras", ensamblajeComputadoras);

            // Obtenemos el parámetro de vista desde la URL
            String view = request.getParameter("view");

            // Comprobamos qué vista se solicita y redirigimos según sea necesario
            String nextPage = "/Ensamblaje/ensamblajeComputadora.jsp"; // Página predeterminada

            if ("computadoraslista".equals(view)) {
                System.out.println("ENTRO A VENTAS");
                nextPage = "/Ventas/venta.jsp?view=computadoraslista"; // Si el parámetro es ventas, redirigimos a ventas.jsp
            }else if ("desplegar".equals(view)) {
                System.out.println("ENTRO A VENTASss");
                nextPage = "/Ventas/venta.jsp?view=venta"; // Si el parámetro es ventas, redirigimos a ventas.jsp
            }

            // Redirigimos a la página correspondiente
            RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("enviarAVentas".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("id: " + id);

            try {
                Ensamblaje_ComputadoraDAO.marcarComoVendible(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect("/PROYECTO2_IPC2_202231338/Ensamblaje/ensamblaje.jsp?view=ensambladaslista");
            //response.sendRedirect("#");
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
