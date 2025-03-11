<%-- 
    Document   : venta_login
    Created on : 8/03/2025, 23:36:23
    Author     : andy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Acceso Ventas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex items-center justify-center h-screen bg-red-100">
    <div class="bg-white p-6 rounded-lg shadow-lg">
        <h2 class="text-2xl font-bold mb-4">Acceso a Ventas</h2>
        <% if (request.getParameter("error") != null) { %>
            <p class="text-red-500">Usuario o contraseña incorrectos</p>
        <% } %>
        <form action="/PROYECTO2_IPC2_202231338/VentaServlet" method="POST">
            <div class="mb-4">
                <label class="block text-red-700">Usuario</label>
                <input type="text" name="username" required class="w-full p-2 border rounded-lg">
            </div>
            <div class="mb-4">
                <label class="block text-red-700">Contraseña</label>
                <input type="password" name="password" required class="w-full p-2 border rounded-lg">
            </div>
            <button type="submit" class="w-full bg-red-500 text-white py-2 rounded-lg">Ingresar</button>
        </form>
    </div>
</body>
</html>
