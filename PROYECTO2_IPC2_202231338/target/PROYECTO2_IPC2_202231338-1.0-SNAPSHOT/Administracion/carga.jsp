<%-- 
    Document   : carga
    Created on : 7/03/2025, 11:31:47
    Author     : andy
--%>
<%@page import="model.Usuario"%>
<%@page import="model.Computadora"%>
<%@page import="model.Pieza"%>
<%
    /*Este apartado sirve para mostrar el ensamble de computadoras, recibe las listas de piezas y computadoras para desplegarlo en la parte viual
    */
    String view = request.getParameter("view");
    
    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null || (user.getRoleId() != 1 && user.getRoleId() != 3)) {
        response.sendRedirect("ensamblaje_login.jsp");
        return;
    }
    
    if ("piezaslista".equals(view) && request.getAttribute("piezas") == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/PiezasServlet");
        dispatcher.forward(request, response);
    }
    
    if ("computadoraslista".equals(view) && request.getAttribute("computadoras") == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ComputadoraServlet");
        dispatcher.forward(request, response);
    }
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administración de Usuarios</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="flex h-screen bg-purple-100">

        <!-- Sidebar -->
        <aside class="w-64 bg-purple-800 text-white flex flex-col">
            <div class="p-5 text-xl font-bold border-b border-purple-700">
                Panel de Usuarios
            </div>
            <nav class="flex-1 p-4">
                <a href="/PROYECTO2_IPC2_202231338/Ensamblaje/ensamblaje.jsp" class="block px-4 py-2 rounded-lg hover:bg-purple-700">Panel ensamblaje</a>
                <a href="../ComputadoraServlet" class="block px-4 py-2 rounded-lg hover:bg-purple-700">Modelos Computadoras</a>
                <a href="carga.jsp?view=manual" class="block px-4 py-2 rounded-lg hover:bg-purple-700">Manual Ensamblaje</a>
            </nav>
            <div class="p-4 border-t border-gray-700">
                <a href="#" class="block px-4 py-2 text-red-400 hover:bg-red-600 hover:text-white rounded-lg">
                    Cerrar sesión
                </a>
            </div>
        </aside>

        <!-- Contenido Principal -->
        <div class="flex-1 flex flex-col">

            <!-- Navbar -->
            <header class="bg-white shadow-md p-4 flex justify-between items-center">
                <h1 class="text-xl font-bold">Administración de Usuarios</h1>
                <div class="flex items-center space-x-4">
                    <span class="text-purple-700">Admin</span>
                    <img src="https://via.placeholder.com/40" class="w-10 h-10 rounded-full border">
                </div>
            </header>

            <!-- Contenido -->
            <main class="flex-1 p-6">
                <div class="bg-white p-6 shadow rounded-lg">

                    <!-- Título -->
                    <h2 class="text-2xl font-bold mb-4">Carga de Datos al sistema por medio de Archivos</h2>
                    <p class="text-gray-600 mb-6">Aquí puedes subir informacion a la base de datos por medio de un archivo con las instrucciones correctas para realizar una accion.</p>
                    <!-- Contenido -->
            <main class="flex-1 p-6">
                <div class="bg-white p-6 shadow rounded-lg">
                    <h2 class="text-2xl font-bold mb-4">📂 Carga de Archivos</h2>
                    <p class="text-gray-600 mb-6">Sube archivos CSV o de tipo codificación UTF-8 para importar datos al sistema.</p>
                    
                    <!-- Formulario de subida de archivos -->
                    <form action="/PROYECTO2_IPC2_202231338/SubirArchivoServlet" method="POST" enctype="multipart/form-data" class="bg-red-100 p-6 rounded-lg shadow-md">
                        <label class="block text-purple-700 font-bold mb-2">Seleccionar archivo:</label>
                        <input type="file" name="archivo" class="w-full p-2 border rounded-lg mb-4">
                        <button type="submit" class="bg-purple-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
                            📤 Subir Archivo
                        </button>
                    </form>
                </div>
            </main>

                <main class="flex-1 p-6">
                <div class="bg-white p-6 shadow rounded-lg">
                    <!-- Apartado de Manual -->
                <% if ("manual".equals(view)) { %> 
                <div class="mb-8">
                    <h3 class="text-xl font-bold mb-3">Manual de Ensamblaje</h3>
                    <p class="text-gray-600">El ensamblaje de computadoras consiste en unir diferentes componentes de hardware para formar un equipo funcional. Este proceso solo puede ser realizado
                        por usuarios que sean de tipo ensamblador o algun Administrador.
                        En este proceso, se deben seguir ciertos pasos para asegurar que el equipo funcione correctamente y tenga una buena durabilidad.</p>
                    
                    <p class="text-pruple-600">
                        En la empresa existen modelos de computadora que pueden ser creadas a patir de cirtas piezas, puedes encontrar los diferentes modelos en el apartado de -Modelos de Computadoras-.
                    </p>
                </div>
                <% }%>
                
                <!-- Apartado de Manual -->
                <% if ("modelos".equals(view)) { %> 
                <div class="mb-8">
                    <h3 class="text-xl font-bold mb-3">Modelos de Computadoras</h3>
                    <p class="text-gray-600">Estos son algunos modelos de computadoras ensambladas, se muestran el numero de piezas utlizadas para crear el modelo y precio final a la venta</p>
                    <div class="mb-8">
                        <h3 class="text-xl font-bold mb-3">Tipos de Modelos</h3>
                        <table id="tablaPiezas" class="w-full bg-white border border-purple-300 rounded-lg">
                            <thead class="bg-purple-200">
                                <tr>
                                    <th class="p-2 border">Nombre</th>
                                    <th class="p-2 border">Precio</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="computadora" items="${computadoras}">
                                    <tr class="hover:bg-gray-100">
                                        <td class="p-2 border">${computadora.nombre}</td>
                                        <td class="p-2 border">${computadora.precioVenta}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                </div>
                <!-- Tabla de Componentes de Modelos -->
                <% }%>
                </div>
                
            </main>

            <!-- Footer -->
            <footer class="bg-white text-center text-purple-600 p-4 border-t">
                &copy; 2025 Admin Panel. Todos los derechos reservados.
            </footer>

        </div>

    </body>
</html>
