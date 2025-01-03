<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
</head>
<body>
    <jsp:include page="/login_bar.jsp" />
    <div class="container">
        <header>
            <h1>Artículos Recientes</h1>
        </header>
        <main>
            <c:forEach items="${articles}" var="article">
                <div class="article-card">
                    <!-- Sección izquierda -->
                    <div class="article-left">
                        <div class="element-left">
                            <img class="article-username-left" src="<c:url value="/resources/img/ETSEcentrat.png" />" />
                            <p class="article-username-right">${article.author.credenciales.username}</p>
                        </div>
                        <div class="article-details">
                            <h2 class="article-title">${article.title}</h2>
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
                        <img class="article-image" src="<c:url value="/resources/img/ETSEcentrat.png" />" alt="" width="134" height="92" />
                    </div>
                </div>
            </c:forEach>
        </main>
        <footer>
            <p>&copy; 2025 Aitor&Xavi</p>
        </footer>
    </div>
</body>
</html>