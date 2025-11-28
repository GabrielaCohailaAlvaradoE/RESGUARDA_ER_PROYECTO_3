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
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/theme.css' />">
    
    <style>
  body[data-theme="dark"] .form-control,
  body[data-theme="dark"] .form-select{
      color:var(--text-color) !important;
      background:var(--input-bg) !important;
      border-color:var(--border-color) !important;
  }

  body[data-theme="dark"] .form-control::placeholder{
      color:rgba(231,240,255,.65) !important;
      opacity:1;
  }

  body[data-theme="dark"] .form-control[readonly],
  body[data-theme="dark"] .form-control:disabled{
      color:var(--text-color) !important;
      opacity:1 !important;
      background:rgba(255,255,255,.04) !important;
  }

  body[data-theme="dark"] input:-webkit-autofill,
  body[data-theme="dark"] input:-webkit-autofill:hover,
  body[data-theme="dark"] input:-webkit-autofill:focus{
      -webkit-text-fill-color:var(--text-color) !important;
      box-shadow:0 0 0 1000px var(--input-bg) inset !important;
      transition:background-color 9999s ease-in-out 0s;
  }

  body[data-theme="dark"] .input-group .btn,
  body[data-theme="dark"] .password-toggle-btn{
      color:var(--text-color) !important;
      border-color:var(--border-color) !important;
      background:rgba(255,255,255,.06) !important;
  }
    </style>

</head>

<body class="app-body hero-auth" data-theme="dark">
    <div class="position-absolute top-0 end-0 p-3">
        <button class="btn theme-toggle" type="button" id="themeToggle" aria-label="Cambiar tema"><i class="bi bi-moon-stars-fill"></i></button>
    </div>
    <div class="parallax-wrapper w-100 d-flex justify-content-center">
        <div class="auth-card tilt-card card-blur">
            <div class="text-center mb-4">
                
                <img src="<c:url value='/assets/img/LogoWhite.png' />" class="brand-logo mb-2" data-light="<c:url value='/assets/img/LogoNegro.png' />" data-dark="<c:url value='/assets/img/LogoWhite.png' />" alt="Resguarda">
                <h4 class="fw-bold">Bienvenido</h4>
                <p class="text-muted-premium mb-0">Accede a tu portal de cliente</p>
            </div>
            <form action="<c:url value='/cliente/login' />" method="post" class="d-grid gap-3">
                <div>
                    <label for="dni" class="form-label small-label">DNI / Documento</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-vcard"></i></span>
                        <input type="text" class="form-control" id="dni" name="dni" placeholder="DNI" required>
                    </div>
                </div>
                <div>
                    <label for="contrasena" class="form-label small-label">Contraseña</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                        <button class="btn password-toggle-btn toggle-password" type="button" aria-label="Mostrar contraseña"><i class="bi bi-eye"></i></button>
                    </div>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-premium alert-danger d-flex align-items-center gap-2" role="alert">
                        <i class="bi bi-exclamation-circle"></i><span>${error}</span>
                    </div>
                </c:if>
                <button class="btn btn-gradient w-100 py-2" type="submit">Ingresar</button>
                <div class="d-grid gap-2">
                    <a href="<c:url value='/registro' />" class="btn btn-ghost fw-semibold">
                        <i class="bi bi-person-plus me-2"></i>Crear cuenta nueva
                    </a>
                </div>
            </form>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/assets/js/theme.js' />"></script>
</body>
</html>