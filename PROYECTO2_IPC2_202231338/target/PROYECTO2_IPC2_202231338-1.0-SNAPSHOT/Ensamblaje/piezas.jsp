<%-- 
    Document   : piezas
    Created on : 6/03/2025, 17:01:57
    Author     : andy
--%>
<%@page import="model.Usuario"%>
<%@page import="model.Pieza"%>
<%@page import="java.util.List"%>

<%
    System.out.println("estas en piezas.jsp");
    List<Pieza> piezas = (List<Pieza>) request.getAttribute("piezas");
    System.out.println("se han extraido las piezas");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Piezas Disponibles</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </head>
    <body class="bg-green-100 flex">

        <!-- Sidebar -->
        <aside class="w-64 h-screen bg-green-800 text-white flex flex-col">
            <div class="p-5 text-xl font-bold border-b border-green-700">
                Panel de Ensamblaje
            </div>
            <nav class="flex-1 p-4">
                <a href="Ensamblaje/ensamblaje.jsp" class="block px-4 py-2 rounded-lg hover:bg-green-700">Regresar</a>
            </nav>
            <div class="p-4 border-t border-gray-700">
                <a href="index.jsp" class="block px-4 py-2 text-red-500 hover:bg-red-800 hover:text-white rounded-lg">
                    Cerrar sesión
                </a>
            </div>
        </aside>

        <!-- Contenido Principal -->
        <div class="flex-1 container mx-auto p-6">
            <h1 class="text-2xl font-bold mb-4">Piezas Disponibles</h1>

            <!-- Tabla de Piezas -->
            <table class="min-w-full bg-white border rounded-lg overflow-hidden">
                <thead class="bg-green-800 text-white">
                    <tr>
                        <th class="px-4 py-2">ID</th>
                        <th class="px-4 py-2">Nombre</th>
                        <th class="px-4 py-2">Costo</th>
                        <th class="px-4 py-2">Cantidad</th>
                        <th class="px-4 py-2">Acciones</th>
                    </tr>
                </thead>
                <tbody id="piezas-body">
                    <% if (piezas != null) { %>
                    <% for (Pieza pieza : piezas) {
                        String cantidadClase = pieza.getCantidadDisponible() <= 3 ? "text-red-500 font-bold" : ""; %>
                    <tr class="border-b">
                        <td class="px-4 py-2"><%= pieza.getID()%></td>
                        <td class="px-4 py-2"><%= pieza.getNombre()%></td>
                        <td class="px-4 py-2">$<%= pieza.getCosto()%></td>
                        <td class="px-4 py-2 <%= cantidadClase %>"><%= pieza.getCantidadDisponible()%></td>
                        <td class="px-4 py-2 flex space-x-2">
                            <!-- Botón Editar -->
                            <a href="Ensamblaje/editar_pieza.jsp?id=<%= pieza.getID()%>" class="bg-yellow-500 text-white px-3 py-1 rounded-lg">Editar</a>

                            <!-- Botón Eliminar con confirmación -->
                            <a href="PiezaServlet?accion=eliminar&id=<%= pieza.getID()%>" 
                               class="bg-red-500 text-white px-3 py-1 rounded-lg"
                               onclick="return confirm('¿Estás seguro de que deseas eliminar esta pieza?');">
                                Eliminar
                            </a>
                        </td>
                    </tr>
                    <% } %>
                    <% }%>
                </tbody>
            </table>

            <!-- Botones para ordenar -->
            <div class="mt-4 flex space-x-2">
                <button onclick="ordenarPiezas(true)" class="bg-blue-500 text-white px-4 py-2 rounded-lg">Ordenar Ascendente</button>
                <button onclick="ordenarPiezas(false)" class="bg-blue-500 text-white px-4 py-2 rounded-lg">Ordenar Descendente</button>
            </div>

            <!-- Formulario para agregar piezas -->
            <h2 class="text-xl font-bold mt-6">Agregar Nueva Pieza</h2>
            <form action="PiezaServlet" method="POST" class="bg-white p-6 rounded-lg shadow-md mt-4">
                <div class="mb-4">
                    <label class="block text-green-700">Nombre:</label>
                    <input type="text" name="nombre" required class="w-full border px-4 py-2 rounded-lg">
                </div>
                <div class="mb-4">
                    <label class="block text-green-700">Costo:</label>
                    <input type="number" step="0.01" name="costo" required class="w-full border px-4 py-2 rounded-lg">
                </div>
                <div class="mb-4">
                    <label class="block text-green-700">Cantidad:</label>
                    <input type="number" name="cantidad" required class="w-full border px-4 py-2 rounded-lg">
                </div>
                <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded-lg">Agregar Pieza</button>
            </form>
        </div>
                
        <script>
            function ordenarPiezas(ascendente) {
                let tbody = document.getElementById("piezas-body");
                let filas = Array.from(tbody.querySelectorAll("tr"));

                filas.sort((a, b) => {
                    let cantidadA = parseInt(a.cells[3].innerText);
                    let cantidadB = parseInt(b.cells[3].innerText);
                    return ascendente ? cantidadA - cantidadB : cantidadB - cantidadA;
                });

                tbody.innerHTML = "";
                filas.forEach(fila => tbody.appendChild(fila));
            }

            // SweetAlert para mensajes de éxito
            const params = new URLSearchParams(window.location.search);
            if (params.has("success")) {
                Swal.fire({
                    title: "¡Éxito!",
                    text: params.get("success"),
                    icon: "success",
                    confirmButtonText: "OK"
                });
            }
        </script>

    </body>
</html>
