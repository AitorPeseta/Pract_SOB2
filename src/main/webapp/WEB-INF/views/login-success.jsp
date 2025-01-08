<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login Success</title>
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
            <h1>Benvingut! ${customer.credenciales.username}</h1>
            <hr />
                        <p class="text-md-start">
                            Ara pots gaudir dels nostres articles mes famosos, i dels articles privats!
                        </p>
            <table class="table table-striped table-bordered">
                <tr>
                    <td><b>First Name </b>: ${customer.credenciales.username}</td>
                </tr>
                <tr>
                    <td><b>Email </b>: ${customer.email}</td>
                </tr>
            </table>
        </div>
    </div>
        <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
        <div>
            <button class="volver-btn" onclick="location.href='/Homework2/Web/Articles'">
            Volver
            </button>
        </div>
</body>
</html>
