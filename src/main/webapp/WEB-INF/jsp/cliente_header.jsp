<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titulo} - Portal de Cliente</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Outfit', sans-serif;
            background-color: #f4f6f9;
        }

        /* HERO BANNER PREMIUM (MIDNIGHT BLUE) */
        .hero-header {
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(30, 58, 138, 0.8) 100%), 
                        url('https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?q=80&w=1920&auto=format&fit=crop');
            background-size: cover;
            background-position: center center;
            background-attachment: fixed;
            padding-bottom: 5rem;
            border-bottom-left-radius: 40px;
            border-bottom-right-radius: 40px;
            box-shadow: 0 20px 40px rgba(15, 23, 42, 0.2);
            margin-bottom: -3rem;
            position: relative;
        }

        /* NAVBAR GLASSMORPHISM */
        .navbar-glass {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .navbar-brand { font-weight: 800; letter-spacing: 1px; text-transform: uppercase; color: white !important; }

        .nav-link {
            color: rgba(255,255,255,0.85) !important;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.6rem 1.2rem;
            border-radius: 50px;
            margin: 0 2px;
        }
        .nav-link:hover { background: rgba(255,255,255,0.15); color: #fff !important; transform: translateY(-2px); }
        .nav-link.active { background: rgba(255, 255, 255, 0.25); color: #fff !important; font-weight: 700; }

        /* MENÚS DE USUARIO Y NOTIFICACIONES */
        .user-pill {
            background: rgba(0,0,0,0.2);
            border: 1px solid rgba(255,255,255,0.2);
            border-radius: 50px;
            padding: 6px 20px;
            transition: all 0.3s;
        }
        .user-pill:hover { background: rgba(255,255,255,0.15); }

        .dropdown-menu-animate {
            animation: fadeInDown 0.3s cubic-bezier(0.68, -0.55, 0.27, 1.55);
            border: none;
            box-shadow: 0 15px 50px rgba(0,0,0,0.2);
            border-radius: 15px;
            overflow: hidden;
            margin-top: 15px;
        }
        @keyframes fadeInDown { from { opacity: 0; transform: translateY(-20px); } to { opacity: 1; transform: translateY(0); } }

        .page-title-large {
            font-size: 3rem; font-weight: 800; color: white;
            text-shadow: 0 4px 20px rgba(0,0,0,0.5); 
            margin-top: 3rem; letter-spacing: -1px;
        }
        
        main.container-fluid { position: relative; z-index: 10; max-width: 1400px; }
    </style>
</head>
<body>

    <header class="hero-header">
        <nav class="navbar navbar-expand-lg navbar-dark navbar-glass py-3">
            <div class="container-fluid px-4">
                <a class="navbar-brand d-flex align-items-center" href="<c:url value='/cliente/reservas' />">
                    <i class="bi bi-shield-check-fill me-2 fs-3 text-success"></i> 
                    RESGUARDA <span class="fw-light ms-2 opacity-75 border-start ps-2 border-light" style="font-size: 0.9rem;">CLIENTE</span>
                </a>
                
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCliente">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarCliente">
                    <ul class="navbar-nav mx-auto mb-2 mb-lg-0 gap-2">
                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Mis Reservas' ? 'active' : ''}" href="<c:url value='/cliente/reservas' />">
                                <i class="bi bi-calendar2-check me-1"></i> Reservas
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Mapa en Vivo' ? 'active' : ''}" href="<c:url value='/cliente/mapa' />">
                                <i class="bi bi-geo-alt-fill me-1"></i> Mapa
                            </a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Mis Vehículos' ? 'active' : ''}" href="<c:url value='/cliente/vehiculos' />">
                                <i class="bi bi-car-front me-1"></i> Vehículos
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Seguridad y Pagos' ? 'active' : ''}" href="<c:url value='/cliente/seguridad' />">
                                <i class="bi bi-wallet2 me-1"></i> Pagos
                            </a>
                        </li>
                    </ul>
                    
                    <ul class="navbar-nav align-items-center gap-2">
                        
                        <li class="nav-item dropdown">
                            <a class="nav-link position-relative me-2" href="#" id="notifDropdown" role="button" data-bs-toggle="dropdown">
                                <i class="bi bi-bell-fill fs-5"></i>
                                <c:if test="${alertasNoLeidas > 0}">
                                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger border border-light p-1" style="font-size: 0.5rem;">
                                        ${alertasNoLeidas}
                                    </span>
                                </c:if>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-animate shadow-lg" aria-labelledby="notifDropdown" style="width: 320px; max-height: 400px; overflow-y: auto;">
                                <li class="px-3 py-2 fw-bold text-muted small border-bottom bg-light">NOTIFICACIONES</li>
                                <c:choose>
                                    <c:when test="${not empty alertas}">
                                        <c:forEach var="alerta" items="${alertas}">
                                            <li><a class="dropdown-item py-3 border-bottom" href="#">
                                                <div class="d-flex align-items-start">
                                                    <div class="me-3 mt-1">
                                                        <c:choose>
                                                            <c:when test="${alerta.tipo == 'ADVERTENCIA'}"><i class="bi bi-exclamation-circle-fill text-warning fs-5"></i></c:when>
                                                            <c:when test="${alerta.tipo == 'EXITO'}"><i class="bi bi-check-circle-fill text-success fs-5"></i></c:when>
                                                            <c:otherwise><i class="bi bi-info-circle-fill text-primary fs-5"></i></c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div>
                                                        <h6 class="mb-1 fs-6 fw-bold ${alerta.leida ? 'text-muted' : 'text-dark'}">${alerta.titulo}</h6>
                                                        <p class="mb-1 small text-muted text-wrap" style="line-height: 1.3;">${alerta.mensaje}</p>
                                                        <small class="text-secondary" style="font-size: 0.7rem;">Reciente</small>
                                                    </div>
                                                </div>
                                            </a></li>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise><li class="text-center py-4 text-muted small">Sin notificaciones nuevas.</li></c:otherwise>
                                </c:choose>
                            </ul>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle user-pill d-flex align-items-center" href="#" id="navbarUserMenu" role="button" data-bs-toggle="dropdown">
                                <img src="https://ui-avatars.com/api/?name=${clienteLogueado.nombres}&background=0d6efd&color=fff&bold=true" class="rounded-circle me-2 shadow-sm" width="32" height="32">
                                <span class="fw-bold text-white small text-uppercase">${clienteLogueado.nombres}</span>
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end dropdown-menu-animate" aria-labelledby="navbarUserMenu">
                                <li class="px-3 py-2 text-muted small border-bottom fw-bold bg-light">MI CUENTA</li>
                                <li><a class="dropdown-item mt-1" href="<c:url value='/cliente/perfil' />"><i class="bi bi-person-gear me-2 text-primary"></i> Editar Perfil</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item text-danger fw-bold" href="<c:url value='/logout2' />"><i class="bi bi-power me-2"></i> Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container-fluid px-4 text-start">
            <div class="row">
                <div class="col-lg-8">
                    <h1 class="page-title-large">${titulo}</h1>
                    <p class="page-subtitle text-white-50 fs-5">Bienvenido al sistema de gestión inteligente.</p>
                </div>
            </div>
        </div>
    </header>

    <main class="container-fluid mt-5 px-4">