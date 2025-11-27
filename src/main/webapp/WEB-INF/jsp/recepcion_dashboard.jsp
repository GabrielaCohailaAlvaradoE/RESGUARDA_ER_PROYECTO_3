<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Control de Operaciones" />
</jsp:include>

<style>
    /* Estilos para las tarjetas de estado */
    .slot-card { transition: all 0.3s; border: 1px solid rgba(0,0,0,0.05); }
    .slot-card:hover { transform: translateY(-3px); box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
    
    /* Bordes de colores según estado */
    .border-free { border-bottom: 4px solid #198754 !important; }       /* Verde */
    .border-occupied { border-bottom: 4px solid #dc3545 !important; }   /* Rojo */
    .border-reserved { border-bottom: 4px solid #ffc107 !important; }   /* Amarillo */

    /* Fondos de cabecera */
    .bg-free { background-color: #198754; color: white; }
    .bg-occupied { background-color: #dc3545; color: white; }
    .bg-reserved { background-color: #ffc107; color: #212529; } /* Amarillo oscuro para contraste */
</style>

<div class="container-fluid px-4 py-4">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h2 class="fw-bold text-dark mb-0">Panel de Recepción</h2>
            <p class="text-muted mb-0">Gestión de ingresos, salidas y reservas.</p>
        </div>
        <div class="badge bg-light text-dark border p-2 shadow-sm">
            <i class="bi bi-clock me-1"></i> <span id="reloj">--:--</span>
        </div>
    </div>

    <c:if test="${not empty exito}">
        <div class="alert alert-success border-0 shadow-sm d-flex align-items-center mb-4"><i class="bi bi-check-circle-fill fs-4 me-3"></i> <div>${exito}</div><button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button></div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger border-0 shadow-sm d-flex align-items-center mb-4"><i class="bi bi-exclamation-octagon-fill fs-4 me-3"></i> <div>${error}</div><button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button></div>
    </c:if>

    <div class="row g-4 mb-5">
        
        <div class="col-lg-7">
            <div class="card shadow border-0 h-100">
                <div class="card-header bg-white border-0 pt-4 px-4 pb-0 d-flex align-items-center">
                    <div class="bg-primary bg-opacity-10 p-3 rounded-circle me-3 text-primary"><i class="bi bi-car-front-fill fs-4"></i></div>
                    <div><h5 class="fw-bold mb-0">Registrar Ingreso</h5><small class="text-muted">Asignar espacio y generar ticket</small></div>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/recepcion/registrarEntrada' />" method="POST" class="row g-3">
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <input type="text" class="form-control fw-bold" id="placa" name="placa" placeholder="ABC-123" required style="text-transform: uppercase;">
                                <label for="placa"><i class="bi bi-upc-scan me-1"></i> Placa</label>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="form-floating">
                                <select id="espacio" name="idEspacio" class="form-select" required>
                                    <option value="" selected disabled>Seleccione ubicación</option>
                                    <c:forEach var="piso" items="${pisos}">
                                        <optgroup label="${piso.nombrePiso}">
                                            <c:forEach var="espacio" items="${piso.espacios}">
                                                
                                                <c:if test="${espacio.estado == 'LIBRE'}">
                                                    <option value="${espacio.idEspacio}">${espacio.numeroEspacio} (Libre)</option>
                                                </c:if>
                                                
                                                <c:if test="${espacio.estado == 'MANTENIMIENTO'}">
                                                    <option value="${espacio.idEspacio}" class="fw-bold text-warning">
                                                        &#9888; ${espacio.numeroEspacio} (RESERVADO)
                                                    </option>
                                                </c:if>
                                                
                                            </c:forEach>
                                        </optgroup>
                                    </c:forEach>
                                </select>
                                <label for="espacio">Asignar Espacio</label>
                            </div>
                        </div>

                        <div class="col-md-12">
                            <div class="form-floating">
                                <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI">
                                <label for="dni">DNI Conductor (Opcional)</label>
                            </div>
                        </div>

                        <div class="col-12 mt-3">
                            <button type="submit" class="btn btn-primary w-100 py-3 rounded-3 fw-bold shadow-sm">
                                <i class="bi bi-ticket-perforated-fill me-2"></i> CONFIRMAR INGRESO
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-5">
            <div class="card shadow border-0 h-100" style="background: #f8f9fa;">
                <div class="card-header bg-transparent border-0 pt-4 px-4 pb-0 d-flex align-items-center">
                    <div class="bg-dark bg-opacity-10 p-3 rounded-circle me-3 text-dark"><i class="bi bi-wallet2 fs-4"></i></div>
                    <div><h5 class="fw-bold mb-0 text-dark">Salida y Cobro</h5><small class="text-muted">Procesar pago</small></div>
                </div>
                <div class="card-body p-4">
                    
                    <form action="<c:url value='/recepcion/buscarSalida' />" method="POST">
                        <div class="input-group input-group-lg mb-3 shadow-sm">
                            <input type="text" class="form-control border-0" name="placaOpin" value="${registroEncontrado.vehiculo.placa}" placeholder="Placa o PIN..." required>
                            <button class="btn btn-dark" type="submit"><i class="bi bi-search"></i></button>
                        </div>
                    </form>

                    <c:if test="${not empty registroEncontrado}">
                        <div class="bg-white p-3 rounded-3 shadow-sm border animate__animated animate__fadeIn">
                            <div class="d-flex justify-content-between mb-2 border-bottom pb-2">
                                <span class="fw-bold">Vehículo:</span> <span class="text-primary">${registroEncontrado.vehiculo.placa}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3 align-items-center bg-light p-2 rounded">
                                <span class="fw-bold text-dark small">TOTAL A PAGAR:</span>
                                <span class="fs-4 fw-bold text-success">S/ ${registroEncontrado.montoTotal}</span>
                            </div>

                            <form action="<c:url value='/recepcion/registrarPago' />" method="POST">
                                <input type="hidden" name="idRegistro" value="${registroEncontrado.idRegistro}">
                                <input type="hidden" name="montoTotal" value="${registroEncontrado.montoTotal}">
                                
                                <div class="row g-2 mb-2">
                                    <div class="col-6"><select name="metodoPago" class="form-select form-select-sm"><option value="EFECTIVO">Efectivo</option><option value="YAPE">Yape</option><option value="TARJETA">Tarjeta</option></select></div>
                                    <div class="col-6"><input type="number" step="0.10" class="form-control form-control-sm" name="montoRecibido" placeholder="Recibido" required></div>
                                </div>
                                <button type="submit" class="btn btn-success w-100 btn-sm fw-bold shadow-sm">COBRAR Y LIBERAR</button>
                            </form>
                        </div>
                    </c:if>
                    <c:if test="${not empty errorSalida}"><div class="alert alert-warning p-2 text-center small mb-0">${errorSalida}</div></c:if>
                </div>
            </div>
        </div>
    </div>

    <div class="d-flex align-items-center mb-3 mt-5">
        <h4 class="fw-bold mb-0 me-3"><i class="bi bi-grid-3x3-gap-fill text-primary"></i> Mapa en Tiempo Real</h4>
        <div class="d-flex gap-3 ms-auto small">
            <span class="badge bg-success rounded-pill"><i class="bi bi-check-lg"></i> Libre</span>
            <span class="badge bg-danger rounded-pill"><i class="bi bi-x-lg"></i> Ocupado</span>
            <span class="badge bg-warning text-dark rounded-pill"><i class="bi bi-lock-fill"></i> Reservado</span>
        </div>
    </div>
    <hr class="mb-4">

    <c:forEach var="piso" items="${pisos}">
        <div class="card mb-4 border-0 shadow-sm">
            <div class="card-body bg-light rounded-3">
                <h6 class="text-muted fw-bold text-uppercase mb-3 small ls-1">${piso.nombrePiso}</h6>
                
                <div class="row row-cols-2 row-cols-md-4 row-cols-lg-6 g-3">
                    <c:forEach var="espacio" items="${piso.espacios}">
                        
                        <c:choose>
                            <c:when test="${espacio.estado == 'LIBRE'}">
                                <c:set var="cardClass" value="border-free" />
                                <c:set var="headerClass" value="bg-free" />
                                <c:set var="icon" value="bi-check-lg" />
                                <c:set var="label" value="LIBRE" />
                                <c:set var="actionHtml">
                                    <button class="btn btn-sm btn-outline-success w-100 disabled" style="font-size: 0.7rem;">Disponible</button>
                                </c:set>
                            </c:when>
                            <c:when test="${espacio.estado == 'OCUPADO'}">
                                <c:set var="cardClass" value="border-occupied" />
                                <c:set var="headerClass" value="bg-occupied" />
                                <c:set var="icon" value="bi-car-front-fill" />
                                <c:set var="label" value="OCUPADO" />
                                <c:set var="actionHtml">
                                    <small class="text-muted" style="font-size: 0.65rem;">Usar Panel Salida</small>
                                </c:set>
                            </c:when>
                            <c:otherwise> 
                                <c:set var="cardClass" value="border-reserved" />
                                <c:set var="headerClass" value="bg-reserved" />
                                <c:set var="icon" value="bi-calendar-check-fill" />
                                <c:set var="label" value="RESERVADO" />
                                <c:set var="actionHtml">
                                    <a href="<c:url value='/recepcion/liberar/${espacio.idEspacio}' />" class="btn btn-sm btn-outline-warning text-dark w-100 fw-bold" style="font-size: 0.7rem;" title="Cancelar Reserva / Liberar">
                                        Liberar
                                    </a>
                                </c:set>
                            </c:otherwise>
                        </c:choose>

                        <div class="col">
                            <div class="card h-100 shadow-sm slot-card ${cardClass}">
                                <div class="card-header ${headerClass} py-1 px-2 text-center border-0">
                                    <small class="fw-bold small">${espacio.numeroEspacio}</small>
                                </div>
                                <div class="card-body d-flex flex-column align-items-center justify-content-center py-3">
                                    <i class="bi ${icon} fs-2 mb-2 opacity-75"></i>
                                    <span class="badge bg-light text-dark border fw-bold small mb-2" style="font-size: 0.65rem;">
                                        ${label}
                                    </span>
                                    ${actionHtml}
                                </div>
                            </div>
                        </div>

                    </c:forEach>
                    
                    <c:if test="${empty piso.espacios}">
                        <div class="col-12 text-center text-muted py-4 small">Sin espacios configurados.</div>
                    </c:if>
                </div>
            </div>
        </div>
    </c:forEach>

</div>

<script>
    function updateClock() {
        document.getElementById('reloj').innerText = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    }
    setInterval(updateClock, 1000);
    updateClock();
</script>

<jsp:include page="footer.jsp" />