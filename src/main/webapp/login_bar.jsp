<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
    <link rel="stylesheet" href="resources/css/stylesini.css">
</head>
<body>
    <!-- Barra de Login -->
    <div class="login-bar">
        <!-- Texto de la izquierda -->
        <div class="login-text">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    Bienvenido ${sessionScope.user.username}!
                </c:when>
                <c:otherwise>
                    No has iniciado sesión.
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Botones de la derecha -->
        <div class="login-buttons">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <form action="/Homework2/Web/Logout" method="post" style="margin: 0;">
                        <button type="submit">Cerrar Sesión</button>
                    </form>
                </c:when>
                <c:otherwise>
                    <form action="/Homework2/Web/Login" method="get" style="margin: 0;">
                        <button type="submit" >Iniciar Sesión</button>
                    </form>
                    <form action="/Homework2/Web/SignUp" method="get" style="margin: 0;">
                        <button type="submit" >Registrarse</button>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

</body>
</html>