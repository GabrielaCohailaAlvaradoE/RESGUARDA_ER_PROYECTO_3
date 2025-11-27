<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    Object minObj = request.getAttribute("minutosTranscurridos");
    String tiempoFormateado = "0 min";
    
    if (minObj != null) {
        long totalMin = Long.parseLong(minObj.toString());
        long dias = totalMin / 1440;
        long restoDia = totalMin % 1440;
        long horas = restoDia / 60;
        long minutos = restoDia % 60;
        
        StringBuilder sb = new StringBuilder();
        if (dias > 0) sb.append(dias).append("d ");
        if (horas > 0) sb.append(horas).append("h ");
        sb.append(minutos).append("m");
        
        tiempoFormateado = sb.toString();
    }
    // Guardamos la variable formateada para usarla abajo
    request.setAttribute("tiempoFormateado", tiempoFormateado);
%>

<jsp:include page="cliente_header.jsp">
    <jsp:param name="titulo" value="Mis Reservas" />
</jsp:include>

<style>
    .card-active-parking {
        background-image: linear-gradient(to right, rgba(15, 23, 42, 0.95), rgba(15, 23, 42, 0.8)), 
                          url('https://images.unsplash.com/photo-1486006920555-c77dcf18193c?q=80&w=1000&auto=format&fit=crop');
        background-size: cover;
        background-position: center;
        border: none; color: white; border-radius: 1.5rem; overflow: hidden;
    }
    .card-modern { border: none; border-radius: 1rem; overflow: hidden; transition: transform 0.3s ease, box-shadow 0.3s ease; }
    .card-modern:hover { transform: translateY(-5px); box-shadow: 0 15px 30px rgba(0,0,0,0.1) !important; }
    .header-new-booking {
        background-image: linear-gradient(rgba(13, 110, 253, 0.85), rgba(13, 110, 253, 0.95)),
                          url('https://images.unsplash.com/photo-1506521781263-d8422e82f27a?q=80&w=1000&auto=format&fit=crop');
        background-size: cover; height: 120px; display: flex; align-items: center; justify-content: center;
    }
    /* Chatbot Styles */
    #chat-window { z-index: 10000; }
    .typing-indicator::after { content: '...'; animation: typing 1.5s infinite; }
    @keyframes typing { 0% { content: '.'; } 33% { content: '..'; } 66% { content: '...'; } }
    @keyframes slideInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
</style>

