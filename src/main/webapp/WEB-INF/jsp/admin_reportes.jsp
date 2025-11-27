<%-- 
    Document   : admin_reportes
    Created on : 26 nov. 2025, 11:14:59 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Reportes" /></jsp:include>

<div class="container-fluid px-4 py-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Reporte Consolidado de Ingresos</h2>
        <button class="btn btn-success" onclick="window.print()"><i class="bi bi-printer"></i> Imprimir / PDF</button>
    </div>

    <div class="card shadow-sm">
        <div class="card-header bg-white fw-bold">Transacciones Globales (Todas las Sedes)</div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover mb-0">
                    <thead class="bg-light">
                        <tr>
                            <th>ID Pago</th>
                            <th>Fecha</th>
                            <th>Sede</th> <th>Placa</th>
                            <th>Método</th>
                            <th class="text-end">Monto</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${movimientos}">
                            <tr>
                                <td>#${p.idPago}</td>
                                <td>${p.fechaPago}</td>
                                <td>Principal</td> <td>${p.registro.vehiculo.placa}</td>
                                <td>${p.metodoPago}</td>
                                <td class="text-end fw-bold">S/ ${p.montoTotal}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />