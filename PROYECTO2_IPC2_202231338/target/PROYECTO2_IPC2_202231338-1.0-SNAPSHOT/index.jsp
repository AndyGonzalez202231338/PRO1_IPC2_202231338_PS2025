<%-- 
    Document   : index
    Created on : 1/03/2025, 16:29:37
    Author     : andy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="flex items-center justify-center min-h-screen bg-cover bg-center" style="background-image: url('https://source.unsplash.com/1600x900/?technology');">

    <div class="bg-white/20 backdrop-blur-lg p-8 rounded-2xl shadow-lg w-full max-w-md border border-black/30">
        <h2 class="text-3xl font-bold text-center text-black mb-6">Iniciar Sesión</h2>

        <form action="Administracion/Administracion.jsp" method="POST">
            <div class="mb-4">
                <label class="block text-black font-medium mb-2" for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" required
                       class="w-full px-4 py-2 bg-white/20 text-black border border-black/40 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 placeholder-blue/70"
                       placeholder="correo@ejemplo.com">
            </div>

            <div class="mb-4">
                <label class="block text-black font-medium mb-2" for="password">Contraseña</label>
                <input type="password" id="password" name="password" required
                       class="w-full px-4 py-2 bg-white/20 text-black border border-black/40 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 placeholder-blue/70"
                       placeholder="••••••••">
            </div>

            <div class="flex justify-between items-center mb-4">
                <label class="flex items-center text-black">
                    <input type="checkbox" class="mr-2 accent-blue-500">
                    <span class="text-sm">Recordarme</span>
                </label>
                <a href="Administracion.jsp" class="text-sm text-blue-500 hover:underline">¿Olvidaste tu contraseña?</a>
            </div>

            <button type="submit"
                    class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 rounded-lg transition-all shadow-lg">
                Iniciar Sesión
            </button>
        </form>
    </div>

</body>
</html>