<div class="container-fluid px-4 py-5">

    <c:if test="${not empty exito}">
        <div class="alert alert-success border-0 shadow-sm d-flex align-items-center mb-4 rounded-3">
            <i class="bi bi-check-circle-fill me-3 fs-4"></i> <div>${exito}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger border-0 shadow-sm d-flex align-items-center mb-4 rounded-3">
            <i class="bi bi-exclamation-octagon-fill me-3 fs-4"></i> <div>${error}</div>
            <button type="button" class="btn-close ms-auto" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <c:if test="${not empty registroActivo}">
        <div class="card card-active-parking shadow-lg mb-5">
            <div class="card-body p-4 p-lg-5">
                <div class="row align-items-center">
                    <div class="col-lg-7 mb-4 mb-lg-0">
                        <span class="badge bg-success bg-gradient px-3 py-2 rounded-pill text-uppercase fw-bold shadow-sm mb-3">
                            <i class="bi bi-circle-fill me-2 small text-white"></i> En Curso
                        </span>
                        <h1 class="display-4 fw-bold mb-1 text-white">${registroActivo.vehiculo.placa}</h1>
                        <p class="fs-4 text-white-50 mb-4">Espacio <span class="text-white fw-bold border-bottom border-success">${registroActivo.espacio.numeroEspacio}</span></p>
                        <div class="d-flex gap-3">
                            <div class="bg-white bg-opacity-10 p-3 rounded-3 border border-white border-opacity-10 text-center" style="min-width: 120px;">
                                <small class="d-block text-uppercase fw-bold text-info mb-1" style="font-size: 0.7rem;">Tiempo</small>
                                <span class="fs-4 fw-bold text-white">${tiempoFormateado}</span>
                            </div>
                            <div class="bg-white bg-opacity-10 p-3 rounded-3 border border-white border-opacity-10 text-center" style="min-width: 120px;">
                                <small class="d-block text-uppercase fw-bold text-warning mb-1" style="font-size: 0.7rem;">Tarifa</small>
                                <span class="fs-4 fw-bold text-white">S/ ${tarifaActual}</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5 text-center">
                        <div class="bg-white p-3 rounded-4 shadow d-inline-block">
                            <canvas id="qr-code"></canvas>
                            <div class="mt-2 text-dark fw-bold font-monospace fs-5">${registroActivo.pinTemp}</div>
                        </div>
                        <p class="mt-3 text-white-50 small"><i class="bi bi-scan me-1"></i> Escanear en Salida</p>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <div class="row g-5">
        <div class="col-lg-5">
            <div class="card card-modern shadow h-100">
                <div class="header-new-booking text-white text-center p-4">
                    <div><h4 class="fw-bold mb-0"><i class="bi bi-calendar-plus me-2"></i>Nueva Reserva</h4></div>
                </div>
                <div class="card-body p-4">
                    <form action="<c:url value='/cliente/crearReserva' />" method="post">
                        <div class="mb-4">
                            <label class="form-label fw-bold text-muted small text-uppercase">Ubicación</label>
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="bi bi-geo-alt text-primary"></i></span>
                                <select id="espacio" name="idEspacio" class="form-select form-select-lg border-start-0" required>
                                    <option value="" selected disabled>Seleccione espacio...</option>
                                    <c:forEach var="piso" items="${pisos}">
                                        <optgroup label="${piso.nombrePiso}">
                                            <c:forEach var="espacio" items="${piso.espacios}">
                                                <c:if test="${espacio.estado == 'LIBRE'}">
                                                    <option value="${espacio.idEspacio}">${espacio.numeroEspacio}</option>
                                                </c:if>
                                            </c:forEach>
                                        </optgroup>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="alert alert-light border d-flex align-items-center mb-4">
                            <i class="bi bi-coin fs-4 me-3 text-warning"></i>
                            <div>
                                <small class="fw-bold d-block text-dark">Tarifa Reserva: S/ 5.00</small>
                                <small class="text-muted" style="font-size: 0.7rem;">Se cobra al finalizar.</small>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary w-100 py-3 fw-bold shadow-sm rounded-pill">CONFIRMAR RESERVA</button>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-lg-7">
            <div class="card card-modern shadow h-100">
                <div class="card-header bg-white border-0 py-4 px-4">
                    <h5 class="fw-bold mb-0 text-dark"><i class="bi bi-clock-history me-2 text-primary"></i>Actividad Reciente</h5>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="bg-light text-secondary text-uppercase small">
                                <tr>
                                    <th class="ps-4 py-3 border-0">Detalle</th>
                                    <th class="py-3 border-0">Fecha</th>
                                    <th class="py-3 border-0 text-center">Estado</th>
                                    <th class="pe-4 py-3 border-0 text-end">Acción</th>
                                </tr>
                            </thead>
                            <tbody class="border-top-0">
                                <c:choose>
                                    <c:when test="${empty misReservas}">
                                        <tr><td colspan="4" class="text-center py-5 text-muted">Sin reservas recientes.</td></tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="res" items="${misReservas}">
                                            <tr>
                                                <td class="ps-4">
                                                    <c:if test="${not empty res.espacio}">
                                                        <div class="fw-bold text-dark">${res.espacio.piso.nombrePiso}</div>
                                                        <small class="text-primary">${res.espacio.numeroEspacio}</small>
                                                    </c:if>
                                                    <c:if test="${empty res.espacio}">
                                                        <span class="text-muted fst-italic">Eliminado</span>
                                                    </c:if>
                                                </td>
                                                <td class="text-muted small">
                                                    ${res.fechaReserva} </td>
                                                <td class="text-center">
                                                    <span class="badge rounded-pill fw-normal px-3 ${res.estado == 'PENDIENTE' ? 'bg-warning text-dark' : (res.estado == 'FINALIZADA' ? 'bg-success' : 'bg-secondary')}">${res.estado}</span>
                                                </td>
                                                <td class="pe-4 text-end">
                                                    <c:if test="${res.estado == 'PENDIENTE'}">
                                                        <form action="<c:url value='/cliente/cancelarReserva' />" method="POST">
                                                            <input type="hidden" name="idReserva" value="${res.idReserva}">
                                                            <button type="submit" class="btn btn-outline-danger btn-sm rounded-circle" title="Cancelar"><i class="bi bi-x-lg"></i></button>
                                                        </form>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="chat-widget" style="position: fixed; bottom: 20px; right: 20px; z-index: 9999; font-family: 'Outfit', sans-serif;">
    <button id="chat-toggle" onclick="toggleChat()" class="btn btn-primary rounded-circle shadow-lg d-flex align-items-center justify-content-center" 
            style="width: 60px; height: 60px; transition: transform 0.3s; border: 4px solid white;">
        <i class="bi bi-chat-dots-fill fs-3"></i>
    </button>

    <div id="chat-window" class="card shadow-lg border-0 d-none" 
         style="width: 350px; height: 450px; position: absolute; bottom: 80px; right: 0; border-radius: 20px; overflow: hidden; animation: slideInUp 0.3s;">
        
        <div class="card-header bg-primary text-white p-3 d-flex align-items-center justify-content-between">
            <div class="d-flex align-items-center">
                <div class="bg-white text-primary rounded-circle d-flex align-items-center justify-content-center me-2" style="width: 35px; height: 35px;">
                    <i class="bi bi-robot fs-5"></i>
                </div>
                <div>
                    <h6 class="mb-0 fw-bold">ResguardaBot</h6>
                    <small class="opacity-75" style="font-size: 0.7rem;">● En línea ahora</small>
                </div>
            </div>
            <button onclick="toggleChat()" class="btn btn-sm btn-link text-white p-0"><i class="bi bi-x-lg"></i></button>
        </div>

        <div id="chat-messages" class="card-body bg-light overflow-auto p-3" style="height: 320px;">
            <div class="d-flex mb-3">
                <div class="bg-white p-3 rounded-3 shadow-sm border" style="max-width: 85%; border-radius: 15px 15px 15px 0;">
                    <small class="text-muted d-block mb-1 fw-bold">Asistente</small>
                    Hola <strong>${clienteLogueado.nombres}</strong>, soy tu asistente virtual. 👋<br>
                    ¿En qué puedo ayudarte hoy?
                </div>
            </div>
        </div>

        <div class="card-footer bg-white p-2 border-top">
            <div class="d-grid gap-2">
                <c:if test="${not empty registroActivo}">
                    <button onclick="askBot('pin')" class="btn btn-outline-primary btn-sm text-start rounded-pill px-3">
                        🔐 Olvidé mi PIN de salida
                    </button>
                    <button onclick="askBot('tarifa')" class="btn btn-outline-success btn-sm text-start rounded-pill px-3">
                        💰 ¿Cuánto debo pagar?
                    </button>
                </c:if>
                <c:if test="${empty registroActivo}">
                    <button onclick="askBot('reserva')" class="btn btn-outline-primary btn-sm text-start rounded-pill px-3">
                        📅 ¿Cómo reservo un espacio?
                    </button>
                </c:if>
                <button onclick="askBot('horario')" class="btn btn-outline-secondary btn-sm text-start rounded-pill px-3">
                    ⏰ Horarios de atención
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/qrious/4.0.2/qrious.min.js"></script>
<script>
    // 1. GENERACIÓN DE QR
    const canvas = document.getElementById('qr-code');
    if (canvas) {
        const pinValue = "${registroActivo.pinTemp}";
        var qr = new QRious({ element: canvas, value: pinValue, size: 130, level: 'H' });
    }

    // 2. LÓGICA DEL CHATBOT (ACTUALIZADA CON TIEMPO FORMATEADO)
    const botData = {
        pin: "${registroActivo.pinTemp}",
        placa: "${registroActivo.vehiculo.placa}",
        // Usamos la nueva variable formateada (ej. "1h 30m")
        tiempo: "${tiempoFormateado}",
        tarifa: "${tarifaActual}"
    };

    function toggleChat() {
        const window = document.getElementById('chat-window');
        const btn = document.getElementById('chat-toggle');
        
        if (window.classList.contains('d-none')) {
            window.classList.remove('d-none');
            btn.style.transform = 'rotate(0deg)';
        } else {
            window.classList.add('d-none');
            btn.style.transform = 'rotate(-90deg)';
        }
    }

    function askBot(topic) {
        const messages = document.getElementById('chat-messages');
        
        // Definir el texto del usuario
        let userText = "";
        if(topic === 'pin') userText = "Olvidé mi PIN de salida";
        else if(topic === 'tarifa') userText = "¿Cuánto debo pagar?";
        else if(topic === 'horario') userText = "¿Cuál es el horario?";
        else if(topic === 'reserva') userText = "¿Cómo reservo?";

        // Insertar mensaje del usuario (Burbuja Azul)
        const userMsgHTML = `
            <div class="d-flex mb-3 justify-content-end">
                <div class="bg-primary text-white p-3 rounded-3 shadow-sm" style="max-width: 85%; border-radius: 15px 15px 0 15px;">
                    ` + userText + `
                </div>
            </div>`;
        
        messages.insertAdjacentHTML('beforeend', userMsgHTML);
        messages.scrollTop = messages.scrollHeight;

        // Simular "Escribiendo..."
        const typingId = 'typing-' + Date.now();
        const typingHTML = `
            <div id="` + typingId + `" class="d-flex mb-3">
                <div class="bg-white p-3 rounded-3 shadow-sm border text-muted fst-italic" style="max-width: 85%; border-radius: 15px 15px 15px 0;">
                    Escribiendo<span class="typing-indicator"></span>
                </div>
            </div>`;
            
        messages.insertAdjacentHTML('beforeend', typingHTML);
        messages.scrollTop = messages.scrollHeight;

        // Responder después de 1 segundo
        setTimeout(() => {
            const typingElement = document.getElementById(typingId);
            if(typingElement) typingElement.remove();
            
            let botResponse = "";
            
            if (topic === 'pin') {
                botResponse = "Tu vehículo <b>" + botData.placa + "</b> tiene el código PIN: <br><h3 class='text-primary my-2'>" + botData.pin + "</h3>Muéstralo en la garita.";
            } else if (topic === 'tarifa') {
                // Respuesta actualizada usando la variable formateada
                botResponse = "Llevas estacionado <b>" + botData.tiempo + "</b>.<br>Tu tarifa acumulada es aprox: <b class='text-success'>S/ " + botData.tarifa + "</b>.";
            } else if (topic === 'horario') {
                botResponse = "Atendemos de Lunes a Domingo, las 24 horas del día. ¡Siempre seguros! 🛡️";
            } else if (topic === 'reserva') {
                botResponse = "Es fácil. Usa el panel 'Nueva Reserva' a tu izquierda, elige tu espacio favorito y confirma. ¡Te esperamos!";
            }

            const botMsgHTML = `
                <div class="d-flex mb-3">
                    <div class="bg-white p-3 rounded-3 shadow-sm border" style="max-width: 85%; border-radius: 15px 15px 15px 0;">
                        <small class="text-muted d-block mb-1 fw-bold">Asistente</small>
                        ` + botResponse + `
                    </div>
                </div>`;

            messages.insertAdjacentHTML('beforeend', botMsgHTML);
            messages.scrollTop = messages.scrollHeight;
        }, 800);
    }
</script>

<jsp:include page="cliente_footer.jsp" />