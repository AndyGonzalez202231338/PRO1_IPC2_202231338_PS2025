/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import aplication.DBConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Usuario;

/**
 *
 * @author andy
 */
@WebServlet("/RegistrarVentaServlet")
public class RegistrarVentaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nit = request.getParameter("nit");
        String nombreCliente = request.getParameter("nombreCliente");
        String direccion = request.getParameter("direccion");
        int idComputadora = Integer.parseInt(request.getParameter("idComputadora"));

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int idCliente = -1;
        int idVenta = -1;
        double precioVenta = 0.0;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // Validar si el cliente ya existe por NIT
            String sqlCliente = "SELECT ID FROM Cliente WHERE NIT = ?";
            stmt = conn.prepareStatement(sqlCliente);
            stmt.setString(1, nit);
            rs = stmt.executeQuery();
            if (rs.next()) {
                idCliente = rs.getInt("ID");
            } else {
                // Insertar nuevo cliente si no existe
                String insertCliente = "INSERT INTO Cliente (Nombre, NIT, Direccion) VALUES (?, ?, ?)";
                stmt = conn.prepareStatement(insertCliente, Statement.RETURN_GENERATED_KEYS);
                stmt.setString(1, nombreCliente);
                stmt.setString(2, nit);
                stmt.setString(3, direccion);
                stmt.executeUpdate();
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    idCliente = rs.getInt(1);
                }
            }

            // Obtener precio de la computadora ensamblada
            String sqlPrecio = "SELECT CostoTotal FROM Computadora_Ensamblada WHERE ID = ?";
            stmt = conn.prepareStatement(sqlPrecio);
            stmt.setInt(1, idComputadora);
            rs = stmt.executeQuery();
            if (rs.next()) {
                precioVenta = rs.getDouble("CostoTotal");
            }

            // Registrar la venta
            String insertVenta = "INSERT INTO Venta (NombreUsuario, ID_Cliente, FechaVenta, Total) VALUES (?, ?, CURDATE(), ?)";
            stmt = conn.prepareStatement(insertVenta, Statement.RETURN_GENERATED_KEYS);
            Object userObj = request.getSession().getAttribute("user");
if (userObj == null) {
    response.sendRedirect("login.jsp?error=not_authenticated");
    return;
}
            Usuario usuario = new Usuario();
            usuario = (Usuario) userObj;
            String nombreUsuario = usuario.getNombre();
//String nombreUsuario = userObj.toString();
            System.out.println("("+nombreUsuario+")");
            stmt.setString(1, nombreUsuario);
            stmt.setInt(2, idCliente);
            stmt.setDouble(3, precioVenta);
            stmt.executeUpdate();
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                idVenta = rs.getInt(1);
            }

            // Registrar detalle de venta
            String insertDetalle = "INSERT INTO Detalle_Venta (ID_Venta, ID_ComputadoraEnsamblada, PrecioVenta) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(insertDetalle);
            stmt.setInt(1, idVenta);
            stmt.setInt(2, idComputadora);
            stmt.setDouble(3, precioVenta);
            stmt.executeUpdate();

            // Actualizar estado de la computadora ensamblada a 'Vendido'
            String updateComputadora = "UPDATE Computadora_Ensamblada SET Estado = 'Vendida' WHERE ID = ?";
            stmt = conn.prepareStatement(updateComputadora);
            stmt.setInt(1, idComputadora);
            stmt.executeUpdate();

            conn.commit();
            response.sendRedirect("venta.jsp?view=computadoraslista&success=true");
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            response.sendRedirect("venta.jsp?view=computadoraslista&error=true");
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}

