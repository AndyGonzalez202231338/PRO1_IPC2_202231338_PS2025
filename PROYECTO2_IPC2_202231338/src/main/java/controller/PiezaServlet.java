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
import model.Pieza;
import persistence.PiezaDAO;

/**
 *
 * @author andy
 */
@WebServlet(urlPatterns = {"/PiezaServlet"})
public class PiezaServlet extends HttpServlet {

    private PiezaDAO piezaDAO = new PiezaDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }
    /**
     * verifica las acciones que se desea con la lista de piezas que se necesiten, busca y devuleve la ruta adecuada de la web
     * @param request
     * @param response
     * @throws ServletException
     * @throws IOException 
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("se entro al metodo doget");
        String accion = request.getParameter("accion");

        if ("eliminar".equals(accion)) {
            String id = request.getParameter("id");
            try {
                piezaDAO.delete(id);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() + "/PiezaServlet?success=Pieza eliminada correctamente");
        } else {
            // Si no es eliminar, obtenemos la lista de piezas
            try {
                List<Pieza> piezas = piezaDAO.findAll();
                System.out.println("Piezas obtenidas en el servlet: " + piezas.size());
                request.setAttribute("piezas", piezas);
            } catch (SQLException e) {
                e.printStackTrace();
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("/Ensamblaje/piezas.jsp");
            //RequestDispatcher dispatcher = request.getRequestDispatcher("/Ensamblaje/ensamblaje.jsp?view=piezaslista");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");

        if ("editar".equals(accion)) {
            System.out.println("Se entro a editar");
            int id = Integer.parseInt(request.getParameter("id"));
            String nombre = request.getParameter("nombre");
            double costo = Double.parseDouble(request.getParameter("costo"));
            int cantidad = Integer.parseInt(request.getParameter("cantidad"));
            System.out.println(id + "," + nombre + "," + costo + "," + cantidad);
            Pieza piezaEditada = new Pieza(id, nombre, costo, cantidad);
            try {
                piezaDAO.update(piezaEditada);
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            response.sendRedirect(request.getContextPath() +"/PiezaServlet?success=Pieza editada correctamente");
        } else {
            try {
                String nombre = request.getParameter("nombre");
                String costoStr = request.getParameter("costo");
                String cantidadStr = request.getParameter("cantidad");

                if (nombre == null || nombre.trim().isEmpty() || costoStr == null || cantidadStr == null) {
                    response.sendRedirect(request.getContextPath() + "/Ensamblaje/Ensamblaje/PiezaServlet?error=Datos inválidos");
                    return;
                }

                double costo = Double.parseDouble(costoStr);
                int cantidad = Integer.parseInt(cantidadStr);

                Pieza nuevaPieza = new Pieza(0, nombre, costo, cantidad);
                piezaDAO.insert(nuevaPieza);

                response.sendRedirect(request.getContextPath() +"/PiezaServlet?success=Pieza editada correctamente");
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/Ensamblaje/PiezaServlet?error=Formato de datos incorrecto");
            } catch (SQLException ex) {
                ex.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/Ensamblaje/PiezaServlet?error=Error en la base de datos");
            }

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
