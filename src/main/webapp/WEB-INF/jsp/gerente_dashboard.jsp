<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="Dashboard Gerencial" />
</jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Outfit', sans-serif;
        background-color: #f4f7f6;
    }

    /* Tarjetas de KPI (Métricas) */
    .kpi-card {
        border: none;
        border-radius: 16px;
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        position: relative;
    }
    
    .kpi-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
    }

    .kpi-icon-bg {
        position: absolute;
        right: -15px;
        bottom: -15px;
        font-size: 6rem;
        opacity: 0.15;
        transform: rotate(-15deg);
        pointer-events: none;
    }

    .kpi-value {
        font-size: 2.5rem;
        font-weight: 700;
        line-height: 1.2;
    }

    .kpi-label {
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 1px;
        opacity: 0.9;
        font-weight: 600;
    }

    /* Tarjetas de Acción (Navegación) */
    .action-card {
        border: none;
        border-radius: 20px;
        background: white;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        overflow: hidden;
        height: 100%;
        position: relative;
        z-index: 1;
        text-decoration: none; /* Para cuando envuelva el enlace */
    }

    .action-card::before {
        content: "";
        position: absolute;
        top: 0; left: 0; width: 100%; height: 100%;
        background: linear-gradient(135deg, rgba(13, 110, 253, 0.05) 0%, rgba(13, 110, 253, 0) 100%);
        opacity: 0;
        transition: opacity 0.3s ease;
        z-index: -1;
    }

    .action-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.1);
    }

    .action-card:hover::before {
        opacity: 1;
    }

    .action-icon-circle {
        width: 70px;
        height: 70px;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 2rem;
        margin-bottom: 1.5rem;
        transition: transform 0.3s ease;
    }

    .action-card:hover .action-icon-circle {
        transform: scale(1.1) rotate(5deg);
    }
    
    .action-title {
        color: #212529;
        font-weight: 700;
        margin-bottom: 0.5rem;
        transition: color 0.3s;
    }
    
    .action-card:hover .action-title {
        color: #0d6efd;
    }

    /* Colores Personalizados */
    .bg-gradient-blue { background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); }
    .bg-gradient-cyan { background: linear-gradient(135deg, #06b6d4 0%, #0891b2 100%); }
    .bg-gradient-purple { background: linear-gradient(135deg, #8b5cf6 0%, #7c3aed 100%); }
</style>

<div class="container-fluid px-4 py-5">
    
    <div class="d-flex justify-content-between align-items-end mb-5">
        <div>
            <h6 class="text-uppercase text-muted fw-bold mb-1 ls-1">Vista General</h6>
            <h1 class="fw-bold text-dark mb-0">Hola, ${empleadoLogueado.nombres}</h1>
            <p class="text-muted mt-2 mb-0">Aquí tienes el resumen operativo de hoy.</p>
        </div>
        <div>
            <span class="badge bg-light text-dark border px-3 py-2 rounded-pill shadow-sm">
                <i class="bi bi-building me-2 text-primary"></i> Sede Principal
            </span>
        </div>
    </div>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="kpi-card bg-gradient-blue text-white p-4 shadow">
                <i class="bi bi-people-fill kpi-icon-bg"></i>
                <div class="kpi-label">Personal Activo</div>
                <div class="kpi-value mt-2">${kpi_total_empleados}</div>
                <div class="mt-3 small opacity-75">
                    <i class="bi bi-arrow-up-circle-fill me-1"></i> Equipo operativo
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="kpi-card bg-gradient-cyan text-white p-4 shadow">
                <i class="bi bi-car-front-fill kpi-icon-bg"></i>
                <div class="kpi-label">Vehículos en Sitio</div>
                <div class="kpi-value mt-2">${kpi_vehiculos_ahora}</div>
                <div class="mt-3 small opacity-75">
                    <i class="bi bi-clock-history me-1"></i> Tiempo real
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="kpi-card bg-gradient-purple text-white p-4 shadow">
                <i class="bi bi-grid-3x3-gap-fill kpi-icon-bg"></i>
                <div class="kpi-label">Capacidad Total</div>
                <div class="kpi-value mt-2">${kpi_total_espacios}</div>
                <div class="mt-3 small opacity-75">
                    <i class="bi bi-check-circle me-1"></i> Plazas configuradas
                </div>
            </div>
        </div>
    </div>

    <h4 class="fw-bold text-dark mb-4"><i class="bi bi-sliders me-2"></i>Gestión Administrativa</h4>
    
    <div class="row g-4">
        
        <div class="col-md-6">
            <a href="<c:url value='/gerente/empleados' />" class="text-decoration-none">
                <div class="action-card shadow-sm p-4 p-lg-5 d-flex align-items-center">
                    <div class="action-icon-circle bg-primary bg-opacity-10 text-primary me-4">
                        <i class="bi bi-person-lines-fill"></i>
                    </div>
                    <div>
                        <h4 class="action-title">Gestionar Empleados</h4>
                        <p class="text-muted mb-0">Administra el personal de recepción y vigilancia. Crea cuentas, edita perfiles y controla accesos.</p>
                        <div class="mt-3 btn btn-outline-primary rounded-pill fw-bold px-4 btn-sm">
                            Acceder <i class="bi bi-arrow-right ms-1"></i>
                        </div>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-6">
            <a href="<c:url value='/gerente/espacios' />" class="text-decoration-none">
                <div class="action-card shadow-sm p-4 p-lg-5 d-flex align-items-center">
                    <div class="action-icon-circle bg-success bg-opacity-10 text-success me-4">
                        <i class="bi bi-p-square-fill"></i>
                    </div>
                    <div>
                        <h4 class="action-title">Infraestructura</h4>
                        <p class="text-muted mb-0">Configura la distribución de tu sede. Añade pisos, habilita espacios y gestiona el mantenimiento.</p>
                        <div class="mt-3 btn btn-outline-success rounded-pill fw-bold px-4 btn-sm">
                            Configurar <i class="bi bi-arrow-right ms-1"></i>
                        </div>
                    </div>
                </div>
            </a>
        </div>

    </div>
    
    <div class="mt-5 pt-4 border-top text-center text-muted small">
        &copy; 2025 Estación Resguarda - Panel de Control Gerencial
    </div>
</div>

<jsp:include page="footer.jsp" />