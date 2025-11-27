<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="${titulo}" />
</jsp:include>

<c:if test="${not empty exito}"><div class="alert alert-success">${exito}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="d-flex justify-content-between align-items-center mb-3">
    <h3><i class="bi bi-person-lines-fill"></i> Gestión de Empleados</h3>
    <a href="<c:url value='/gerente/empleados/nuevo' />" class="btn btn-success">
        <i class="bi bi-plus-circle-fill"></i> Nuevo Empleado
    </a>
</div>

<div class="card shadow-sm">
    <div class="card-body">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombres</th>
                    <th>Apellidos</th>
                    <th>DNI</th>
                    <th>Usuario</th>
                    <th>Rol</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="emp" items="${empleados}">
                    <tr>
                        <td>${emp.idEmpleado}</td>
                        <td>${emp.nombres}</td>
                        <td>${emp.apellidos}</td>
                        <td>${emp.dni}</td>
                        <td>${emp.usuario}</td>
                        <td>
                            <c:choose>
                                <c:when test="${emp.idRol == 1}"><span class="badge bg-danger">ADMIN</span></c:when>
                                <c:when test="${emp.idRol == 2}"><span class="badge bg-primary">GERENTE</span></c:when>
                                <c:when test="${emp.idRol == 3}"><span class="badge bg-info">RECEPCION</span></c:when>
                                <c:when test="${emp.idRol == 4}"><span class="badge bg-secondary">VIGILANTE</span></c:when>
                                <c:otherwise><span class="badge bg-light text-dark">N/A</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${emp.estado == 'ACTIVO'}"><span class="badge bg-success">ACTIVO</span></c:when>
                                <c:otherwise><span class="badge bg-warning">INACTIVO</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="<c:url value='/gerente/empleados/editar/${emp.idEmpleado}' />" class="btn btn-sm btn-warning">
                                <i class="bi bi-pencil-fill"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="footer.jsp" />