<%-- 
    Document   : admin_sedes
    Created on : 26 nov. 2025, 10:54:46 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Sedes" /></jsp:include>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Gestión de Sedes</h2>
        <a href="<c:url value='/admin/sedes/nueva' />" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Nueva Sede</a>
    </div>
    
    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Dirección</th>
                        <th>Teléfono</th>
                        <th>Tarifa Base</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="s" items="${sedes}">
                        <tr>
                            <td>${s.idSede}</td>
                            <td>${s.nombre}</td>
                            <td>${s.direccion}</td>
                            <td>${s.telefono}</td>
                            <td>S/ ${s.tarifaBase}</td>
                            <td><span class="badge bg-success">${s.estado}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
