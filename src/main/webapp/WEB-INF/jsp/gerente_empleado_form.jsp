<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="${titulo}" />
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-8">
        <h3>${titulo}</h3>
        <hr>
        <div class="card shadow-sm">
            <div class="card-body">
                
                <form action="<c:url value='/gerente/empleados/guardar' />" method="post">
                
                    <input type="hidden" name="idEmpleado" value="${empleado.idEmpleado}" />

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="nombres" class="form-label">Nombres</label>
                            <input type="text" class="form-control" id="nombres" name="nombres" value="${empleado.nombres}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="apellidos" class="form-label">Apellidos</label>
                            <input type="text" class="form-control" id="apellidos" name="apellidos" value="${empleado.apellidos}" required>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="dni" class="form-label">DNI</label>
                            <input type="text" class="form-control" id="dni" name="dni" value="${empleado.dni}" required>
                        </div>
                         <div class="col-md-6">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email" name="email" value="${empleado.email}">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="usuario" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="usuario" name="usuario" value="${empleado.usuario}" required>
                        </div>
                        <div class="col-md-6">
                            <label for="contrasena" class="form-label">Contraseña</GTC/label>
                            <input type="password" class="form-control" id="contrasena" name="contrasena">
                            <c:if test="${empleado.idEmpleado > 0}">
                                <div class="form-text">Dejar en blanco para no cambiar la contraseña.</div>
                            </c:if>
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="idRol" class="form-label">Rol</label>
                            <select id="idRol" name="idRol" class="form-select" required>
                                <option value="" disabled selected>-- Seleccione un Rol --</option>
                                <c:forEach var="rol" items="${listaRoles}">
                                    <option value="${rol.idRol}" ${empleado.idRol == rol.idRol ? 'selected' : ''}>
                                        ${rol.nombre}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="estado" class="form-label">Estado</label>
                            <select id="estado" name="estado" class.form-select" required>
                                <option value="ACTIVO" ${empleado.estado == 'ACTIVO' ? 'selected' : ''}>ACTIVO</option>
                                <option value="INACTIVO" ${empleado.estado == 'INACTIVO' ? 'selected' : ''}>INACTIVO</option>
                            </select>
                        </div>
                    </div>

                    <hr>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                    <a href="<c:url value='/gerente/empleados' />" class="btn btn-secondary">Cancelar</a>

                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
