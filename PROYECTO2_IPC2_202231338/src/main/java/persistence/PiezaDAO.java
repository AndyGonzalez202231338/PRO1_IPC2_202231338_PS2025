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
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Pieza;

/**
 *
 * @author andy
 */
public class PiezaDAO extends CrudDAO<Pieza>{

    @Override
    public Pieza insert(Pieza entity) throws SQLException {
        String sql = "INSERT INTO Pieza (Nombre, Costo, CantidadDisponible) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, entity.getNombre());
            stmt.setDouble(2, entity.getCosto());
            stmt.setInt(3, entity.getCantidadDisponible());
            

            // Obtener el ID generado
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        entity.setID(generatedKeys.getInt(1));
                    }
                }
            }
        }
        return entity;
    }

    @Override
    public Pieza findById(String id) throws SQLException {
        String sql = "SELECT * FROM Pieza WHERE ID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement stmt = con.prepareStatement(sql)) {
            int idInt = Integer.parseInt(id);
            stmt.setInt(1, idInt);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Pieza(
                    rs.getInt("ID"),
                    rs.getString("Nombre"),
                    rs.getDouble("Costo"),
                    rs.getInt("CantidadDisponible")
                );
            }
        }
        return null; // No encontrado
    }

    @Override
public List<Pieza> findAll() throws SQLException {
        System.out.println("FindALL");
    List<Pieza> piezas = new ArrayList<>();
    String sql = "SELECT * FROM Pieza";
    try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            piezas.add(new Pieza(
                rs.getInt("ID"),
                rs.getString("Nombre"),
                rs.getDouble("Costo"),
                rs.getInt("CantidadDisponible")
            ));
            //System.out.println("Pieza encontrada: " + pieza.getNombre() + " - " + pieza.getCosto());
            
        }
    }
    System.out.println("Total de piezas obtenidas: " + piezas.size());
    return piezas;
}


    @Override
    public void update(Pieza pieza) throws SQLException {
        String sql = "UPDATE Pieza SET Nombre = ?, Costo = ?, CantidadDisponible = ? WHERE ID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, pieza.getNombre());
            ps.setDouble(2, pieza.getCosto());
            ps.setInt(3, pieza.getCantidadDisponible());
            ps.setInt(4, pieza.getID());
            ps.executeUpdate();
        }
    }

    @Override
    public void delete(String id) throws SQLException {
        String sql = "DELETE FROM Pieza WHERE ID = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            int idInt = Integer.parseInt(id);
            ps.setInt(1, idInt);
            ps.executeUpdate();
        }
    }
    
}
