<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="cliente_header.jsp">
    <jsp:param name="titulo" value="Mis Vehículos" />
</jsp:include>

<c:if test="${not empty exito}"><div class="alert alert-success">${exito}</div></c:if>
<c:if test="${not empty error}"><div class="alert alert-danger">${error}</div></c:if>

<div class="row g-4">
    <div class="col-lg-5">
        <div class="card shadow border-0 h-100">
            <div class="card-header bg-white border-0 py-3">
                <h5 class="mb-0 fw-bold"><i class="bi bi-plus-circle-fill text-success me-2"></i>Añadir Nuevo Vehículo</h5>
            </div>
            <div class="card-body p-4">
                <form action="<c:url value='/cliente/agregarVehiculo' />" method="post">
                    
                    <div class="mb-3">
                        <label for="placa" class="form-label">Placa</label>
                        <input type="text" class="form-control" id="placa" name="placa" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="vin" class="form-label">VIN (N° de Chasis)</label>
                        <input type="text" class="form-control" id="vin" name="vin" required>
                        <div class="form-text">Usado para validación</div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="marca" class="form-label">Marca</label>
                            <input type="text" class="form-control" id="marca" name="marca" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="modelo" class="form-label">Modelo</label>
                            <input type="text" class="form-control" id="modelo" name="modelo" required>
                        </div>
                    </div>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="color" class="form-label">Color</label>
                            <input type="text" class="form-control" id="color" name="color">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="anioFabricacion" class="form-label">Año</label>
                            <input type="number" class="form-control" id="anioFabricacion" name="anioFabricacion" min="1950" max="2026">
                        </div>
                    </div>

                    <button type="submit" class="btn btn-success w-100">
                        <i class="bi bi-save-fill me-2"></i>Guardar Vehículo
                    </button>
                </form>
            </div>
        </div>
    </div>

    <div class="col-lg-7">
        <h5 class="mb-3 fw-bold"><i class="bi bi-list-task me-2"></i>Mis Vehículos Registrados</h5>
        
        <c:choose>
            <c:when test="${empty misVehiculos}">
                <div class="alert alert-info">No tienes vehículos registrados.</div>
            </c:when>
            <c:otherwise>
                <c:forEach var="veh" items="${misVehiculos}">
                    <div class="card shadow-sm border-0 mb-3">
                        <div class="card-body p-3">
                            <div class="d-flex align-items-center">
                                <div class="p-3">
                                    <i class="bi bi-car-front-fill text-success" style="font-size: 2.5rem;"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <h5 class="card-title mb-0">${veh.marca} ${veh.modelo}</h5>
                                    <span class="badge text-bg-dark fs-6">${veh.placa}</span>
                                    <small class="text-muted ms-2">(${veh.color} - ${veh.anioFabricacion})</small>
                                </div>
                                <div>
                                    <form action="<c:url value='/cliente/eliminarVehiculo' />" method="POST" style="display:inline;">
                                        <input type="hidden" name="idVehiculo" value="${veh.idVehiculo}">
                                        <button type="submit" class="btn btn-outline-danger" title="Quitar Vehículo">
                                            <i class="bi bi-trash-fill"></i> Quitar
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="cliente_footer.jsp" />
