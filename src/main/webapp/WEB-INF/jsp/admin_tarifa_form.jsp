<%-- 
    Document   : admin_tarifa_form
    Created on : 26 nov. 2025, 11:14:49 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Editar Tarifa" /></jsp:include>

<div class="container mt-5" style="max-width: 500px;">
    <div class="card shadow">
        <div class="card-header bg-info text-dark"><h4>Editar Tarifa: ${tarifa.tipoVehiculo}</h4></div>
        <div class="card-body">
            <form action="<c:url value='/admin/tarifas/guardar' />" method="post">
                <input type="hidden" name="idTarifa" value="${tarifa.idTarifa}">
                <input type="hidden" name="tipoVehiculo" value="${tarifa.tipoVehiculo}">
                <input type="hidden" name="activo" value="true"> <div class="mb-3">
                    <label>Precio por Hora (S/)</label>
                    <input type="number" step="0.10" name="precioHora" class="form-control" value="${tarifa.precioHora}" required>
                </div>
                <div class="mb-3">
                    <label>Precio por Reserva Web (S/)</label>
                    <input type="number" step="0.10" name="precioReserva" class="form-control" value="${tarifa.precioReserva}" required>
                </div>
                
                <button type="submit" class="btn btn-primary w-100">Actualizar Precios</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />
