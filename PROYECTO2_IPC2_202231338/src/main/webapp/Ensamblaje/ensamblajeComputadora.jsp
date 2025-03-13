<%-- 
    Document   : ensamblajeComputadora
    Created on : 10/03/2025, 00:47:04
    Author     : andy
--%>
<%@page import="model.Ensamblaje_Computadora"%>
<%@page import="model.Usuario"%>
<%@page import="model.Pieza"%>
<%@page import="java.util.List"%>

<%
    /**
     * mustra las computadora ensambladas y las describe
     */
    System.out.println("estas en piezas.jsp");
    List<Ensamblaje_Computadora> computadoras = (List<Ensamblaje_Computadora>) request.getAttribute("ensamblajeComputadoras");
    System.out.println("se han extraido las piezas");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Coomputadoras Ensambladas</title>
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
                <a href="../Ensamblaje/ensamblaje.jsp" class="block px-4 py-2 rounded-lg hover:bg-green-700">Regresar</a>
            </nav>
            <div class="p-4 border-t border-gray-700">
                <a href="index.jsp" class="block px-4 py-2 text-red-500 hover:bg-red-800 hover:text-white rounded-lg">
                    Cerrar sesión
                </a>
            </div>
        </aside>

        <!-- Contenido Principal -->
        <div class="flex-1 container mx-auto p-6">
            <h1 class="text-2xl font-bold mb-4">Computadoras Ensambladas</h1>

            <!-- Tabla de Piezas -->
            <table class="min-w-full bg-white border rounded-lg overflow-hidden">
                <thead class="bg-green-800 text-white">
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
                    <% for (Ensamblaje_Computadora computadora : computadoras) {%>
                    <tr class="border-b">
                        <td class="px-24 py-2"><%=   computadora.getID()%></td>
                        <td class="px-24 py-2"><%=   computadora.getID_Computadora()%></td>
                        <td class="px-24 py-2"><%=   computadora.getNombreUsuario()%></td>
                        <td class="px-24 py-2"><%=   computadora.getFechaEnsamblaje()%></td>
                        <td class="px-24 py-2">$<%=  computadora.getCostoTotal()%></td>
                        <td class="px-24 py-2">
                            <% if ("Ensamblada".equals(computadora.getEstado())) {%>
                            <form action="/PROYECTO2_IPC2_202231338/Ensamblaje_ComputadoraServlet" method="POST">
                                <input type="hidden" name="action" value="enviarAVentas">
                                <input type="hidden" name="id" value="<%= computadora.getID()%>">
                                <button type="submit" class="bg-green-500 text-white px-4 py-2 rounded-lg">
                                    Enviar a Ventas
                                </button>
                            </form>
                            <% } else { %>
                            <span class="text-gray-500">En Venta</span>
                            <% } %>
                        </td>
                        <td class="px-24 py-2 flex space-x-2">
                    </tr>

                    <% } %>
                    <% }%>
                </tbody>
            </table>

            <!-- Botones para ordenar -->
            <div class="mt-4 flex space-x-2">
                <button onclick="ordenarComputadoras(true)" class="bg-blue-500 text-white px-4 py-2 rounded-lg">Ordenar por Fecha Ascendente</button>
                <button onclick="ordenarComputadoras(false)" class="bg-blue-500 text-white px-4 py-2 rounded-lg">Ordenar por Fecha Descendente</button>
            </div>

            <!-- Formulario para agregar piezas -->
            <h2 class="text-xl font-bold mt-6">Ensamblar una computadora</h2>
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
            function ordenarComputadoras(ascendente) {
                let tbody = document.getElementById("computadoras-body");
                let filas = Array.from(tbody.querySelectorAll("tr"));

                filas.sort((a, b) => {
                    let fechaA = new Date(a.cells[3].innerText.trim()); // Cambiado a cells[3]
                    let fechaB = new Date(b.cells[3].innerText.trim()); // Cambiado a cells[3]
                    return ascendente ? fechaA - fechaB : fechaB - fechaA;
                });

                tbody.innerHTML = "";
                filas.forEach(fila => tbody.appendChild(fila));
            }
        </script>



    </body>
</html>

