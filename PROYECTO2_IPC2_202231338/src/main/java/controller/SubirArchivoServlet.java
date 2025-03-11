/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import persistence.SubirArchivoDAO;

/**
 *
 * @author andy
 */
@WebServlet(urlPatterns = {"/SubirArchivoServlet"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SubirArchivoServlet extends HttpServlet {

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

    private SubirArchivoDAO subirArchivoDAO = new SubirArchivoDAO();
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Part filePart = request.getPart("archivo");
        if (filePart == null || filePart.getSize() == 0) {
            request.setAttribute("mensaje", "Error: No se ha subido ningún archivo.");
            //request.getRequestDispatcher(request.getContextPath() + "/Administracion/carga.jsp").forward(request, response);
            return;
        }

        try (InputStream fileContent = filePart.getInputStream()) {
            String resultado = subirArchivoDAO.procesarArchivo(fileContent);
            request.setAttribute("mensaje", "Se ha subido a la base de datos" + resultado);
        } catch (SQLException ex) { 
            Logger.getLogger(SubirArchivoServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher("/Administracion/carga.jsp").forward(request, response);
    }

}
