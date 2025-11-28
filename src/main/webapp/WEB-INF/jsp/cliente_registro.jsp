<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Registro - Portal de Cliente</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<c:url value='/assets/css/theme.css' />">

    <!-- SOLO AÑADIDO: fixes sin tocar tu theme -->
    <style>
        /* pasos separados */
        .step-label{
            display:flex;
            align-items:center;
            gap:.55rem;
            font-weight:700;
            color:var(--muted-text);
            margin-bottom:.5rem;
        }
        .step-badge{
            display:inline-flex;
            align-items:center;
            justify-content:center;
            width:1.7rem;
            height:1.7rem;
            border-radius:999px;
            font-size:.85rem;
            font-weight:800;
            line-height:1;
            background:rgba(79,176,255,.18);
            border:1px solid var(--border-color);
            color:var(--text-color);
            flex:0 0 auto;
        }

        /* inputs legibles en dark */
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
        <button class="btn theme-toggle" type="button" id="themeToggle" aria-label="Cambiar tema">
            <i class="bi bi-moon-stars-fill"></i>
        </button>
    </div>

    <!-- MISMO PATRÓN DE CENTRADO QUE LOGIN -->
    <div class="parallax-wrapper w-100 d-flex justify-content-center">
        <div class="auth-card tilt-card card-blur">

            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-3">
                <div>
                    <p class="section-title mb-2">
                        <span class="icon"><i class="bi bi-person-plus"></i></span>
                        Registro
                    </p>
                    <h3 class="fw-bold">Crear cuenta nueva</h3>
                    <p class="hero-subtitle">Únete a Resguarda y gestiona tus reservas fácilmente.</p>
                </div>

            </div>

            <form id="registroForm" action="<c:url value='/registroCliente' />" method="post" class="d-grid gap-4">

                <div class="row g-4">

                    <div class="col-12">
                        <label class="form-label small-label step-label">
                            <span class="step-badge">1</span>
                            <span>Identidad</span>
                        </label>

                        <div class="input-group">
                            <input type="text" class="form-control" id="dni" name="dni"
                                   placeholder="Ingresa tu DNI" required>
                            <button class="btn btn-ghost" type="button" id="btnConsultarDni">
                                <i class="bi bi-search me-2"></i>Validar DNI
                            </button>
                        </div>

                        <div id="dniError" class="text-danger mt-2 small" style="display:none;"></div>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small-label step-label">
                            <span class="step-badge">2</span>
                            <span>Datos personales</span>
                        </label>

                        <input type="text" class="form-control mb-3" id="nombres" name="nombres"
                               placeholder="Nombres" readonly required>
                        <input type="text" class="form-control" id="apellidos" name="apellidos"
                               placeholder="Apellidos" readonly required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label small-label step-label">
                            <span class="step-badge">3</span>
                            <span>Credenciales</span>
                        </label>

                        <input type="email" class="form-control mb-3" id="email" name="email"
                               placeholder="Correo Electrónico" required>

                        <div class="input-group">
                            <input type="password" class="form-control" id="contrasena" name="contrasena"
                                   placeholder="Crear Contraseña" required>
                            <button class="btn password-toggle-btn toggle-password" type="button"
                                    aria-label="Mostrar contraseña">
                                <i class="bi bi-eye"></i>
                            </button>
                        </div>
                    </div>

                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-premium alert-danger">
                        <i class="bi bi-exclamation-circle me-2"></i>${error}
                    </div>
                </c:if>

                <div class="pt-3 border-top border-secondary">
                    <button type="submit" class="btn btn-gradient w-100 py-3" id="btnRegistrar" disabled>
                        Completar Registro <i class="bi bi-arrow-right-short ms-1"></i>
                    </button>
                </div>

            </form>

            <div class="text-center mt-3">
                <a href="<c:url value='/cliente/login' />" class="link-muted text-decoration-none">
                    ¿Ya tienes una cuenta? <span class="fw-semibold text-primary">Inicia sesión aquí</span>
                </a>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/assets/js/theme.js' />"></script>

    <script>
        document.getElementById('btnConsultarDni').addEventListener('click', function() {
            const dni = document.getElementById('dni').value;
            const btnConsultar = this;
            const dniError = document.getElementById('dniError');
            const btnRegistrar = document.getElementById('btnRegistrar');

            btnConsultar.innerHTML = '<span class="spinner-border spinner-border-sm" role="status"></span> Validando...';
            btnConsultar.disabled = true;
            dniError.style.display = 'none';
            btnRegistrar.disabled = true;

            fetch('<c:url value="/api/consultarDni" />?dni=' + dni)
                .then(response => {
                    if (response.ok) return response.json();
                    throw new Error('DNI no encontrado o API falló.');
                })
                .then(data => {
                    document.getElementById('nombres').value = data.nombres;
                    document.getElementById('apellidos').value = data.apellidos;
                    btnRegistrar.disabled = false;
                    btnConsultar.innerHTML = '<i class="bi bi-check-lg me-2"></i>Validado';
                    btnConsultar.classList.replace('btn-ghost', 'btn-success');
                })
                .catch(error => {
                    dniError.textContent = 'Error: DNI no válido o no encontrado en RENIEC.';
                    dniError.style.display = 'block';
                    document.getElementById('nombres').value = '';
                    document.getElementById('apellidos').value = '';
                    btnConsultar.innerHTML = '<i class="bi bi-search me-2"></i>Validar DNI';
                    btnConsultar.disabled = false;
                });
        });
    </script>
</body>
</html>
