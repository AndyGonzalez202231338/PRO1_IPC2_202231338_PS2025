<%-- 
    Document   : editar_pieza
    Created on : 8/03/2025, 13:03:14
    Author     : andy
--%>

<%@page import="model.Pieza"%>
<%@page import="java.sql.SQLException"%>
<%@page import="persistence.PiezaDAO"%>

<%
    /**
     * Apartado hecho para mostrar las piezas o componentes de computadoras
     * se encarga de la edicion de componentes al igual que de acciones como ordeanr por cantidades o mostrar advertencias
     */
    PiezaDAO piezaDAO = new PiezaDAO();
    int id = Integer.parseInt(request.getParameter("id"));
    Pieza pieza = piezaDAO.findById(String.valueOf(id));
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Pieza</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-red-100 flex justify-center items-center h-screen">
    <div class="bg-white p-6 rounded-lg shadow-md">
        <h2 class="text-xl font-bold">Editar Pieza</h2>
        <form action="./../PiezaServlet" method="POST">
            <input type="hidden" name="id" value="<%= pieza.getID() %>">
            
            <div class="mb-4">
                <label class="block text-green-700-700">Nombre:</label>
                <input type="text" name="nombre" value="<%= pieza.getNombre() %>" required class="w-full border px-4 py-2 rounded-lg">
            </div>
            <div class="mb-4">
                <label class="block text-green-700">Costo:</label>
                <input type="number" step="0.01" name="costo" value="<%= pieza.getCosto() %>" required class="w-full border px-4 py-2 rounded-lg">
            </div>
            <div class="mb-4">
                <label class="block text-green-700">Cantidad:</label>
                <input type="number" name="cantidad" value="<%= pieza.getCantidadDisponible() %>" required class="w-full border px-4 py-2 rounded-lg">
            </div>
            <div class="flex space-x-2">
                <button type="submit" name="accion" value="editar" class="bg-green-500 text-white px-4 py-2 rounded-lg">Guardar Cambios</button>
                <a href="../PiezaServlet" class="bg-green-500 text-white px-4 py-2 rounded-lg">Cancelar</a>
            </div>
        </form>
    </div>
</body>
</html>

