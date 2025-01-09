<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Sign Up Success - SOB</title>
<link href="<c:url value="/resources/css/bootstrap.min.css" />"
    rel="stylesheet">
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

<style>
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
        
</style>

</head>
<body>
    <div class="container">
        <div class="col-md-offset-2 col-md-7">
            <h1>Gràcies per registrar-te!</h1>
            <hr />
                        <p class="text-md-start">
                            Ara pots gaudir dels nostres articles més famosos, i dels articles privats!
                        </p>
            <table class="table table-striped table-bordered">
                <tr>
                    <td><b>Username </b>: ${user.credenciales.username}</td>
                </tr>
                <tr>
                    <td><b>Email </b>: ${user.email}</td>
                </tr>
            </table>
        </div>
    </div>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
        <div>
            <button class="volver-btn" onclick="goBack()">
                    Volver
            </button>
        </div>

        <script>
            function goBack() {
                // Recuperamos la URL de la página anterior
                var previousPage = sessionStorage.getItem('previousPage');

                // Si la URL existe, redirigimos al usuario a esa página
                if (previousPage) {
                    window.location.href = previousPage;
                } else {
                    // Si no hay página anterior, redirigimos al home o a una página por defecto
                    window.location.href = "/Homework2/Web/Articles"; // O la URL que desees
                }

                // Limpiar el valor de sessionStorage después de la redirección
                sessionStorage.removeItem('previousPage');
            }
        </script>
</body>
</html>