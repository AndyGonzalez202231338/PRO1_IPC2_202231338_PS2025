/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistence;

import aplication.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Ensamblaje_Computadora;
/**
 *
 * @author andy
 */
public class Ensamblaje_ComputadoraDAO extends CrudDAO<Ensamblaje_Computadora>{

    @Override
    public Ensamblaje_Computadora insert(Ensamblaje_Computadora entity) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public Ensamblaje_Computadora findById(String id) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public List<Ensamblaje_Computadora> findAll() throws SQLException {
        List<Ensamblaje_Computadora> computadoras = new ArrayList<>();
        String sql = "SELECT * FROM Computadora_Ensamblada";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            computadoras.add(new Ensamblaje_Computadora(
                rs.getInt("ID"),
                rs.getInt("ID_Computadora"),
                rs.getString("NombreUsuario"),
                rs.getDate("FechaEnsamblaje"),
                rs.getDouble("CostoTotal"),
                rs.getString("Estado")
            ));
            
        }
    }
        return computadoras;
    }
    
public void marcarComoVendible(int id) throws SQLException {
    String sql = "UPDATE Computadora_Ensamblada SET Estado = 'En Venta' WHERE ID = ?";
    
    try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, id);
        stmt.executeUpdate(); // Usamos executeUpdate() en lugar de executeQuery()
    }
}
    

    public List<Ensamblaje_Computadora> findAllEnVenta() throws SQLException {
    List<Ensamblaje_Computadora> lista = new ArrayList<>();
    String sql = "SELECT * FROM Ensamblaje_Computadora WHERE estado = 'En Venta'";
    
    try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Ensamblaje_Computadora computadora = new Ensamblaje_Computadora();
            computadora.setID(rs.getInt("id"));
            computadora.setID_Computadora(rs.getInt("id_computadora"));
            computadora.setNombreUsuario(rs.getString("nombre_usuario"));
            computadora.setFechaEnsamblaje(rs.getDate("fecha_ensamblaje"));
            computadora.setCostoTotal(rs.getDouble("costo_total"));
            computadora.setEstado(rs.getString("estado"));
            lista.add(computadora);
        }
    }
    return lista;
}

    @Override
    public void update(Ensamblaje_Computadora entity) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    @Override
    public void delete(String id) throws SQLException {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
    
}
