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
            font-size: 16px; /* Tama�o del texto */
            font-weight: bold; /* Texto en negrita */
            cursor: pointer; /* Cambia el cursor al pasar por encima */
            text-align: center; /* Centrado del texto */
            position: absolute; /* Posicionamiento absoluto */
            right: 20px; /* Separaci�n del lado derecho */
            bottom: 20px; /* Separaci�n de la parte inferior */
        }
        
        .volver-btn:hover {
            background-color: #1a4fb8; /* Color m�s oscuro al pasar el rat�n */
        }
        
</style>

</head>
<body>
    <div class="container">
        <div class="col-md-offset-2 col-md-7">
            <h1>Gr�cies per registrar-te!</h1>
            <hr />
                        <p class="text-md-start">
                            Ara pots gaudir dels nostres articles m�s famosos, i dels articles privats!
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
                // Recuperamos la URL de la p�gina anterior
                var previousPage = sessionStorage.getItem('previousPage');

                // Si la URL existe, redirigimos al usuario a esa p�gina
                if (previousPage) {
                    window.location.href = previousPage;
                } else {
                    // Si no hay p�gina anterior, redirigimos al home o a una p�gina por defecto
                    window.location.href = "/Homework2/Web/Articles"; // O la URL que desees
                }

                // Limpiar el valor de sessionStorage despu�s de la redirecci�n
                sessionStorage.removeItem('previousPage');
            }
        </script>
</body>
</html>