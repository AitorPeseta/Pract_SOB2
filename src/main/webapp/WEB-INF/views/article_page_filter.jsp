<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:formatDate value="${article.publishedDate}" pattern="MMMM dd" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artículos Recientes</title>
    <style>

        /* Aplica a todos los enlaces que contengan elementos con clase "article-title" */
        a {
            text-decoration: none; /* Elimina el subrayado de todos los enlaces */
            color: inherit; /* Usa el color del texto del contenedor */
        }


        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 80%;
            margin: auto;
        }

        header {
            text-align: center;
            padding: 20px 0;
        }

        header h1 {
            font-size: 2.5em;
            color: #343a40;
        }

        .article-details {
            flex: 1;
        }

        .article-card {
            display: flex;
            flex-direction: row;
            background: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin: 20px 0;
            padding: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .article-left {
            flex: 3;
            padding-right: 15px;
        }

        .article-right {
            flex: 1;
            display: flex;
            align-items: center; 
            justify-content: center; 
        }

        .article-image {
            width: 120px;
            height: 120px;
            object-fit: cover;
        }

        .article-header {
            display: flex;
            flex-direction: column;
            flex: 1; 
            margin-right: 15px;
        }

        .article-title {
            font-size: 1.5em;
            margin: 0;
            color: #212529;
            margin-bottom: 5px;
        }

        /* Opcional: Cambia el color al pasar el mouse */
        a:hover {
            color: #3498db; /* Cambia el color cuando pases el mouse */
            text-decoration: none; /* Asegúrate de que no reaparezca el subrayado */
        }

        /* Si quieres aplicar específicamente solo a los títulos */
        a .article-title {
            text-decoration: none; /* Elimina el subrayado del texto del título */
            color: inherit; /* Asegúrate de que hereda el color */
        }

        /* Al pasar el mouse por el título */
        a:hover .article-title {
            color: #3498db; /* Cambia el color al pasar el mouse */
            text-decoration: none; /* Sin subrayado */
        }

        .article-meta {
            font-size: 0.9em;
            color: #6c757d;
            margin-bottom: 10px;
            padding: 4px;
        }

        .article-visits {
            font-size: 0.9em;
            color: #6c757d;
            margin-left: 2px; 
        }

        .article-visits-left{
            width: 24px;
            height: 24px;
            object-fit: cover;
            border-radius: 50%;
            padding:10px;
        }

        .article-content {
            font-size: 1em;
            color: #495057;
            margin: 0;
            margin-top: 10px; 
        }

        .element-left,
        .element-right {
            display: flex;
            align-items: center; 
        }

        .element-left {
            margin-right: 10px;
            font-size: 0.9em; 
            color: #495057;
        }

        .article-username-left {
            width: 24px;
            height: 24px;
            object-fit: cover;
            border-radius: 50%;
            padding:6px;
        }

        footer {
            text-align: center;
            padding: 15px 0;
            background: #343a40;
            color: #fff;
            margin-top: 20px;
        }
        
        .content-wrapper {
            display: flex; /* Distribuye los elementos en fila */
            flex-direction: row; /* Coloca los elementos horizontalmente */
            gap: 20px; /* Espacio entre el filtro y los artículos */
            align-items: flex-start; /* Evita que el filtro se estire verticalmente */
        }

        .container .filter-container {
            flex: 0 0 auto; /* Evita estiramiento innecesario */
            background-color: #f9f9f9;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            min-height: auto; 
        }

        /* Encabezado del filtro */
        .filter-container h2 {
            font-size: 1em;
            margin-bottom: 12px;
            color: #333;
            text-align: center;
        }

        /* Sección dentro del filtro */
        .filter-section {
            margin-bottom: 15px;
        }

        /* Títulos de las secciones */
        .filter-section h3 {
            font-size: 0.8em;
            margin-bottom: 10px;
            color: #555;
        }

        /* Estilo para las opciones de tópicos */
        .filter-section div {
            margin-bottom: 10px;
        }

        .filter-section input[type="checkbox"] {
            margin-right: 10px;
        }

        /* Estilo para el input del autor */
        .filter-section input[type="text"] {
            width: 100%; /* Ocupa todo el ancho del contenedor */
            padding: 10px;
            font-size: 1em;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box; /* Ajusta el padding sin afectar el ancho */
        }

        /* Botón de aplicar filtros */
        .filter-container button {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            background-color: #007BFF;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .filter-container button:hover {
            background-color: #0056b3;
        }

        /* Barra de Login */
        .login-bar {
            background-color: #f8f9fa;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between; /* Divide espacio entre el texto y los botones */
            align-items: center;
            font-family: Arial, sans-serif; /* Cambiar fuente */
        }

        .login-bar .login-text {
            font-size: 14px;
            color: #333;
        }

        .login-bar .login-buttons {
            display: flex;
            gap: 10px; /* Espaciado entre botones */
        }

        .login-bar button {
            padding: 5px 10px;
            font-family: Arial, sans-serif; /* Fuente consistente */
            font-size: 14px;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .login-bar button:hover {
            background-color: #0056b3;
        }

        /* Título principal */
        h1 {
            margin-top: 20px;
            text-align: center;
            font-family: Arial, sans-serif;
        }
        
        /* Estilo para las opciones de tópicos */
        .volver-btn {
            margin-top: 10px;
        }

    </style>
    
</head>
<body>
    <script>
         // Verifica la bandera
            if (sessionStorage.getItem('reloadAfterGoBack')) {
                sessionStorage.removeItem('reloadAfterGoBack'); // Limpia la bandera
                window.location.reload(); // Recarga la página actual
            }
    </script>
    <div class="login-bar">
        <!-- Texto de la izquierda -->
        <div class="login-text">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    Bienvenido, ${sessionScope.username}
                </c:when>
                <c:otherwise>
                    No has iniciado sesión.
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Botones de la derecha -->
        <div class="login-buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.username}">
                    <form action="/Pract_SOB2/Web/Logout" method="post" style="margin: 0;">
                        <button type="submit" onclick="guardaPrevious()">Cerrar Sesión</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <form action="/Pract_SOB2/Web/Login" method="get" style="margin: 0;">
                        <button type="submit" onclick="guardaPrevious()">Iniciar Sesión</button>
                    </form>
                    <form action="/Pract_SOB2/Web/SignUp" method="get" style="margin: 0;">
                        <button type="submit" onclick="guardaPrevious()">Registrarse</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="container">
        <header>
            <h1>Artículos Recientes</h1>
        </header>
        <div class="content-wrapper">
            <!-- Contenedor de filtraje -->
            <aside class="filter-container">
                <h2>Filtrar</h2>
                <form action="/Pract_SOB2/Web/Articles/article-filter" method="POST">
                    <!-- Filtro por tópicos -->
                    <div class="filter-section">
                        <h3>Tópicos</h3>
                        <c:forEach var="topic" items="${uniqueTopics}">
                            <div>
                                <input type="checkbox" id="topic-${topic.id}" name="topics" value="${topic.id}" />
                                <label for="topic-${topic.id}">${topic.name}</label>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Filtro por autor -->
                    <div class="filter-section">
                        <h3>Autor</h3>
                        <input type="text" name="author" placeholder="Nombre del autor" />
                    </div>

                    <button type="submit">Aplicar Filtros</button>
                </form>
                <button class="volver-btn" onclick="location.href='/Pract_SOB2/Web/Articles'">
                    Quitar Filtros
                </button>
            </aside>

            <!-- Contenedor de artículos -->
            <main class="articles-container">
                <c:forEach items="${articles}" var="article">
                    <div class="article-card">
                        <!-- Sección izquierda -->
                        <div class="article-left">
                            <div class="element-left">
                                <img class="article-username-left" src="<c:url value="${article.author.perfil}" />" />
                                <p class="article-username-right">${article.author.credenciales.username}</p>
                            </div>
                            <div class="article-details">
                                
                                <form action="/Pract_SOB2/Web/Articles/article-details" class="form-horizontal" method="POST">
                                    <input type="hidden" name="id" value="${article.id}" />
                                    <div class="article-title" style="cursor: pointer;" onclick="guardaPrevious(); this.closest('form').submit();">
                                        ${article.title}
                                    </div>
                                </form>
                                
                                <p class="article-content">${article.summary}</p>
                                <div class="element-left">
                                    <c:if test="${!article.isPublic}">
                                        <img class="article-date-left" src="<c:url value="/resources/img/brillar-estrella.png" />" />
                                    </c:if>
                                    <p class="article-meta"> <fmt:formatDate value="${article.publishedDate}" pattern="MMM dd" /></p>
                                    <img class="article-visits-left" src="<c:url value="/resources/img/foto.png" />" />
                                    <span class="article-visits"> ${article.views} </span>
                                </div>
                            </div>
                        </div>
                        <!-- Sección derecha -->
                        <div class="article-right">
                            <img class="article-image" src="<c:url value="${article.featuredImageUrl}" />" alt="" width="134" height="92" />
                        </div>
                    </div>
                </c:forEach>
            </main>
        </div>
        <footer>
            <p>&copy; 2025 Aitor&Xavi</p>
        </footer>
    </div>
    <script>
        function guardaPrevious() {
            // Guardamos la URL actual de la página
            sessionStorage.setItem('previousPage', window.location.href);
            sessionStorage.setItem('previousPage2', window.location.href);

        }
    </script>
</body>
</html>
