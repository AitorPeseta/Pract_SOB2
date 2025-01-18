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
    <link rel="stylesheet" href="../resources/css/styles.css">
    <link rel="stylesheet" href="../resources/css/stylesini.css">
    
    <style>
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


    </style>
    
</head>
<body>
    <script>
        // Recargar la página después de retroceder si es necesario
        if (sessionStorage.getItem('reloadAfterGoBack')) {
            sessionStorage.removeItem('reloadAfterGoBack');  // Limpiar la bandera
            setTimeout(() => {
                window.location.reload();  // Recargar después de una ligera pausa
            }, 300);  // Tiempo ajustable según necesidad
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

        }
    </script>
</body>
</html>
