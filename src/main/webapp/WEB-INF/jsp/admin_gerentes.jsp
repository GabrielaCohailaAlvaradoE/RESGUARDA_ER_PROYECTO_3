<%-- 
    Document   : admin_gerentes
    Created on : 26 nov. 2025, 11:14:13 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Gerentes" /></jsp:include>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Gestión de Gerentes</h2>
        <a href="<c:url value='/admin/gerentes/nuevo' />" class="btn btn-primary"><i class="bi bi-plus-circle"></i> Nuevo Gerente</a>
    </div>
    <div class="card shadow-sm">
        <div class="card-body">
            <table class="table table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>Nombre</th>
                        <th>Usuario</th>
                        <th>DNI</th>
                        <th>Sede Asignada</th> <th>Estado</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="g" items="${gerentes}">
                        <tr>
                            <td>${g.nombres} ${g.apellidos}</td>
                            <td>${g.usuario}</td>
                            <td>${g.dni}</td>
                            <td>ID Sede: ${g.idSede}</td> <td><span class="badge ${g.estado == 'ACTIVO' ? 'bg-success' : 'bg-danger'}">${g.estado}</span></td>
                            <td>
                                <a href="<c:url value='/admin/gerentes/editar/${g.idEmpleado}' />" class="btn btn-sm btn-warning"><i class="bi bi-pencil"></i></a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />