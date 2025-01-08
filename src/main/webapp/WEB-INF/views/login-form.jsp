<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>Login</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" />
<script src="<c:url value="/resources/js/jquery-1.11.1.min.js" />"></script>
<script src="<c:url value="/resources/js/bootstrap.min.js" />"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

<!-- FontAwesome -->
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css"
      rel="stylesheet"
      integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN"
      crossorigin="anonymous"/>
</head>
<body>
	<div class="container">
		<div class="col-md-offset-2 col-md-7">
			<h2 class="text-center">Iniciar Sesi�n</h2>
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

                                            <!-- Campo para la contrase�a -->
                                            <div class="form-group">
                                                <label for="password" class="col-md-3 control-label">Password</label>
                                                <div class="col-md-9">
                                                    <input type="password" id="password" name="credenciales.password" 
                                                           value="${credenciales.password}" class="form-control" required />
                                                </div>
                                            </div>

                                            <!-- Bot�n de Login -->
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
                                            // Mostrar el modal de error cuando se carga la p�gina
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
</body>
</html>
