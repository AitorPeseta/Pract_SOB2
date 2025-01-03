<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<c:forEach var="article" items="${articles}">
    <div class="article">
        <h3>${article.title}</h3>
        <p>${article.content}</p>
    </div>
</c:forEach>
