<%-- 
    Document   : cliente_mapa
    Created on : 25 nov. 2025, 10:41:32 a. m.
    Author     : ASUS
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="cliente_header.jsp">
    <jsp:param name="titulo" value="Mapa en Vivo" />
</jsp:include>

<style>
    /* --- DISEÑO DE MAPA "TOP DOWN" --- */
    .parking-floor {
        background: #eef2f7;
        border: 2px dashed #cbd5e1;
        border-radius: 20px;
        padding: 20px;
        margin-bottom: 40px;
        position: relative;
    }
    
    .floor-label {
        position: absolute;
        top: -15px;
        left: 20px;
        background: #0f172a; /* Azul Midnight */
        color: white;
        padding: 5px 20px;
        border-radius: 50px;
        font-weight: 700;
        letter-spacing: 1px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        text-transform: uppercase;
    }

    /* GRILLA DINÁMICA DE ESPACIOS */
    .parking-grid {
        display: grid;
        /* Crea columnas automáticas de mínimo 100px de ancho */
        grid-template-columns: repeat(auto-fill, minmax(110px, 1fr)); 
        gap: 20px;
        margin-top: 20px;
    }

    /* SLOT DE ESTACIONAMIENTO (CADA ESPACIO) */
    .parking-slot {
        aspect-ratio: 2/3; /* Forma rectangular vertical como un espacio real */
        border-radius: 10px;
        border: 2px solid white;
        position: relative;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 10px;
        transition: transform 0.3s;
        box-shadow: 0 4px 6px rgba(0,0,0,0.05);
    }
    
    /* LÍNEAS DE PINTURA DEL PISO */
    .parking-slot::before {
        content: '';
        position: absolute;
        top: 0; left: 10px; right: 10px;
        height: 2px;
        background: rgba(0,0,0,0.1);
    }

    /* ESTADOS DEL SLOT */
    .slot-free {
        background-color: #d1e7dd; /* Verde suave */
        border-color: #a3cfbb;
        color: #0f5132;
    }
    
    .slot-occupied {
        background-color: #f8d7da; /* Rojo suave */
        border-color: #f1aeb5;
        color: #842029;
    }
    
    .slot-maintenance {
        background-color: #fff3cd; /* Amarillo suave */
        border-color: #ffe69c;
        color: #664d03;
    }

    /* --- TU AUTO (ANIMACIÓN ESPECIAL) --- */
    .my-car-zone {
        background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%) !important;
        color: white !important;
        border: 2px solid #fff !important;
        z-index: 10;
        box-shadow: 0 0 0 0 rgba(13, 110, 253, 0.7);
        animation: pulse-blue 2s infinite;
    }
    
    @keyframes pulse-blue {
        0% {
            transform: scale(1);
            box-shadow: 0 0 0 0 rgba(13, 110, 253, 0.7);
        }
        70% {
            transform: scale(1.05);
            box-shadow: 0 0 0 15px rgba(13, 110, 253, 0);
        }
        100% {
            transform: scale(1);
            box-shadow: 0 0 0 0 rgba(13, 110, 253, 0);
        }
    }

    .slot-number {
        font-weight: 800;
        font-size: 0.9rem;
        text-align: center;
        opacity: 0.8;
    }
    
    .car-icon-container {
        font-size: 2.5rem;
        text-align: center;
        line-height: 1;
    }
    
    /* Coche mirando hacia arriba */
    .bi-car-front-fill {
        display: inline-block;
        /* transform: rotate(180deg); Opcional si quieres que miren "hacia adentro" */ 
    }

    .slot-status {
        font-size: 0.6rem;
        text-align: center;
        text-transform: uppercase;
        font-weight: 700;
        letter-spacing: 1px;
    }
    
    .you-are-here {
        position: absolute;
        top: -10px;
        left: 50%;
        transform: translateX(-50%);
        background: #dc3545; /* Rojo badge */
        color: white;
        padding: 2px 8px;
        border-radius: 10px;
        font-size: 0.6rem;
        font-weight: bold;
        white-space: nowrap;
        box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        animation: bounce 2s infinite;
    }
    
    @keyframes bounce {
        0%, 20%, 50%, 80%, 100% {transform: translateX(-50%) translateY(0);}
        40% {transform: translateX(-50%) translateY(-5px);}
        60% {transform: translateX(-50%) translateY(-3px);}
    }

</style>

<div class="container-fluid px-4 py-5">

    <div class="mb-5 text-center">
        <h2 class="fw-bold text-dark display-6">Monitor de Estacionamiento</h2>
        <p class="text-muted lead">Visualización en tiempo real de la disponibilidad por niveles.</p>
        
        <div class="d-flex justify-content-center gap-3 mt-3 flex-wrap">
            <span class="badge bg-success bg-opacity-10 text-success border border-success px-3 py-2 rounded-pill">
                <i class="bi bi-square-fill me-1"></i> Libre
            </span>
            <span class="badge bg-danger bg-opacity-10 text-danger border border-danger px-3 py-2 rounded-pill">
                <i class="bi bi-car-front-fill me-1"></i> Ocupado
            </span>
            <span class="badge bg-warning bg-opacity-10 text-warning border border-warning px-3 py-2 rounded-pill">
                <i class="bi bi-cone-striped me-1"></i> Reservado
            </span>
            <span class="badge bg-primary px-3 py-2 rounded-pill shadow-sm">
                <i class="bi bi-geo-alt-fill me-1"></i> Tu Ubicación
            </span>
        </div>
    </div>

    <c:forEach var="piso" items="${pisos}">
        <div class="parking-floor shadow-sm">
            
            <div class="floor-label">
                <i class="bi bi-layers-fill me-2 text-info"></i> ${piso.nombrePiso}
            </div>
            
            <div class="parking-grid">
                
                <c:forEach var="espacio" items="${piso.espacios}">
                    
                    <c:set var="isMyCar" value="${not empty miEspacioId and miEspacioId == espacio.idEspacio}" />
                    
                    <div class="parking-slot 
                        ${isMyCar ? 'my-car-zone' : (espacio.estado == 'LIBRE' ? 'slot-free' : (espacio.estado == 'OCUPADO' ? 'slot-occupied' : 'slot-maintenance'))}
                    ">
                        
                        <c:if test="${isMyCar}">
                            <div class="you-are-here">AQUÍ ESTÁS</div>
                        </c:if>

                        <div class="slot-number">${espacio.numeroEspacio}</div>
                        
                        <div class="car-icon-container">
                            <c:choose>
                                <c:when test="${espacio.estado == 'LIBRE'}">
                                    <i class="bi bi-p-square text-success opacity-25"></i>
                                </c:when>
                                <c:when test="${espacio.estado == 'OCUPADO' or isMyCar}">
                                    <i class="bi bi-car-front-fill"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-cone-striped"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="slot-status">
                            <c:choose>
                                <c:when test="${isMyCar}">TU AUTO</c:when>
                                <c:otherwise>${espacio.estado}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                </c:forEach>
                
                <c:if test="${empty piso.espacios}">
                    <div class="col-12 text-center text-muted py-5 w-100">
                        <i class="bi bi-cone-striped fs-1 d-block mb-2 opacity-50"></i>
                        Este piso aún no tiene espacios habilitados.
                    </div>
                </c:if>

            </div>
        </div>
    </c:forEach>

</div>

<jsp:include page="cliente_footer.jsp" />