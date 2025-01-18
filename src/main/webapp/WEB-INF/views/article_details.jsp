<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blog Post</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            background: #ffffff;
            padding: 20px;
        }

        /* Foto principal */
        .image {
            text-align: center;
        }

        .image img.main-image {
            max-width: 100%;
            height: auto;
            width: 100%; /* Asegura que la imagen se ajuste a todo el ancho disponible */
            max-width: 200px; /* Tamaño máximo */
            height: 200px; /* Ajuste de alto */
            object-fit: cover; /* Mantiene la proporción de la imagen */
            border-radius: 10px;
        }

        /* Foto de perfil y de visitas pequeña */
        .article-username-left, .article-visits-left {
            object-fit: cover;
            border-radius: 50%;
        }

        .article-username-left {
            width: 25px;
            height: 25px; /* Puedes ajustar el tamaño según sea necesario */
        }

        .article-visits-left {
            width: 20px;
            height: 20px; /* Puedes ajustar el tamaño según sea necesario */
        }

        .author-info {
            display: flex;
            align-items: center;  /* Centra verticalmente */
            gap: 10px; /* Espacio entre la imagen y el nombre */
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .author-name {
            font-size: 1rem;
            
        }

        .title {
            text-align: center;
            font-size: 2rem;
            font-weight: bold;
            margin-top: 20px;
            margin-bottom: 10px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .meta {
            font-size: 0.9rem;
            color: #555555;
        }

        .meta .details {
            display: flex;
            flex-direction: column; /* Cambiado de "row" a "column" */
            gap: 5px;
        }

        .meta .details .right {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .topics {
            font-size: 0.9rem;
            color: #0073e6;
            text-align: right;
            display: flex;
            align-items: center;
            justify-content: flex-end;
        }

        .content {
            font-size: 1rem;
            color: #333333;
            line-height: 1.6;
            text-align: justify;
        }

        .info-row div {
            flex: 1;
        }

        /* Eliminamos la línea divisoria */
        .info-row .meta {
            padding-right: 10px;
            /* border-right: 1px solid #ddd;  Eliminamos esta línea */
        }

        .info-row .topics {
            padding-left: 10px;
        }
        
        .volver-btn {
            background-color: #2a6edf; /* Color azul */
            color: white;
            border: none;
            border-radius: 8px; /* Bordes redondeados */
            padding: 10px 20px; /* Espaciado interno */
            font-size: 16px; /* Tamaño del texto */
            font-weight: bold; /* Texto en negrita */
            cursor: pointer; /* Cambia el cursor al pasar por encima */
            text-align: center; /* Centrado del texto */
            position: absolute; /* Posicionamiento absoluto */
            right: 20px; /* Separación del lado derecho */
            bottom: 20px; /* Separación de la parte inferior */
        }
        
        .volver-btn:hover {
            background-color: #1a4fb8; /* Color más oscuro al pasar el ratón */
        }
        
        /* Barra de Login */
        .login-bar {
            width: 100%;
            background-color: #f8f9fa;
            padding: 10px;
            border-bottom: 1px solid #ddd;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .login-bar .login-text {
            font-size: 14px;
            color: #333;
            position: relative; /* o absolute, según el caso */
            left: 15px; /* A 50 píxeles de la izquierda */
        }

        .login-bar .login-buttons {
            display: flex;
            gap: 10px; /* Espaciado entre botones */
            position: relative; /* o absolute, según el caso */
            right: 15px; /* A 50 píxeles de la izquierda */
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
                    <form action="/Homework2/Web/Logout" method="post" style="margin: 0;">
                        <button type="submit" onclick="guardaPrevious()">Cerrar Sesión</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <form action="/Homework2/Web/Login" method="get" style="margin: 0;">
                        <button type="submit" onclick="guardaPrevious()">Iniciar Sesión</button>
                    </form>
                    <form action="/Homework2/Web/SignUp" method="get" style="margin: 0;">
                        <button type="submit" onclick="guardaPrevious()">Registrarse</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
    <div class="container">
        <div class="image">
            <!-- Imagen principal del artículo -->
            <img class="main-image" src="<c:url value="${article.featuredImageUrl}" />" />
        </div>

        <div class="title">
            ${article.title}
        </div>

        <div class="info-row">
            <!-- Columna izquierda: autor, vistas, fecha -->
            <div class="meta">
                <div class="details">
                    <div class="author-info">
                        
                            <img class="article-username-left" src="<c:url value="${article.author.perfil}" />" />
                        
                        <div class="author-name">
                            ${article.author.credenciales.username}
                        </div>
                    </div>
                    <div class="right">
                        <c:if test="${!article.isPublic}">
                            <img class="article-date-left" src="<c:url value="/resources/img/brillar-estrella.png" />" />
                        </c:if>
                        <img class="article-visits-left" src="<c:url value="/resources/img/foto.png" />" />
                        <span>${article.views}</span>
                        <span><fmt:formatDate value="${article.publishedDate}" pattern="MMM dd, yyyy" /></span>
                    </div>
                </div>
            </div>

            <!-- Columna derecha: tópicos -->
            <div class="topics">
                <c:forEach items="${article.topic}" var="item" varStatus="status">
                    ${item.name}<c:if test="${!status.last}">, </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="content"> 
            ${article.content}
        </div>
    </div>
    <div>
        <button class="volver-btn" onclick="goBackPages()">
        Volver
        </button>
    </div>
    <script>
        function goBackPages() {
            // Recuperamos la URL de la página anterior
            var previousPage = sessionStorage.getItem('previousPage');
            let path = new URL(sessionStorage.getItem('previousPage')).pathname;
            var numErrors = Number(${num_errors}); // Número de errores (puedes ajustar esta lógica según tu backend)
            var stepsBack = (numErrors > 0) ? -(2 + numErrors) : -2;

            // Si la URL existe, redirigimos al usuario a esa página
            if (previousPage) {
                        window.history.go(-1);
            }
            // Limpiar el valor de sessionStorage después de la redirección
            sessionStorage.removeItem('previousPage');
        }
    </script>
    <script>
        function guardaPrevious() {
            // Guardamos la URL actual de la página
            sessionStorage.setItem('previousPage', window.location.href);
            sessionStorage.setItem('privat', ${article.isPublic});
        }
    </script>
</body>
</html>