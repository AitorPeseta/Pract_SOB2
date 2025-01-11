<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Sign Up</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

<!-- FontAwesome -->
    <link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
          rel="stylesheet"
          integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
          crossorigin="anonymous"/>

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
        
        .submit-btn input[type="submit"] {
            background-color: #007bff; /* Azul */
            color: white; /* Texto en blanco */
            border: none; /* Sin borde */
            padding: 5px 10px; /* Tamaño del botón */
            border-radius: 5px; /* Bordes redondeados opcionales */
            cursor: pointer; /* Manita al pasar el cursor */
            font-size: 16px; /* Tamaño del texto */
            margin-left: 175px; /* Separación desde la izquierda */
        }

        /* Opcional: Cambiar color al pasar el cursor */
        .submit-btn input[type="submit"]:hover {
            background-color: #0056b3; /* Azul más oscuro */
        }
        
</style>

</head>
<body>
	<div class="container">
		<div class="col-md-offset-2 col-md-7">
			<h2 class="text-center">Registre a l'aplicació</h2>
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Sign Up</div>
				</div>
				<div class="panel-body">
					<form action="${mvc.uri('sign-up')}" class="form-horizontal" method="POST">
                                                <input type="hidden" name="${mvc.csrf.name}" value="${mvc.csrf.token}"/>
						<div class="form-group">
							<label for="email" class="col-md-3 control-label">Email</label>
							<div class="col-md-9">
                                                            <input type="text" name="email" value="${user.email}" class="form-control" />
							</div>
						</div>
                                                <div class="form-group">
							<label for="username" class="col-md-3 control-label">Username</label>
							<div class="col-md-9">
                                                            <input type="text" name="username" value="${user.credenciales.username}" class="form-control" />
							</div>
						</div>
                                                <div class="form-group">
                                                        <label for="password" class="col-md-3 control-label">Password</label>
                                                        <div class="col-md-9">
                                                            <input type="password" name="password" value="${user.credenciales.password}" class="form-control" />
                                                        </div>
						</div>
						<div class="form-group">
							<!-- Button -->
							<div class="submit-btn">
								<input type="submit" value="Submit" />
							</div>
						</div>
					</form>
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-danger" role="alert">
                                                ${message}        
                                            </div>
                                        </c:if>
                                        <c:if test="${attempts.hasExceededMaxAttempts()}">
                                            <div id="too-many-signup-attempts" class="modal top fade" role="alert" tabindex="-1" data-mdb-backdrop="static" data-mdb-keyboard="true">
                                                <div class="modal-dialog">
                                                    <div class="modal-content">
                                                            <div class="modal-header">
                                                                <h2 class="modal-title" id="too-many-signup-attempts">Please try again later.</h2>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="alert alert-danger" role="alert">
                                                                   <img class="mb-4" src="<c:url value="/resources/img/Invalid.png" />" alt="" width="134" height="92" />
                                                                        The maximum number of sign up attempts has been exceeded!
                                                                </div>
                                                             </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <script>
                                                $("#too-many-signup-attempts").modal('show');
                                            </script>
                                        </c:if>
                                        <jsp:include page="/WEB-INF/views/layout/alert.jsp" />
                                </div>
			</div>
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
                let path = new URL(sessionStorage.getItem('previousPage')).pathname;
                var numErrors = Number(${num_errors}); // Número de errores (puedes ajustar esta lógica según tu backend)
                var stepsBack = (numErrors > 0) ? -(1 + numErrors) : -1;

                // Si la URL existe, redirigimos al usuario a esa página
                if (previousPage) {
                    if(path === "/Homework2/Web/Articles")
                        window.location.href = previousPage;
                    else{
                        // Retroceder en el historial
                        window.history.go(stepsBack);
                    }
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
