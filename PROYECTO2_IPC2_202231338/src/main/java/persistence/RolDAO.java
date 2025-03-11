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
import model.Rol;

/**
 *
 * @author andy
 */


public class RolDAO extends CrudDAO<Rol> {

    @Override
    public Rol insert(Rol entity) throws SQLException {
        String query = "INSERT INTO rol (role_name, description) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, entity.getName()); // Nombre es ENUM en MySQL
            stmt.setString(2, entity.getDescription()); // Si agregaste la columna Descripcion

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        entity.setId(generatedKeys.getInt(1));
                    }
                }
            }
        }
        return entity;
    }

    @Override
    public Rol findById(String id) throws SQLException {
        String sql = "SELECT * FROM rol WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(id));
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Rol(rs.getInt("id"), rs.getString("role_name"), rs.getString("description"));
                }
            }
        }
        return null;
    }
    ////////////hjhj
    @Override
    public List<Rol> findAll() throws SQLException {
        List<Rol> roles = new ArrayList<>();
        String sql = "SELECT * FROM rol";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                roles.add(new Rol(rs.getInt("id"), rs.getString("role_name"), rs.getString("description")));
            }
        }
        return roles;
    }

    @Override
    public void update(Rol entity) throws SQLException {
        String sql = "UPDATE rol SET role_name = ?, description = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, entity.getName()); // ENUM en MySQL
            stmt.setString(2, entity.getDescription()); // Si agregaste la columna Descripcion
            stmt.setInt(3, entity.getId());

            stmt.executeUpdate();
        }
    }

    @Override
    public void delete(String id) throws SQLException {
        String sql = "DELETE FROM rol WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, Integer.parseInt(id));
            stmt.executeUpdate();
        }
    }
}

