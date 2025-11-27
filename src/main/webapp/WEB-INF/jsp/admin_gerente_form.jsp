<%-- 
    Document   : admin_gerente_form
    Created on : 26 nov. 2025, 11:14:25 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Datos Gerente" /></jsp:include>

<div class="container mt-5" style="max-width: 700px;">
    <div class="card shadow">
        <div class="card-header bg-primary text-white"><h4 class="mb-0">${titulo}</h4></div>
        <div class="card-body">
            <form action="<c:url value='/admin/gerentes/guardar' />" method="post">
                <input type="hidden" name="idEmpleado" value="${gerente.idEmpleado}">
                
                <div class="row mb-3">
                    <div class="col-6"><label>Nombres</label><input type="text" name="nombres" class="form-control" value="${gerente.nombres}" required></div>
                    <div class="col-6"><label>Apellidos</label><input type="text" name="apellidos" class="form-control" value="${gerente.apellidos}" required></div>
                </div>
                <div class="row mb-3">
                    <div class="col-6"><label>DNI</label><input type="text" name="dni" class="form-control" value="${gerente.dni}" required></div>
                    <div class="col-6"><label>Usuario</label><input type="text" name="usuario" class="form-control" value="${gerente.usuario}" required></div>
                </div>
                
                <div class="mb-3">
                    <label>Asignar a Sede</label>
                    <select name="idSede" class="form-select" required>
                        <option value="">Seleccione Sede...</option>
                        <c:forEach var="s" items="${sedes}">
                            <option value="${s.idSede}" ${gerente.idSede == s.idSede ? 'selected' : ''}>${s.nombre}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Contraseña</label>
                    <input type="password" name="contrasena" class="form-control" placeholder="${gerente.idEmpleado > 0 ? 'Dejar vacío para mantener actual' : 'Obligatoria'}">
                </div>
                
                <div class="mb-3">
                    <label>Estado</label>
                    <select name="estado" class="form-select">
                        <option value="ACTIVO" ${gerente.estado == 'ACTIVO' ? 'selected' : ''}>Activo</option>
                        <option value="INACTIVO" ${gerente.estado == 'INACTIVO' ? 'selected' : ''}>Inactivo</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-success w-100">Guardar</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />