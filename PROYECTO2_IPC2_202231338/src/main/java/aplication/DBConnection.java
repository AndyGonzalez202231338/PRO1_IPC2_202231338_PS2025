/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package aplication;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class DBConnection {
       
    private static final String URL = "jdbc:mysql://localhost:3306/proyecto1";
    private static final String USER = "admin";
    private static final String PASSWORD = "admin";
    
    
    private static Connection connection;
    
    static {
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Error al cargar el driver JDBC ", e);
        }
    }

    private DBConnection() {}

    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            synchronized (DBConnection.class) {
                if (connection == null || connection.isClosed()) {
                    connection = DriverManager.getConnection(URL, USER, PASSWORD);
                }
            }
        }
        return connection;
    }
}
