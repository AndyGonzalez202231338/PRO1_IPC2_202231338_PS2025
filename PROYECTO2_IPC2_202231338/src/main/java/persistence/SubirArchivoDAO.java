/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package persistence;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import aplication.DBConnection;
import java.sql.Date;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 *
 * @author andy
 */
public class SubirArchivoDAO {
    
    
    private static final Pattern USUARIO_PATTERN = Pattern.compile("USUARIO\\(\"([^\"]+)\",\"([^\"]+)\",(\\d+)\\)");
    private static final Pattern PIEZA_PATTERN = Pattern.compile("PIEZA\\(\"([^\"]+)\",\\s*(\\d+\\.\\d{2})\\)");
    private static final Pattern COMPUTADORA_PATTERN = Pattern.compile("COMPUTADORA\\(\"([^\"]+)\",\\s*(\\d+\\.\\d{2})\\)");
    private static final Pattern ENSAMBLE_PIEZAS_PATTERN = Pattern.compile("ENSAMBLE_PIEZAS\\(\"([^\"]+)\",\\s*\"([^\"]+)\",\\s*(\\d+)\\)");
    private static final Pattern ENSAMBLAR_COMPUTADORA_PATTERN = Pattern.compile("ENSAMBLAR_COMPUTADORA\\(\"([^\"]+)\",\\s*([a-zA-Z0-9_]+),\\s*\"(\\d{2}/\\d{2}/\\d{4})\"\\)");

    
    public String procesarArchivo(InputStream fileContent) throws SQLException, IOException {
        System.out.println("ENTRO A PROCESARARCHIVO xxx");
        StringBuilder resultado = new StringBuilder();
        
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(fileContent, StandardCharsets.UTF_8));
             Connection conn = DBConnection.getConnection()) {
            
            String linea;
            while ((linea = reader.readLine()) != null) {
                linea = linea.trim();
                // Normalizar comillas tipográficas a comillas estándar
                linea = linea.replace("“", "\"").replace("”", "\"");
                System.out.println("linea: "+linea);
                
                if (USUARIO_PATTERN.matcher(linea).matches()) {
                    resultado.append(insertarUsuario(linea, conn)).append("\n");
                } else if (PIEZA_PATTERN.matcher(linea).matches()) {
                    resultado.append(insertarPieza(linea, conn)).append("\n");
                } else if (COMPUTADORA_PATTERN.matcher(linea).matches()) {
                    resultado.append(insertarComputadora(linea, conn)).append("\n");
                } else if (ENSAMBLE_PIEZAS_PATTERN.matcher(linea).matches()) {
                    resultado.append(insertarEnsamblajePieza(linea, conn)).append("\n");
                }else if (ENSAMBLAR_COMPUTADORA_PATTERN.matcher(linea).matches()) {
                    resultado.append(insertarEnsamblajeComputadora(linea, conn)).append("\n");
                }else {
                    System.out.println("NO CONICIDIO");
                    resultado.append("Error en línea: " + linea + " - Comando no reconocido\n");
                }
            }
        }
        
        return resultado.toString();
    }
    
    private String insertarUsuario(String linea, Connection conn) throws SQLException {
        System.out.println("    entre a ingresar el ususario");
        Matcher matcher = USUARIO_PATTERN.matcher(linea);
        if (matcher.find()) {
            String nombreUsuario = matcher.group(1);
            String contrasena = matcher.group(2);
            int idRol = Integer.parseInt(matcher.group(3));
            
            if (contrasena.length() < 8) {
                return "Error: La contraseña de " + nombreUsuario + " debe tener al menos 8 caracteres";
            }
            
            String checkSql = "SELECT COUNT(*) FROM Usuario WHERE NombreUsuario = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, nombreUsuario);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return "Error: El usuario " + nombreUsuario + " ya existe";
                }
            }
            
            String sql = "INSERT INTO Usuario (NombreUsuario, Contrasena, ID_Rol) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nombreUsuario);
                stmt.setString(2, contrasena);
                stmt.setInt(3, idRol);
                stmt.executeUpdate();
                System.out.println("se guardo"+nombreUsuario+","+contrasena+","+idRol);
                return "Usuario " + nombreUsuario + " insertado correctamente";
            }
        }
        return "❌ Error en el formato de USUARIO";
    }
    
    
    private String insertarPieza(String linea, Connection conn) throws SQLException {
        System.out.println("entro a insertar piezas");
    Matcher matcher = PIEZA_PATTERN.matcher(linea);
    if (matcher.find()) {
        String nombre = matcher.group(1);
        double costo = Double.parseDouble(matcher.group(2));

        // Verificar si la pieza ya existe con el mismo nombre y costo
        String checkSql = "SELECT ID, CantidadDisponible FROM Pieza WHERE Nombre = ? AND Costo = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            checkStmt.setString(1, nombre);
            checkStmt.setDouble(2, costo);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                int piezaId = rs.getInt("ID");
                int cantidadActual = rs.getInt("CantidadDisponible");

                // Actualizar cantidad disponible en la pieza existente
                String updateSql = "UPDATE Pieza SET CantidadDisponible = ? WHERE ID = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                    updateStmt.setInt(1, cantidadActual + 1);
                    updateStmt.setInt(2, piezaId);
                    updateStmt.executeUpdate();
                    return "Pieza " + nombre + " actualizada correctamente. Nueva cantidad: " + (cantidadActual + 1);
                }
            }
        }

        // Si no existe, insertamos una nueva pieza con cantidad 1
        String sql = "INSERT INTO Pieza (Nombre, Costo, CantidadDisponible) VALUES (?, ?, 1)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, nombre);
            stmt.setDouble(2, costo);
            stmt.setInt(3, 1); // Se asegura de insertar la cantidad
            stmt.executeUpdate();
            return "Pieza " + nombre + " insertada correctamente con cantidad 1";
        }
    }
    return "Error en el formato de PIEZA";
}

    
    private String insertarComputadora(String linea, Connection conn) throws SQLException {
        Matcher matcher = COMPUTADORA_PATTERN.matcher(linea);
        if (matcher.find()) {
            String nombre = matcher.group(1);
            double precioVenta = Double.parseDouble(matcher.group(2));
            
            String checkSql = "SELECT COUNT(*) FROM Computadora WHERE Nombre = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setString(1, nombre);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return "Error: La computadora " + nombre + " ya existe";
                }
            }
            
            String sql = "INSERT INTO Computadora (Nombre, PrecioVenta) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, nombre);
                stmt.setDouble(2, precioVenta);
                stmt.executeUpdate();
                return "Computadora " + nombre + " insertada correctamente";
            }
        }
        return "Error en el formato de COMPUTADORA";
    }
    
    private String insertarEnsamblajePieza(String linea, Connection conn) throws SQLException {
    Matcher matcher = ENSAMBLE_PIEZAS_PATTERN.matcher(linea);
    if (matcher.find()) {
        String nombreComputadora = matcher.group(1);
        String nombrePieza = matcher.group(2);
        int cantidad = Integer.parseInt(matcher.group(3));

        // Buscar el ID de la computadora
        String queryComputadora = "SELECT ID FROM Computadora WHERE Nombre = ?";
        int idComputadora = -1;
        try (PreparedStatement stmt = conn.prepareStatement(queryComputadora)) {
            stmt.setString(1, nombreComputadora);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                idComputadora = rs.getInt("ID");
            } else {
                return "❌ Error: La computadora '" + nombreComputadora + "' no existe";
            }
        }

        // Buscar el ID de la pieza
        String queryPieza = "SELECT ID FROM Pieza WHERE Nombre = ?";
        int idPieza = -1;
        try (PreparedStatement stmt = conn.prepareStatement(queryPieza)) {
            stmt.setString(1, nombrePieza);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                idPieza = rs.getInt("ID");
            } else {
                return "❌ Error: La pieza '" + nombrePieza + "' no existe";
            }
        }

        // Verificar si ya existe el ensamblaje
        String checkQuery = "SELECT Cantidad FROM Ensamble_Piezas WHERE ID_Computadora = ? AND ID_Pieza = ?";
        try (PreparedStatement checkStmt = conn.prepareStatement(checkQuery)) {
            checkStmt.setInt(1, idComputadora);
            checkStmt.setInt(2, idPieza);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next()) {
                // Si ya existe, actualizar la cantidad
                int nuevaCantidad = rs.getInt("Cantidad") + cantidad;
                String updateQuery = "UPDATE Ensamble_Piezas SET Cantidad = ? WHERE ID_Computadora = ? AND ID_Pieza = ?";
                try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                    updateStmt.setInt(1, nuevaCantidad);
                    updateStmt.setInt(2, idComputadora);
                    updateStmt.setInt(3, idPieza);
                    updateStmt.executeUpdate();
                    return "✅ Ensamble actualizado: " + nombrePieza + " x" + nuevaCantidad + " en " + nombreComputadora;
                }
            }
        }

        // Si no existe, insertar nuevo ensamblaje
        String insertQuery = "INSERT INTO Ensamble_Piezas (ID_Computadora, ID_Pieza, Cantidad) VALUES (?, ?, ?)";
        try (PreparedStatement insertStmt = conn.prepareStatement(insertQuery)) {
            insertStmt.setInt(1, idComputadora);
            insertStmt.setInt(2, idPieza);
            insertStmt.setInt(3, cantidad);
            insertStmt.executeUpdate();
            return "✅ Ensamble realizado: " + nombrePieza + " x" + cantidad + " en " + nombreComputadora;
        }
    }
    return "❌ Error en el formato de ENSAMBLE_PIEZAS";
}

