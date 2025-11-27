<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Portal de Cliente</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Outfit', sans-serif;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /* MISMO FONDO "MIDNIGHT BLUE" QUE EL HEADER */
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(30, 58, 138, 0.8) 100%), 
                        url('https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?q=80&w=1920&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.1); /* Cristal Oscuro */
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            padding: 3rem;
            width: 100%;
            max-width: 450px;
            color: white;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white !important;
            padding: 0.8rem 1rem;
            border-radius: 12px;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: #4facfe; /* Azul neón al foco */
            box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.2);
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        /* Labels flotantes personalizados para fondo oscuro */
        .form-floating > label {
            color: rgba(255, 255, 255, 0.7);
        }
        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label {
            color: #4facfe;
            background-color: transparent !important; 
        }

        .btn-primary-theme {
            background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%); /* Gradiente Azul Brillante */
            border: none;
            padding: 1rem;
            font-weight: 700;
            letter-spacing: 1px;
            border-radius: 50px;
            transition: all 0.3s;
            box-shadow: 0 10px 20px rgba(0, 114, 255, 0.3);
        }

        .btn-primary-theme:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 30px rgba(0, 114, 255, 0.4);
            background: linear-gradient(135deg, #0072ff 0%, #00c6ff 100%);
        }

        .link-light-opacity {
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            transition: color 0.2s;
        }
        .link-light-opacity:hover {
            color: white;
        }
    </style>
</head>
<body>

    <div class="login-card animate__animated animate__fadeInUp">
        <div class="text-center mb-5">
            <div class="bg-white bg-opacity-10 rounded-circle d-inline-flex p-3 mb-3">
                <i class="bi bi-shield-check-fill text-info" style="font-size: 3rem;"></i>
            </div>
            <h2 class="fw-bold mb-1">Bienvenido</h2>
            <p class="text-white-50">Accede a tu portal de cliente</p>
        </div>

        <form action="<c:url value='/cliente/login' />" method="post">
            
            <div class="form-floating mb-3">
                <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI" required>
                <label for="dni"><i class="bi bi-person-vcard me-2"></i>DNI / Documento</label>
            </div>

            <div class="form-floating mb-4">
                <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                <label for="contrasena"><i class="bi bi-lock me-2"></i>Contraseña</label>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 bg-danger bg-opacity-25 text-white d-flex align-items-center p-3 rounded-3 mb-4" role="alert">
                   <i class="bi bi-exclamation-circle-fill me-3 flex-shrink-0 fs-5"></i>
                   <div class="small">${error}</div>
                </div>
            </c:if>
            
            <button class="w-100 btn btn-primary-theme text-white mb-4" type="submit">
                INGRESAR
            </button>
            
            <div class="d-grid gap-2">
                        <a href="<c:url value='/registro' />" class="btn btn-outline-secondary border-0 btn-sm rounded-pill py-2 fw-bold" style="background: rgba(0,0,0,0.03);">
                            <i class="bi bi-person-plus me-1"></i> Crear Cuenta Nueva
                        </a>                
                        </div>
                </form>
    </div>

</body>
</html>