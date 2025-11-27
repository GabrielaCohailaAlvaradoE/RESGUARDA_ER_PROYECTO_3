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
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Outfit', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
            
            /* MISMO FONDO "MIDNIGHT BLUE" */
            background: linear-gradient(135deg, rgba(15, 23, 42, 0.9) 0%, rgba(30, 58, 138, 0.8) 100%), 
                        url('https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?q=80&w=1920&auto=format&fit=crop');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .register-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            color: white;
            overflow: hidden;
            width: 100%;
            max-width: 800px;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white !important;
            padding: 0.7rem 1rem;
        }
        
        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            border-color: #4facfe;
            box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.2);
        }
        
        .form-control::placeholder { color: rgba(255,255,255,0.4); }
        
        /* Estilo para input con botón */
        .input-group .btn-search {
            background: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.2);
            color: white;
        }
        .input-group .btn-search:hover {
            background: #4facfe;
            border-color: #4facfe;
        }

        .step-badge {
            background: rgba(255,255,255,0.15);
            color: #4facfe;
            width: 30px; height: 30px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            margin-right: 10px;
            font-weight: bold;
        }

        .btn-success-gradient {
            background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
            border: none;
            padding: 1rem;
            font-weight: 700;
            letter-spacing: 1px;
        }
        .btn-success-gradient:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 114, 255, 0.4);
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="register-card">
                    <div class="p-5">
                        <div class="text-center mb-5">
                            <h2 class="fw-bold mb-1">Crear Cuenta Nueva</h2>
                            <p class="text-white-50">Únete a Resguarda y gestiona tus reservas fácilmente.</p>
                        </div>

                        <form id="registroForm" action="<c:url value='/registroCliente' />" method="post">
                            
                            <div class="row g-4">
                                <div class="col-12">
                                    <label class="form-label small text-uppercase text-white-50 fw-bold"><span class="step-badge">1</span> Identidad</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="dni" name="dni" placeholder="Ingresa tu DNI" required>
                                        <button class="btn btn-search" type="button" id="btnConsultarDni">
                                            <i class="bi bi-search me-2"></i>Validar DNI
                                        </button>
                                    </div>
                                    <div id="dniError" class="text-danger mt-2 small" style="display:none;"></div>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small text-uppercase text-white-50 fw-bold"><span class="step-badge">2</span> Datos Personales</label>
                                    <input type="text" class="form-control mb-3" id="nombres" name="nombres" placeholder="Nombres" readonly required>
                                    <input type="text" class="form-control" id="apellidos" name="apellidos" placeholder="Apellidos" readonly required>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label small text-uppercase text-white-50 fw-bold"><span class="step-badge">3</span> Credenciales</label>
                                    <input type="email" class="form-control mb-3" id="email" name="email" placeholder="Correo Electrónico" required>
                                    <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="Crear Contraseña" required>
                                </div>
                            </div>

                            <c:if test="${not empty error}">
                                <div class="alert alert-danger border-0 bg-danger bg-opacity-25 text-white mt-4 rounded-3">
                                   <i class="bi bi-exclamation-circle-fill me-2"></i> ${error}
                                </div>
                            </c:if>

                            <div class="mt-5 pt-3 border-top border-white border-opacity-10">
                                <button type="submit" class="w-100 btn btn-success-gradient text-white rounded-pill shadow-lg" id="btnRegistrar" disabled>
                                    COMPLETAR REGISTRO <i class="bi bi-arrow-right-short ms-1"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <div class="bg-black bg-opacity-25 p-3 text-center">
                        <a href="<c:url value='/cliente/login' />" class="text-white-50 text-decoration-none small">
                            ¿Ya tienes una cuenta? <span class="text-white fw-bold">Inicia Sesión aquí</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('btnConsultarDni').addEventListener('click', function() {
            const dni = document.getElementById('dni').value;
            const btnConsultar = this;
            const dniError = document.getElementById('dniError');
            const btnRegistrar = document.getElementById('btnRegistrar');

            // Resetear
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
                    btnConsultar.classList.replace('btn-search', 'btn-success');
                })
                .catch(error => {
                    dniError.textContent = 'Error: DNI no válido o no encontrado en RENIEC.';
                    dniError.style.display = 'block';
                    document.getElementById('nombres').value = '';
                    document.getElementById('apellidos').value = '';
                    btnConsultar.innerHTML = '<i class="bi bi-search me-2"></i>Validar DNI';
                })
                .finally(() => {
                    if(document.getElementById('nombres').value === '') btnConsultar.disabled = false;
                });
        });
    </script>
    
</body>
</html>