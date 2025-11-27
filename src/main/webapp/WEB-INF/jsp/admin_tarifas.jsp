<%-- 
    Document   : admin_tarifas
    Created on : 26 nov. 2025, 11:14:37 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Tarifas" /></jsp:include>

<div class="container mt-4">
    <h2>Tarifas Globales</h2>
    <div class="card shadow-sm mt-3">
        <div class="card-body">
            <table class="table align-middle">
                <thead class="table-dark">
                    <tr>
                        <th>Tipo Vehículo</th>
                        <th>Precio Hora</th>
                        <th>Precio Reserva</th>
                        <th>Acción</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${tarifas}">
                        <tr>
                            <td><span class="badge bg-info text-dark fs-6">${t.tipoVehiculo}</span></td>
                            <td class="fw-bold">S/ ${t.precioHora}</td>
                            <td>S/ ${t.precioReserva}</td>
                            <td>
                                <a href="<c:url value='/admin/tarifas/editar/${t.idTarifa}' />" class="btn btn-outline-primary btn-sm">Editar Precio</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />