<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="es_ES" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>

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
        
</style>
</head>
<body>
	<div class="container">
		<div class="col-md-offset-2 col-md-7">
			<h2 class="text-center">Iniciar Sesion</h2>
			<div class="panel panel-info">
				<div class="panel-heading">
					<div class="panel-title">Login</div>
				</div>
				<div class="panel-body">
					<form action="${mvc.uri('log-in')}" class="form-horizontal" method="POST">
                                            <input type="hidden" name="${mvc.csrf.name}" value="${mvc.csrf.token}" />

                                            <!-- Campo para el nombre de usuario -->
                                            <div class="form-group">
                                                <label for="username" class="col-md-3 control-label">Nom d'usuari</label>
                                                <div class="col-md-9">
                                                    <input type="text" id="username" name="credenciales.username" 
                                                           value="${credenciales.username}" class="form-control" required />
                                                </div>
                                            </div>

                                            <!-- Campo para la contraseña -->
                                            <div class="form-group">
                                                <label for="password" class="col-md-3 control-label">Password</label>
                                                <div class="col-md-9">
                                                    <input type="password" id="password" name="credenciales.password" 
                                                           value="${credenciales.password}" class="form-control" required />
                                                </div>
                                            </div>

                                            <!-- Botón de Login -->
                                            <div class="form-group">
                                                <div class="col-md-offset-3 col-md-9">
                                                    <input type="submit" value="Login" class="btn btn-primary" />
                                                </div>
                                            </div>
                                        </form>
					<c:if test="${not empty errors}">
                                        <div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel" aria-hidden="true">
                                            <div class="modal-dialog" role="document">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="errorModalLabel">Error</h5>
                                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                            <span aria-hidden="true">&times;</span>
                                                        </button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <p>${errors.text}</p>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <script>
                                            // Mostrar el modal de error cuando se carga la página
                                            $('#errorModal').modal('show');
                                        </script>
                                        </c:if>
					<c:if test="${not empty errors}">
						<div class="alert alert-danger" role="alert">
							${errors.text}
						</div>
					</c:if>
					
					<c:if test="${attempts.hasExceededMaxAttempts()}">
						<div id="too-many-login-attempts" class="modal top fade" role="alert" tabindex="-1" data-mdb-backdrop="static" data-mdb-keyboard="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h2 class="modal-title">Please try again later.</h2>
									</div>
									<div class="modal-body">
										<div class="alert alert-danger" role="alert">
											<img class="mb-4" src="<c:url value="/resources/img/Invalid.png" />" alt="" width="134" height="92" />
											The maximum number of login attempts has been exceeded!
										</div>
									</div>
								</div>
							</div>
						</div>
						<script>
							$("#too-many-login-attempts").modal('show');
						</script>
					</c:if>
					
					<jsp:include page="/WEB-INF/views/layout/alert.jsp" />
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
        <div>
            <button class="volver-btn" onclick="goBackTwoPages()">
                    Volver
            </button>
        </div>

        <script>
            function goBackTwoPages() {
                if (window.history.length > 1) {
                    window.history.go(-1);
                } else {
                    window.location.href = '/Homework2/Web/Articles';
                }
            }
        </script>
</body>
</html>