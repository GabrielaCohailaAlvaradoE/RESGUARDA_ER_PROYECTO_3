<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Panel Ejecutivo" />
</jsp:include>

<style>
    .kpi-card {
        background: white;
        border: 1px solid rgba(0,0,0,0.05);
        border-radius: 12px;
        padding: 25px;
        transition: all 0.3s;
        position: relative;
        overflow: hidden;
    }
    .kpi-card:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.1); }
    .kpi-icon {
        position: absolute;
        right: -10px;
        bottom: -10px;
        font-size: 5rem;
        opacity: 0.1;
        transform: rotate(-15deg);
    }
    .kpi-value { font-size: 2.5rem; font-weight: 800; color: #1e293b; }
    .kpi-label { text-transform: uppercase; letter-spacing: 1px; font-size: 0.75rem; color: #64748b; font-weight: 700; }
    
    .action-card {
        background: #1e293b; /* Dark Slate */
        color: white;
        border-radius: 15px;
        padding: 30px;
        text-align: center;
        transition: all 0.3s;
        height: 100%;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        text-decoration: none;
    }
    .action-card:hover { background: #0f172a; color: #fff; transform: scale(1.03); }
    .action-icon { font-size: 3rem; margin-bottom: 15px; color: #38bdf8; }
</style>

<div class="container-fluid px-5 py-5">
    
    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h6 class="text-uppercase text-muted fw-bold mb-1">Vista General</h6>
            <h1 class="fw-bold text-dark">Panel Administrativo (CEO)</h1>
        </div>
        <div>
            <span class="badge bg-dark p-2 px-3 rounded-pill">
                <i class="bi bi-building-fill me-1"></i> Estación Resguarda Global
            </span>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-3">
            <div class="kpi-card border-start border-5 border-primary">
                <div class="kpi-label">Ingresos Totales</div>
                <div class="kpi-value text-primary">S/ ${kpi_ingresos}</div>
                <i class="bi bi-cash-stack kpi-icon"></i>
            </div>
        </div>
        <div class="col-md-3">
            <div class="kpi-card border-start border-5 border-success">
                <div class="kpi-label">Clientes Registrados</div>
                <div class="kpi-value text-success">${kpi_clientes}</div>
                <i class="bi bi-people-fill kpi-icon"></i>
            </div>
        </div>
        <div class="col-md-3">
            <div class="kpi-card border-start border-5 border-info">
                <div class="kpi-label">Sedes Activas</div>
                <div class="kpi-value text-info">${kpi_sedes}</div>
                <i class="bi bi-buildings-fill kpi-icon"></i>
            </div>
        </div>
        <div class="col-md-3">
            <div class="kpi-card border-start border-5 border-warning">
                <div class="kpi-label">Personal Total</div>
                <div class="kpi-value text-warning">${kpi_empleados}</div>
                <i class="bi bi-person-badge-fill kpi-icon"></i>
            </div>
        </div>
    </div>

    <h5 class="fw-bold text-dark mb-4">Gestión Estratégica</h5>
    
    <div class="row g-4">
        <div class="col-md-3">
            <a href="<c:url value='/admin/sedes' />" class="action-card shadow">
                <i class="bi bi-buildings action-icon"></i>
                <h5 class="fw-bold">Gestión de Sedes</h5>
                <small class="text-white-50">Crear y configurar locales</small>
            </a>
        </div>
        <div class="col-md-3">
            <a href="<c:url value='/admin/gerentes' />" class="action-card shadow">
                <i class="bi bi-briefcase-fill action-icon text-warning"></i>
                <h5 class="fw-bold">Gerentes de Sede</h5>
                <small class="text-white-50">Asignar administradores</small>
            </a>
        </div>
        <div class="col-md-3">
            <a href="<c:url value='/admin/tarifas' />" class="action-card shadow">
                <i class="bi bi-tags-fill action-icon text-success"></i>
                <h5 class="fw-bold">Tarifas Globales</h5>
                <small class="text-white-50">Configurar precios</small>
            </a>
        </div>
        <div class="col-md-3">
            <a href="<c:url value='/admin/reportes' />" class="action-card shadow">
                <i class="bi bi-file-earmark-bar-graph-fill action-icon text-danger"></i>
                <h5 class="fw-bold">Reportes Consolidados</h5>
                <small class="text-white-50">Auditoría completa</small>
            </a>
        </div>
    </div>

</div>

<jsp:include page="footer.jsp" />