<%-- 
    Document   : admin_sede_form
    Created on : 26 nov. 2025, 10:55:04 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<jsp:include page="header.jsp"><jsp:param name="titulo" value="Nueva Sede" /></jsp:include>

<div class="container mt-5" style="max-width: 600px;">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Registrar Nueva Sede</h4>
        </div>
        <div class="card-body">
            <form action="<c:url value='/admin/sedes/guardar' />" method="post">
                <div class="mb-3">
                    <label class="form-label">Nombre de la Sede</label>
                    <input type="text" name="nombre" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Dirección</label>
                    <input type="text" name="direccion" class="form-control" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Teléfono</label>
                        <input type="text" name="telefono" class="form-control">
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Tarifa Base (S/)</label>
                        <input type="number" step="0.10" name="tarifaBase" class="form-control" value="5.00" required>
                    </div>
                </div>
                <button type="submit" class="btn btn-success w-100">Guardar Sede</button>
            </form>
        </div>
    </div>
</div>
<jsp:include page="footer.jsp" />