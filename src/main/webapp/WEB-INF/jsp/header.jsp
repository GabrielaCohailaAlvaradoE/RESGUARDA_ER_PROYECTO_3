<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${titulo} - Estación Resguarda</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            --hover-bg: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: #f4f6f9; /* Gris muy suave para el fondo general */
        }

        /* Navbar Personalizado */
        .navbar-pro {
            background: var(--primary-gradient);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            padding: 0.8rem 1rem;
        }

        .navbar-brand {
            font-weight: 700;
            letter-spacing: 0.5px;
            font-size: 1.25rem;
        }

        .nav-link {
            font-weight: 500;
            color: rgba(255,255,255,0.85) !important;
            transition: all 0.3s ease;
            border-radius: 8px;
            padding: 0.5rem 1rem !important;
            margin: 0 0.2rem;
        }

        .nav-link:hover, .nav-link.active {
            color: #fff !important;
            background-color: var(--hover-bg);
            transform: translateY(-1px);
        }

        .nav-link i {
            margin-right: 6px;
        }

        /* Perfil de Usuario */
        .user-profile-btn {
            background: rgba(255, 255, 255, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white !important;
            border-radius: 50px;
            padding: 0.4rem 1.2rem !important;
            font-size: 0.9rem;
        }
        
        .user-profile-btn:hover {
            background: rgba(255, 255, 255, 0.25);
        }

        .dropdown-menu {
            border: none;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-radius: 12px;
            margin-top: 10px;
        }

        .dropdown-item {
            padding: 0.6rem 1.2rem;
            font-size: 0.95rem;
        }
        
        .dropdown-item:hover {
            background-color: #f8f9fa;
            color: #1e3c72;
        }

        /* Utilidad para el contenido principal */
        main.main-content {
            min-height: 80vh;
            padding-bottom: 3rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark navbar-pro sticky-top">
        <div class="container-fluid">
            <a class="navbar-brand d-flex align-items-center" href="#">
                <i class="bi bi-shield-check-fill me-2 fs-4"></i>
                ESTACIÓN RESGUARDA
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                    <c:if test="${empleadoLogueado.idRol == 3}"> <li class="nav-item">
                            <a class="nav-link ${titulo == 'Control de Operaciones' ? 'active' : ''}" href="<c:url value='/recepcion/dashboard' />">
                                <i class="bi bi-speedometer2"></i> Operaciones
                            </a>
                        </li>
                    </c:if>

                    <c:if test="${empleadoLogueado.idRol == 2}"> <li class="nav-item">
                            <a class="nav-link ${titulo == 'Dashboard Gerente' ? 'active' : ''}" href="<c:url value='/gerente/dashboard' />">
                                <i class="bi bi-graph-up-arrow"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link ${titulo == 'Gestión de Empleados' ? 'active' : ''}" href="<c:url value='/gerente/empleados' />">
                                <i class="bi bi-people"></i> Empleados
                            </a>
                        </li>
                         <li class="nav-item">
                            <a class="nav-link ${titulo == 'Gestión de Pisos y Espacios' ? 'active' : ''}" href="<c:url value='/gerente/espacios' />">
                                <i class="bi bi-grid"></i> Espacios
                            </a>
                        </li>
                    </c:if>
                </ul>

                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle user-profile-btn d-flex align-items-center" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person-circle me-2"></i>
                            <span>${empleadoLogueado.nombres}</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end animate slideIn" aria-labelledby="userDropdown">
                            <li><span class="dropdown-header text-uppercase small fw-bold">Mi Cuenta</span></li>
                            <li><a class="dropdown-item" href="#"><i class="bi bi-gear me-2"></i> Configuración</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger fw-bold" href="<c:url value='/logout' />">
                                    <i class="bi bi-box-arrow-right me-2"></i> Cerrar Sesión
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <main class="container-fluid mt-4 main-content">
