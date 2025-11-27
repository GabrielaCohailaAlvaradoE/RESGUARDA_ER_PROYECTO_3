<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Gestión de Espacios" />
</jsp:include>

<div class="container-fluid px-5 py-4">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-0"><i class="bi bi-grid-1x2-fill me-2 text-primary"></i>Infraestructura de Sede</h3>
            <p class="text-muted">Administra la capacidad de tu estacionamiento.</p>
        </div>
        <a href="<c:url value='/gerente/pisos/nuevo' />" class="btn btn-primary shadow-sm rounded-pill px-4">
            <i class="bi bi-layers-fill me-2"></i> Crear Nuevo Piso
        </a>
    </div>

    <c:if test="${not empty exito}">
        <div class="alert alert-success border-0 shadow-sm d-flex align-items-center mb-4 rounded-3"><i class="bi bi-check-circle-fill me-2"></i> ${exito}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger border-0 shadow-sm d-flex align-items-center mb-4 rounded-3"><i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}</div>
    </c:if>

    <div class="accordion shadow-sm rounded-3 overflow-hidden" id="accordionPisos">

        <c:forEach var="piso" items="${pisos}" varStatus="loop">
            <div class="accordion-item border-0 border-bottom">
                <h2 class="accordion-header" id="heading-${loop.index}">
                    <button class="accordion-button ${loop.first ? '' : 'collapsed'} py-4 bg-white" type="button" data-bs-toggle="collapse" 
                            data-bs-target="#collapse-${loop.index}" aria-expanded="${loop.first ? 'true' : 'false'}">
                        <div class="d-flex align-items-center w-100 pe-3">
                            <div class="bg-light rounded-circle p-3 me-3 text-primary">
                                <i class="bi bi-p-square-fill fs-4"></i>
                            </div>
                            <div>
                                <h5 class="mb-0 fw-bold text-dark">${piso.nombrePiso}</h5>
                                <small class="text-muted">Nivel ${piso.numeroPiso} • Capacidad: ${piso.capacidadTotal}</small>
                            </div>
                            <div class="ms-auto text-end">
                                <span class="badge bg-primary rounded-pill px-3 py-2">${piso.espacios.size()} Slots</span>
                            </div>
                        </div>
                    </button>
                </h2>
                
                <div id="collapse-${loop.index}" class="accordion-collapse collapse ${loop.first ? 'show' : ''}" data-bs-parent="#accordionPisos">
                    <div class="accordion-body bg-light bg-opacity-25 p-4">
                        
                        <div class="row">
                            <div class="col-lg-8">
                                <h6 class="fw-bold text-uppercase text-muted small mb-3">Espacios Habilitados</h6>
                                <div class="row g-3">
                                    <c:forEach var="esp" items="${piso.espacios}">
                                        <div class="col-md-4 col-lg-3">
                                            <div class="card border-0 shadow-sm h-100">
                                                <div class="card-body p-3 text-center">
                                                    <h5 class="fw-bold mb-2">${esp.numeroEspacio}</h5>
                                                    
                                                    <c:choose>
                                                        <c:when test="${esp.estado == 'LIBRE'}">
                                                            <span class="badge bg-success bg-opacity-10 text-success border border-success mb-3 d-block">LIBRE</span>
                                                            <a href="<c:url value='/gerente/espacios/cambiarEstado/${esp.idEspacio}' />" class="btn btn-sm btn-outline-secondary w-100" title="Poner en Mantenimiento">
                                                                <i class="bi bi-cone-striped"></i>
                                                            </a>
                                                        </c:when>
                                                        <c:when test="${esp.estado == 'OCUPADO'}">
                                                            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger mb-3 d-block">OCUPADO</span>
                                                            <button class="btn btn-sm btn-light w-100 text-muted" disabled><i class="bi bi-lock-fill"></i></button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-warning bg-opacity-10 text-warning border border-warning mb-3 d-block">MANT.</span>
                                                            <a href="<c:url value='/gerente/espacios/cambiarEstado/${esp.idEspacio}' />" class="btn btn-sm btn-success w-100" title="Habilitar">
                                                                <i class="bi bi-check-lg"></i>
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <c:if test="${empty piso.espacios}">
                                        <div class="col-12 text-center py-4 text-muted">
                                            <i class="bi bi-inbox fs-1 d-block mb-2 opacity-25"></i>
                                            No hay espacios creados en este piso.
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <div class="col-lg-4 border-start ps-lg-4 mt-4 mt-lg-0">
                                <div class="bg-white p-4 rounded-3 shadow-sm border">
                                    <h6 class="fw-bold text-dark mb-3"><i class="bi bi-plus-circle-fill text-success me-2"></i>Añadir Nuevo Espacio</h6>
                                    <form action="<c:url value='/gerente/espacios/crear' />" method="post">
                                        <input type="hidden" name="idPiso" value="${piso.idPiso}">
                                        
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold text-muted">NOMBRE DEL ESPACIO</label>
                                            <div class="input-group">
                                                <span class="input-group-text bg-light"><i class="bi bi-geo-alt-fill"></i></span>
                                                <input type="text" name="numeroEspacio" class="form-control" placeholder="Ej: S03, A-10, VIP-1" required>
                                            </div>
                                            <div class="form-text small">Escriba el código exacto (ej. 'S03').</div>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-success w-100 fw-bold">
                                            <i class="bi bi-save-fill me-2"></i> Guardar Espacio
                                        </button>
                                    </form>
                                </div>
                                
                                <div class="mt-4 p-3 bg-info bg-opacity-10 rounded-3 border border-info border-opacity-25 text-info small">
                                    <i class="bi bi-info-circle-fill me-1"></i>
                                    <strong>Tip:</strong> Use el botón <i class="bi bi-cone-striped"></i> para bloquear un espacio por mantenimiento o limpieza.
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>

    </div>
</div>

<jsp:include page="footer.jsp" />