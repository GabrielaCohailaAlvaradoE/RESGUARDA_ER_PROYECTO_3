<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Acceso Administrativo - Resguarda</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Outfit', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* Fondo Corporativo Serio */
            background: linear-gradient(rgba(15, 23, 42, 0.85), rgba(15, 23, 42, 0.95)), 
                        url('https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=2000&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95); /* Blanco casi sólido para legibilidad */
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            padding: 3rem;
            width: 100%;
            max-width: 420px;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .form-control {
            background-color: #f1f5f9;
            border: 1px solid transparent;
            padding: 0.8rem 1rem;
            font-weight: 500;
        }
        
        .form-control:focus {
            background-color: white;
            border-color: #0d6efd;
            box-shadow: 0 0 0 4px rgba(13, 110, 253, 0.15);
        }

        .btn-primary-corp {
            background: #0f172a; /* Azul Medianoche */
            color: white;
            border: none;
            padding: 0.8rem;
            font-weight: 600;
            letter-spacing: 0.5px;
            border-radius: 12px;
            transition: all 0.3s;
        }
        
        .btn-primary-corp:hover {
            background: #1e293b;
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(15, 23, 42, 0.2);
        }
        
        .client-link {
            text-decoration: none;
            color: #64748b;
            font-size: 0.9rem;
            transition: color 0.2s;
        }
        .client-link:hover { color: #0d6efd; }
    </style>
</head>
<body>

    <main class="login-card">
        <div class="text-center mb-4">
            <div class="d-inline-flex align-items-center justify-content-center bg-dark text-white rounded-3 p-3 mb-3 shadow-sm">
                <i class="bi bi-building-fill-lock" style="font-size: 2rem;"></i>
            </div>
            <h4 class="fw-bold text-dark mb-1">Estación Resguarda</h4>
            <p class="text-muted small text-uppercase fw-bold" style="letter-spacing: 1px;">Acceso Corporativo</p>
        </div>

        <form action="<c:url value='/login' />" method="post">
            
            <div class="form-floating mb-3">
                <input type="text" class="form-control rounded-3" id="usuario" name="usuario" placeholder="Usuario" required>
                <label for="usuario"><i class="bi bi-person-fill me-2 text-muted"></i>Usuario</label>
            </div>

            <div class="form-floating mb-4">
                <input type="password" class="form-control rounded-3" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                <label for="contrasena"><i class="bi bi-shield-lock-fill me-2 text-muted"></i>Contraseña</label>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 bg-danger bg-opacity-10 text-danger d-flex align-items-center p-2 rounded-3 mb-3 small" role="alert">
                   <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                </div>
            </c:if>
            
            <button class="w-100 btn btn-primary-corp mb-4" type="submit">
                INICIAR SESIÓN
            </button>
            
            <div class="text-center border-top pt-3">
                <p class="small text-muted mb-2">¿Eres usuario del estacionamiento?</p>
                <a href="<c:url value='/cliente/login' />" class="btn btn-outline-primary w-100 rounded-3 fw-bold btn-sm py-2">
                    <i class="bi bi-arrow-right-circle me-2"></i> Ir al Portal de Clientes
                </a>
            </div>
        </form>
    </main>

</body>
</html>