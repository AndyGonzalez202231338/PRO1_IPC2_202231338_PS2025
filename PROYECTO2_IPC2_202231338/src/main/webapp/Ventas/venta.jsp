<%-- 
    Document   : venta
    Created on : 9/03/2025, 00:42:48
    Author     : andy
--%>
<%@page import="java.util.List"%>
<%@page import="model.Usuario"%>
<%@page import="model.Ensamblaje_Computadora"%>

<%
    String view = request.getParameter("view");

    Usuario user = (Usuario) session.getAttribute("user");
    if (user == null || (user.getRoleId() != 2 && user.getRoleId() != 3)) {
        response.sendRedirect("venta_login.jsp");
        return;
    }

    if ("computadoraslista".equals(view) && request.getAttribute("ensamblajeComputadoras") == null) {
        RequestDispatcher dispatcher = request.getRequestDispatcher("/Ensamblaje_ComputadoraServlet");
        dispatcher.forward(request, response);
    }

    List<Ensamblaje_Computadora> computadoras = (List<Ensamblaje_Computadora>) request.getAttribute("ensamblajeComputadoras");

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Sección de Ventas</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="flex h-screen bg-red-100">

        <!-- Sidebar -->
        <aside class="w-64 bg-red-800 text-white flex flex-col">
            <div class="p-5 text-xl font-bold border-b bg-red-700">
                Panel de Ventas
            </div>
            <nav class="flex-1 p-4">
                <a href="../Administracion/Administracion.jsp" class="block px-4 py-2 rounded-lg hover:bg-red-700">Panel administración</a>
                <a href="venta.jsp?view=computadoraslista" class="block px-4 py-2 rounded-lg hover:bg-red-700">Realizar Ventas</a> 
                
                <a href="#" class="block px-4 py-2 rounded-lg hover:bg-red-700">Realizar Devolucion</a>
                <a href="#" class="block px-4 py-2 rounded-lg hover:bg-red-700">Consultar Ventas</a>
                <a href="#" class="block px-4 py-2 rounded-lg hover:bg-red-700">Consultar Devoluciones</a>
                <a href="#" class="block px-4 py-2 rounded-lg hover:bg-red-700">Detalles de Facturas</a>
            </nav>
            <div class="p-4 border-t border-gray-700">
                <a href="index.jsp" class="block px-4 py-2 text-white-400 hover:bg-red-600 hover:text-white rounded-lg">
                    Cerrar sesión
                </a>
            </div>
        </aside>

        <!-- Contenido Principal -->
        <div class="flex-1 flex flex-col">

            <!-- Navbar -->
            <header class="bg-white shadow-md p-4 flex justify-between items-center">
                <h1 class="text-xl font-bold">Área de Ventas</h1>
                <div class="flex items-center space-x-4">
                    <span class="text-purple-700"><%= user.getNombre()%></span>
                    <img src="https://via.placeholder.com/40" class="w-10 h-10 rounded-full border">
                </div>
            </header>

            <!-- Contenido Principal -->
            <main class="flex-1 p-6">
                <div class="bg-white p-6 shadow rounded-lg text-center">
                    <h2 class="text-2xl font-bold mb-4">Bienvenido, <span class="text-blue-500"><%= user.getNombre()%></span></h2>
                    <p class="text-red-600">Has ingresado al área de Ventas. Aquí podrás gestionar y supervisar las ventas y devoluciones de las computadoras ensambladas.</p>
                </div>

                <!-- Tabla de Computadora Esnambladas -->
                <% if ("computadoraslista".equals(view)) { %> 
                <div class="bg-white p-6 shadow rounded-lg text-center">
                    <h3 class="text-xl font-bold mb-3">Lista de Computadora Autorizadas para Venta</h3>
                    <table class="min-w-full bg-white border rounded-lg overflow-hidden">
                        <thead class="bg-red-800 text-white">
                            <tr>
                                <th class="px-4 py-2">Identificador</th>
                                <th class="px-4 py-2">Modelo</th>
                                <th class="px-4 py-2">Nombre del Ensamblador</th>
                                <th class="px-4 py-2">Fecha de Ensamblaje</th>
                                <th class="px-4 py-2">Costo Total</th>
                                <th class="px-4 py-2">Realizar Acciones</th>
                            </tr>
                        </thead>

                        <tbody id="computadoras-body">
                            <% if (computadoras != null) { %>
                            <% for (Ensamblaje_Computadora computadora : computadoras) { %>
                            <% if ("En Venta".equals(computadora.getEstado())) {%>
                            <tr class="border-b">
                                <td class="px-24 py-2"><%= computadora.getID()%></td>
                                <td class="px-24 py-2"><%= computadora.getID_Computadora()%></td>
                                <td class="px-24 py-2"><%= computadora.getNombreUsuario()%></td>
                                <td class="px-24 py-2"><%= computadora.getFechaEnsamblaje()%></td>
                                <td class="px-24 py-2">$<%= computadora.getCostoTotal()%></td>
                                <td class="px-24 py-2 text-gray-500">En Venta</td>
                            </tr>
                            <% } %>
                            <% } %>
                            <% } %>
                        </tbody>

                    </table>
                </div>
                        
                <!-- Formulario para realizar una venta -->
    <div class="bg-white p-6 shadow rounded-lg text-center mt-6">
        <h3 class="text-xl font-bold mb-3">Realizar Venta</h3>
        <form action="../RegistrarVentaServlet" method="post">
            <input type="hidden" name="action" value="realizarVenta">

            <!-- Seleccionar Computadora -->
            <div class="mb-4">
                <label class="block text-gray-700">Seleccionar Computadora</label>
                <select name="idComputadora" required class="w-full p-2 border rounded-lg">
                    <option value="">Seleccione una computadora</option>
                    <% if (computadoras != null) { %>
                    <% for (Ensamblaje_Computadora computadora : computadoras) { %>
                    <% if ("En Venta".equals(computadora.getEstado())) { %>
                    <option value="<%= computadora.getID() %>">
                        ID: <%= computadora.getID() %> - Modelo: <%= computadora.getID_Computadora() %>
                    </option>
                    <% } %>
                    <% } %>
                    <% } %>
                </select>
            </div>

            <!-- Datos del Cliente -->
            <div class="mb-4">
                <label class="block text-gray-700">NIT</label>
                <input type="text" name="nit" required class="w-full border px-4 py-2 rounded-lg">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700">Nombre del Cliente</label>
                <input type="text" name="nombreCliente" required class="w-full border px-4 py-2 rounded-lg">
            </div>
            
            <div class="mb-4">
                <label class="block text-gray-700">Direccion</label>
                <input type="text" name="direccion" required class="w-full border px-4 py-2 rounded-lg">
            </div>

            <!-- Botón de Enviar -->
            <button type="submit" class="px-6 py-2 bg-red-800 text-white rounded-lg hover:bg-red-700">
                Confirmar Venta
            </button>
        </form>
    </div>
                <% }%>

                
            </main>

            <!-- Footer (Fijo abajo) -->
            <footer class="bg-white text-center text-red-600 p-4 border-t w-full">
                &copy; 2025 Admin Panel. Todos los derechos reservados.
            </footer>

        </div>

    </body>

</html>

