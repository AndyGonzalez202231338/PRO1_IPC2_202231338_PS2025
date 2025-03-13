<%-- 
    Document   : ensamblaje
    Created on : 6/03/2025, 10:25:51
    Author     : andy
--%>

<%@page import="model.Usuario"%>
<%@page import="model.Pieza"%>
<%
    /**
     * Panel de area de esanmblaje, donde se escuentra la carga de datos ademas de mostrar a lo sususario modelos y hace posible
     * el envio de una computadora ensamblada al aera de venta por medio de su estado
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
    
    if ("ensambladaslista".equals(view) && request.getAttribute("ensamblajeComputadoras") == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Ensamblaje_ComputadoraServlet");
        dispatcher.forward(request, response);
    }
    


    /*if ("informacionComponentes".equals(view) && request.getAttribute("piezas") == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/PiezasServlet");
        dispatcher.forward(request, response);
    }*/
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sección de Ensamblaje</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="flex h-screen bg-green-100">

        <!-- Sidebar -->
        <aside class="w-64 bg-green-800 text-white flex flex-col">
            <div class="p-5 text-xl font-bold border-b bg-green-700">
                Panel de Ensamblaje
            </div>
            <nav class="flex-1 p-4">
                <a href="../Administracion/Administracion.jsp" class="block px-4 py-2 rounded-lg hover:bg-green-700">Panel principal</a>
                <a href="../PiezaServlet" class="block px-4 py-2 rounded-lg hover:bg-green-700">Informacion Componentes</a>
                <a href="ensamblaje.jsp?view=ensambladaslista" class="block px-4 py-2 rounded-lg hover:bg-green-700">Informacion Computadoras</a>

                <a href="../Administracion/carga.jsp" class="block px-4 py-2 rounded-lg hover:bg-green-700">Ensamblar Computadora</a>
            </nav>
            <div class="p-4 border-t border-gray-700">
                <a href="index.jsp" class="block px-4 py-2 text-red-400 hover:bg-red-600 hover:text-white rounded-lg">
                    Cerrar sesión
                </a>
            </div>
        </aside>

        <!-- Contenido Principal -->
        <div class="flex-1 flex flex-col">

            <!-- Navbar -->
            <header class="bg-white shadow-md p-4 flex justify-between items-center">
                <h1 class="text-xl font-bold">Área de Ensamblaje</h1>
                <div class="flex items-center space-x-4">
                    <span class="text-purple-700"><%= user.getNombre()%></span>
                    <img src="https://via.placeholder.com/40" class="w-10 h-10 rounded-full border">
                </div>
            </header>

            <!-- Contenido -->
            <main class="flex-1 p-6">
                <div class="bg-white p-6 shadow rounded-lg text-center">
                    <h2 class="text-2xl font-bold mb-4">Bienvenido, <span class="text-blue-500"><%= user.getNombre()%></span></h2>
                    <p class="text-gray-600">Has ingresado al área de ensamblaje. Aquí podrás gestionar y supervisar los procesos de ensamblaje.</p>

                    <!-- Apartado de Manual -->
                    <% if ("manual".equals(view)) { %> 
                    <div class="mb-8">
                        <h3 class="text-xl font-bold mb-3">Manual de Ensamblaje</h3>
                        <p class="text-gray-600">El ensamblaje de computadoras consiste en unir diferentes componentes de hardware para formar un equipo funcional. Este proceso solo puede ser realizado
                            por usuarios que sean de tipo ensamblador o algun Administrador.
                            En este proceso, se deben seguir ciertos pasos para asegurar que el equipo funcione correctamente y tenga una buena durabilidad.</p>

                        <p class="text-gray-600">
                            En la empresa existen modelos de computadora que pueden ser creadas a patir de cirtas piezas, puedes encontrar los diferentes modelos en el apartado de -Modelos de Computadoras-.
                        </p>
                    </div>
                    <% }%>

                    <!-- Apartado de Manual -->
                    <% if ("modelos".equals(view)) { %> 
                    <div class="mb-8">
                        <h3 class="text-xl font-bold mb-3">Modelos de Computadoras</h3>
                        <p class="text-gray-600">Estos son algunos modelos de computadoras ensambladas, se muestran el numero de piezas utlizadas para crear el modelo y precio final a la venta</p>

                    </div>
                    <% }%>
                    
                    <!-- Consulta de Ensambladas -->
                    <% if ("ensambladaslista".equals(view)) { %> 
                    <div class="mb-8">
                        <h3 class="text-xl font-bold mb-3">Computadoras Ensambladas</h3>
                        

                    </div>
                    <% }%>

                    <!-- Consulta Componetes -->
                    <% if ("piezaslista".equals(view)) { %> 
                    <!-- Tabla de Componentes con Botones de Ordenación -->
                    <div class="mb-8">
                        <h3 class="text-xl font-bold mb-3">Lista de Componentes existentes</h3>
                        <table id="tablaPiezas" class="w-full bg-white border border-green-300 rounded-lg">
                            <thead class="bg-green-200">
                                <tr>
                                    <th class="p-2 border">Nombre</th>
                                    <th class="p-2 border">Costo</th>
                                    <th class="p-2 border">Cantidad</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="pieza" items="${piezas}">
                                    <tr class="hover:bg-gray-100">
                                        <td class="p-2 border">${pieza.nombre}</td>
                                        <td class="p-2 border">${pieza.costo}</td>
                                        <td class="p-2 border <c:if test="${pieza.cantidadDisponible <= 3}">text-red-500</c:if>">
                                            ${pieza.cantidadDisponible}
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>

                        <!-- Botones para ordenar -->
                        <div class="mt-4 flex justify-center gap-4">
                            <button onclick="ordenarTabla(true)" class="px-4 py-2 bg-blue-500 text-white rounded-lg hover:bg-blue-700">Ascendente</button>
                            <button onclick="ordenarTabla(false)" class="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-700">Descendente</button>
                        </div>
                    </div>

                    <!-- Script para ordenar la tabla -->
                    <script>
                        function ordenarTabla(ascendente) {
                            let tabla = document.getElementById("tablaPiezas");
                            let filas = Array.from(tabla.getElementsByTagName("tbody")[0].rows);

                            filas.sort((a, b) => {
                                let cantidadA = parseInt(a.cells[2].textContent);
                                let cantidadB = parseInt(b.cells[2].textContent);
                                return ascendente ? cantidadA - cantidadB : cantidadB - cantidadA;
                            });

                            let tbody = tabla.getElementsByTagName("tbody")[0];
                            filas.forEach(fila => tbody.appendChild(fila));
                        }
                    </script>

                    <% }%>
                </div>
            </main>

            <!-- Footer -->
            <footer class="bg-white text-center text-gray-600 p-4 border-t">
                &copy; 2025 Admin Panel. Todos los derechos reservados.
            </footer>

        </div>

    </body>
</html>
