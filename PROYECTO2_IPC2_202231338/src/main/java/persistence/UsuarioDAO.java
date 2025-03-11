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
import model.Usuario;

/**
 *
 * @author andy
 */
public class UsuarioDAO extends CrudDAO<Usuario>{
    
    @Override
    public Usuario insert(Usuario entity) throws SQLException {
        String sql = "INSERT INTO Usuario (NombreUsuario, Contrasena, ID_Rol) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, entity.getNombre());
            stmt.setString(2, entity.getPassword());
            stmt.setInt(3, entity.getRoleId());

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
    public Usuario findById(String nombre) throws SQLException {
    String sql = "SELECT * FROM Usuario WHERE NombreUsuario = ?";
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, nombre);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return new Usuario(
                    rs.getString("NombreUsuario"),
                    rs.getString("Contrasena"),
                    rs.getInt("ID_Rol")
                );
            }
        }
    }
    return null;
}

    //lista
    @Override
    public List<Usuario> findAll() throws SQLException {
        List<Usuario> users = new ArrayList<>();
        String sql = "SELECT * FROM Usuario";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new Usuario(
                        rs.getString("NombreUsuario"),
                        rs.getString("Contrasena"),
                        rs.getInt("ID_Rol")
                ));
            }
        }
        return users;
    }

    //lista de usuarios en la  base de datos
    @Override
    public void update(Usuario entity) throws SQLException {
        String sql = "UPDATE Usuario SET NombreUsuario = ?, Contrasena = ?, ID_Rol = ? WHERE NombreUsuario = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, entity.getNombre());
            stmt.setString(2, entity.getPassword());
            stmt.setInt(3, entity.getRoleId());
            
            stmt.executeUpdate();
        }
    }

    //cambiar el integer
    @Override
    public void delete(String nombre) throws SQLException {
        String sql = "DELETE FROM Usuario WHERE Nombreusuario = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, nombre);
            stmt.executeUpdate();
        }
    }

}