private String insertarEnsamblajeComputadora(String linea, Connection conn) throws SQLException {
    Matcher matcher = ENSAMBLAR_COMPUTADORA_PATTERN.matcher(linea);
    if (matcher.find()) {
        String nombreComputadora = matcher.group(1);
        String nombreUsuario = matcher.group(2);
        String fechaStr = matcher.group(3);

        // Buscar ID de la computadora y precio de venta
String queryComputadora = "SELECT ID, PrecioVenta FROM Computadora WHERE Nombre = ?";
int idComputadora = -1;
double precioVenta = 0;

try (PreparedStatement stmt = conn.prepareStatement(queryComputadora)) {
    stmt.setString(1, nombreComputadora);
    ResultSet rs = stmt.executeQuery();
    if (rs.next()) {
        idComputadora = rs.getInt("ID");
        precioVenta = rs.getDouble("PrecioVenta");  // Obtener el precio de venta correctamente
    } else {
        return "❌ Error: La computadora '" + nombreComputadora + "' no existe";
    }
}

        // Validar existencia del usuario en la base de datos 
        String queryUsuario = "SELECT NombreUsuario FROM Usuario WHERE NombreUsuario = ?";
        try (PreparedStatement stmt = conn.prepareStatement(queryUsuario)) {
            stmt.setString(1, nombreUsuario);
            ResultSet rs = stmt.executeQuery();
            if (!rs.next()) {
                return "❌ Error: El usuario '" + nombreUsuario + "' no existe";
            }
        }

        // Calcular costo total (sumar precio de venta de la computadora + costo de las piezas ensambladas)
        String queryCostoPiezas = "SELECT COALESCE(SUM(P.Costo * EP.Cantidad), 0) AS CostoTotal " +
                                  "FROM Ensamble_Piezas EP JOIN Pieza P ON EP.ID_Pieza = P.ID " +
                                  "WHERE EP.ID_Computadora = ?";
        double costoPiezas = 0;
        try (PreparedStatement stmt = conn.prepareStatement(queryCostoPiezas)) {
            stmt.setInt(1, idComputadora);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                costoPiezas = rs.getDouble("CostoTotal");
            }
        }
        
        double costoTotal = precioVenta + costoPiezas;  // Sumar precio de la computadora y piezas ensambladas

        // Insertar ensamblaje
        String insertQuery = "INSERT INTO Computadora_Ensamblada (ID_Computadora, NombreUsuario, FechaEnsamblaje, CostoTotal) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(insertQuery)) {
            stmt.setInt(1, idComputadora);
            stmt.setString(2, nombreUsuario);
            stmt.setDate(3, Date.valueOf(LocalDate.parse(fechaStr, DateTimeFormatter.ofPattern("dd/MM/yyyy"))));
            stmt.setDouble(4, costoTotal);
            System.out.println("|"+idComputadora+"|"+nombreUsuario+"|"+costoTotal);
            stmt.executeUpdate();
            return "✅ Ensamblaje de computadora '" + nombreComputadora + "' registrado con costo total: $" + costoTotal;
        }
    }
    return "❌ Error en el formato de ENSAMBLAR_COMPUTADORA";
}

}
