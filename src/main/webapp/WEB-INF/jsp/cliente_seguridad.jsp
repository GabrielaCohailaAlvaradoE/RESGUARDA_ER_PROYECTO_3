<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="cliente_header.jsp">
    <jsp:param name="titulo" value="Seguridad y Pagos" />
</jsp:include>

<style>
    /* Estilos de Pestañas */
    .nav-tabs { border-bottom: 2px solid #e9ecef; }
    .nav-tabs .nav-link {
        color: #6c757d !important; font-weight: 600; border: none; border-bottom: 3px solid transparent; transition: all 0.3s; padding: 1rem 1.5rem;
    }
    .nav-tabs .nav-link:hover { color: #0d6efd !important; background: rgba(0,0,0,0.02); }
    .nav-tabs .nav-link.active { color: #0d6efd !important; background-color: transparent !important; border-bottom: 3px solid #0d6efd !important; }
    
    .stat-card { transition: transform 0.2s; border: none; border-radius: 15px; }
    .stat-card:hover { transform: translateY(-5px); }

    /* ESTILOS ESPECÍFICOS PARA LA BOLETA EN PANTALLA */
    .invoice-container { font-family: 'Inter', sans-serif; color: #333; }
    .invoice-header-box { background-color: #f8f9fa; border-bottom: 2px solid #000; padding: 20px; }
    .invoice-title { font-size: 1.5rem; font-weight: 900; letter-spacing: -1px; color: #198754; text-transform: uppercase; }
    .invoice-details-box { border: 1px solid #ddd; padding: 15px; border-radius: 8px; background: #fff; }
    .invoice-table th { background: #000; color: #fff; text-transform: uppercase; font-size: 0.75rem; letter-spacing: 1px; padding: 10px; }
    .invoice-table td { padding: 12px 10px; border-bottom: 1px solid #eee; font-size: 0.9rem; }
    .invoice-total-row td { border-top: 2px solid #000; font-weight: bold; font-size: 1.1rem; background-color: #f8f9fa; }
</style>

<div class="container-fluid px-4 py-5">

    <div class="mb-4">
        <h2 class="fw-bold text-dark">Centro de Finanzas y Seguridad</h2>
        <p class="text-muted">Reportes detallados y control de acceso.</p>
    </div>

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

    <div class="card shadow-lg border-0 rounded-3 overflow-hidden">
        
        <div class="card-header bg-white pt-0 px-0 border-bottom-0">
            <ul class="nav nav-tabs px-4 pt-2" id="securityTabs" role="tablist">
                <li class="nav-item" role="presentation">
                    <button class="nav-link active" id="pagos-tab" data-bs-toggle="tab" data-bs-target="#pagos" type="button" role="tab">
                        <i class="bi bi-graph-up-arrow me-2"></i> Reportes y Pagos
                    </button>
                </li>
                <li class="nav-item" role="presentation">
                    <button class="nav-link" id="auth-tab" data-bs-toggle="tab" data-bs-target="#auth" type="button" role="tab">
                        <i class="bi bi-shield-lock me-2"></i> Autorizaciones
                    </button>
                </li>
            </ul>
        </div>
        
        <div class="card-body p-4 bg-light bg-opacity-10">
            <div class="tab-content" id="myTabContent">
                
                <div class="tab-pane fade show active" id="pagos" role="tabpanel">
                    
                    <c:if test="${not empty historialPagos}">
                        <div class="row g-4 mb-4">
                            <div class="col-lg-8">
                                <div class="card stat-card shadow-sm h-100">
                                    <div class="card-body">
                                        <h6 class="fw-bold text-muted small text-uppercase mb-3">Gastos Reales (Base de Datos)</h6>
                                        <div style="height: 250px; width: 100%;">
                                            <canvas id="chartGastos"></canvas>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4">
                                <div class="card stat-card shadow-sm h-100 bg-primary text-white">
                                    <div class="card-body p-4 d-flex flex-column justify-content-center text-center">
                                        <i class="bi bi-wallet2 mb-3" style="font-size: 3rem; opacity: 0.8;"></i>
                                        <h5 class="text-white-50">Total Gastado</h5>
                                        <h2 class="display-4 fw-bold mb-0" id="totalDisplay">S/ 0.00</h2>
                                        <small class="mt-2 text-white-50">Calculado de ${historialPagos.size()} transacciones</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                            <h6 class="mb-0 fw-bold text-dark"><i class="bi bi-list-columns-reverse me-2"></i>Detalle de Movimientos</h6>
                            <button class="btn btn-success btn-sm rounded-pill px-3" onclick="exportTableToCSV('historial_pagos.csv')">
                                <i class="bi bi-file-earmark-excel me-2"></i> Descargar Excel
                            </button>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0" id="tablaPagos">
                                <thead class="bg-light small text-uppercase text-muted">
                                    <tr>
                                        <th class="ps-4 py-3 border-0">Operación</th>
                                        <th class="py-3 border-0">Fecha</th>
                                        <th class="py-3 border-0">Detalle</th>
                                        <th class="py-3 border-0">Método</th>
                                        <th class="text-end py-3 border-0">Total</th>
                                        <th class="text-end pe-4 py-3 border-0">Recibo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="pago" items="${historialPagos}">
                                        <tr>
                                            <td class="ps-4 font-monospace text-primary fw-bold">#${String.format("%06d", pago.idPago)}</td>
                                            <td class="small text-muted">${pago.fechaPago}</td>
                                            <td>
                                                <div class="fw-bold text-dark">Estacionamiento</div>
                                                <small class="text-muted">${pago.registro.vehiculo.placa}</small>
                                            </td>
                                            <td>
                                                <span class="badge bg-white text-dark border rounded-pill fw-normal px-3">${pago.metodoPago}</span>
                                            </td>
                                            <td class="text-end fw-bold text-success">S/ ${pago.montoTotal}</td>
                                            <td class="text-end pe-4">
                                                <button type="button" class="btn btn-sm btn-outline-dark rounded-pill px-3"
                                                        data-bs-toggle="modal" data-bs-target="#modalBoleta"
                                                        data-id="B001-${String.format("%06d", pago.idPago)}"
                                                        data-fecha="${pago.fechaPago}"
                                                        data-cliente="${clienteLogueado.nombres} ${clienteLogueado.apellidos}"
                                                        data-dni="${clienteLogueado.dni}"
                                                        data-placa="${pago.registro.vehiculo.placa}"
                                                        data-entrada="${pago.registro.horaEntrada}"
                                                        data-salida="${pago.registro.horaSalida}"
                                                        data-metodo="${pago.metodoPago}"
                                                        data-total="${pago.montoTotal}">
                                                    <i class="bi bi-eye-fill me-1"></i> Ver
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty historialPagos}">
                                        <tr><td colspan="6" class="text-center py-5 text-muted">No hay pagos registrados.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="auth" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-lg-4">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-primary text-white py-3">
                                    <h6 class="mb-0 fw-bold"><i class="bi bi-plus-circle me-2"></i>Nueva Autorización</h6>
                                </div>
                                <div class="card-body p-4">
                                    <form action="<c:url value='/cliente/crearAutorizacion' />" method="post">
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold text-muted">VEHÍCULO</label>
                                            <select name="idVehiculo" class="form-select" required>
                                                <c:forEach var="v" items="${misVehiculos}">
                                                    <option value="${v.idVehiculo}">${v.placa} - ${v.modelo}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label small fw-bold text-muted">DNI TERCERO</label>
                                            <input type="text" name="dniAutorizado" class="form-control" required>
                                        </div>
                                        <div class="mb-4">
                                            <label class="form-label small fw-bold text-muted">NOMBRE COMPLETO</label>
                                            <input type="text" name="nombresAutorizado" class="form-control" required>
                                        </div>
                                        <button type="submit" class="btn btn-primary w-100 fw-bold shadow-sm">Autorizar</button>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-8">
                             <div class="card border-0 shadow-sm h-100">
                                <div class="card-header bg-white py-3">
                                    <h6 class="mb-0 fw-bold text-dark">Permisos Activos</h6>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle mb-0">
                                        <thead class="bg-light small text-uppercase text-muted">
                                            <tr>
                                                <th class="ps-4 border-0">Conductor</th>
                                                <th class="border-0">Vehículo</th>
                                                <th class="border-0">Vence</th>
                                                <th class="border-0 text-center">Estado</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="aut" items="${autorizaciones}">
                                                <tr>
                                                    <td class="ps-4">
                                                        <div class="fw-bold text-dark">${aut.nombresAutorizado}</div>
                                                        <small class="text-muted">${aut.dniAutorizado}</small>
                                                    </td>
                                                    <td><span class="badge bg-light text-dark border">${aut.vehiculo.placa}</span></td>
                                                    <td class="text-muted small">${aut.fechaExpiracion}</td>
                                                    <td class="text-center"><span class="badge rounded-pill px-3 ${aut.estado == 'ACTIVA' ? 'bg-success' : 'bg-secondary'}">${aut.estado}</span></td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="modalBoleta" tabindex="-1" aria-hidden="true">
   <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg" style="border-radius: 0px;"> <div class="modal-header bg-dark text-white py-2 rounded-0">
                <h6 class="modal-title fw-light"><i class="bi bi-printer me-2"></i>Vista Previa de Impresión</h6>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            
            <div class="modal-body bg-secondary bg-opacity-10 p-4 d-flex justify-content-center overflow-auto" style="max-height: 85vh;">
                
                <div id="areaImpresion" class="invoice-container shadow p-5 bg-white" style="width: 100%; max-width: 800px; min-height: 600px; position: relative;">
                    
                    <div class="invoice-header-box mb-4">
                        <div class="row align-items-center">
                            <div class="col-7">
                                <div class="invoice-title mb-1">ESTACIÓN RESGUARDA</div>
                                <div class="small text-muted">Av. Principal 123, Tacna - Perú</div>
                                <div class="small text-muted">Tel: (052) 123-4567 | web: resguarda.com</div>
                            </div>
                            <div class="col-5 text-center border border-2 border-dark p-3">
                                <div class="fw-bold">R.U.C. 20601234567</div>
                                <div class="bg-dark text-white fw-bold py-1 my-2">BOLETA DE VENTA ELECTRÓNICA</div>
                                <div class="font-monospace fs-5" id="modalId">B001-000000</div>
                            </div>
                        </div>
                    </div>

                    <div class="invoice-details-box mb-4">
                        <div class="row g-2">
                            <div class="col-md-8">
                                <small class="text-uppercase text-muted d-block fw-bold" style="font-size: 0.7rem;">Señor(es)</small>
                                <span id="modalCliente" class="fw-bold fs-6">---</span>
                            </div>
                            <div class="col-md-4 text-end">
                                <small class="text-uppercase text-muted d-block fw-bold" style="font-size: 0.7rem;">Fecha de Emisión</small>
                                <span id="modalFecha" class="font-monospace">---</span>
                            </div>
                            <div class="col-md-4">
                                <small class="text-uppercase text-muted d-block fw-bold" style="font-size: 0.7rem;">Documento (DNI)</small>
                                <span id="modalDni">---</span>
                            </div>
                            <div class="col-md-4">
                                <small class="text-uppercase text-muted d-block fw-bold" style="font-size: 0.7rem;">Placa Vehículo</small>
                                <span id="modalPlaca" class="font-monospace bg-light px-2 border">---</span>
                            </div>
                             <div class="col-md-4 text-end">
                                <small class="text-uppercase text-muted d-block fw-bold" style="font-size: 0.7rem;">Moneda</small>
                                <span>SOLES (S/)</span>
                            </div>
                        </div>
                    </div>

                    <table class="invoice-table w-100 mb-4">
                        <thead>
                            <tr>
                                <th style="width: 10%;">CANT.</th>
                                <th style="width: 10%;">UNID.</th>
                                <th style="width: 50%;">DESCRIPCIÓN</th>
                                <th style="width: 15%; text-align: right;">V. UNIT</th>
                                <th style="width: 15%; text-align: right;">TOTAL</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="text-center">1</td>
                                <td class="text-center">ZZ</td>
                                <td>
                                    SERVICIO DE ESTACIONAMIENTO
                                    <div class="text-muted small mt-1 font-monospace" style="font-size: 0.75rem;">
                                        ENTRADA: <span id="modalEntrada"></span><br>
                                        SALIDA:  <span id="modalSalida"></span>
                                    </div>
                                </td>
                                <td class="text-end" id="modalUnitario">0.00</td>
                                <td class="text-end" id="modalImporte">0.00</td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3" class="border-0"></td>
                                <td class="text-end border-bottom py-2 small">Op. Gravada:</td>
                                <td class="text-end border-bottom py-2 font-monospace" id="modalGravada">0.00</td>
                            </tr>
                            <tr>
                                <td colspan="3" class="border-0">
                                    <small class="text-muted">SON: <span id="modalLetras" class="fw-bold text-dark">--- SOLES</span></small>
                                </td>
                                <td class="text-end border-bottom py-2 small">I.G.V. (18%):</td>
                                <td class="text-end border-bottom py-2 font-monospace" id="modalIgv">0.00</td>
                            </tr>
                            <tr class="invoice-total-row">
                                <td colspan="3" class="border-0"></td>
                                <td class="text-end pt-3">IMPORTE TOTAL:</td>
                                <td class="text-end pt-3" id="modalTotal">0.00</td>
                            </tr>
                        </tfoot>
                    </table>
                    
                    <div class="mt-5 pt-3 border-top text-center">
                        <div class="d-flex justify-content-center align-items-center gap-3">
                             <img src="https://api.qrserver.com/v1/create-qr-code/?size=100x100&data=ResguardaCPE" width="80" height="80">
                             <div class="text-start small text-muted" style="font-size: 0.7rem;">
                                 <p class="mb-1">Representación impresa de la BOLETA DE VENTA ELECTRÓNICA.</p>
                                 <p class="mb-1">Autorizado mediante Resolución de Intendencia N° 034-005-0005315.</p>
                                 <p class="mb-0">Consulte su documento en <strong>www.resguarda.com/cpe</strong></p>
                             </div>
                        </div>
                    </div>

                </div>
            </div>
            <div class="modal-footer bg-white border-0">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                <button type="button" class="btn btn-success px-4 fw-bold shadow" onclick="imprimirBoleta()">
                    <i class="bi bi-printer-fill me-2"></i> IMPRIMIR
                </button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    // 1. GRÁFICOS (Igual que antes)
    const pagosData = [ <c:forEach var="p" items="${historialPagos}"> { fecha: "${p.fechaPago}", monto: ${p.montoTotal} }, </c:forEach> ];
    if (document.getElementById('chartGastos') && pagosData.length > 0) {
        let totalSum = 0;
        pagosData.forEach(p => totalSum += p.monto);
        document.getElementById('totalDisplay').innerText = 'S/ ' + totalSum.toFixed(2);
        const ctx1 = document.getElementById('chartGastos').getContext('2d');
        new Chart(ctx1, { type: 'bar', data: { labels: pagosData.map(p => p.fecha.substring(0,10)), datasets: [{ label: 'Monto (S/)', data: pagosData.map(p => p.monto), backgroundColor: '#0d6efd', borderRadius: 4 }] }, options: { responsive: true, maintainAspectRatio: false, scales: { y: { beginAtZero: true } } } });
    }

    // 2. EXPORTAR CSV
    function exportTableToCSV(filename) {
        var csv = [];
        var rows = document.querySelectorAll("#tablaPagos tr");
        for (var i = 0; i < rows.length; i++) {
            var row = [], cols = rows[i].querySelectorAll("td, th");
            for (var j = 0; j < cols.length - 1; j++) row.push('"' + cols[j].innerText.replace(/(\r\n|\n|\r)/gm, "").trim() + '"');
            csv.push(row.join(","));
        }
        var csvFile = new Blob([csv.join("\n")], {type: "text/csv"});
        var downloadLink = document.createElement("a");
        downloadLink.download = filename;
        downloadLink.href = window.URL.createObjectURL(csvFile);
        downloadLink.style.display = "none";
        document.body.appendChild(downloadLink);
        downloadLink.click();
    }

    // 3. LÓGICA MODAL BOLETA (CON CÁLCULOS REALES)
    document.addEventListener('DOMContentLoaded', function() {
        const modalElement = document.getElementById('modalBoleta');
        if (modalElement) {
            document.body.appendChild(modalElement);
            modalElement.addEventListener('show.bs.modal', event => {
                const btn = event.relatedTarget;
                
                // Llenar Textos Básicos
                document.getElementById('modalId').textContent = btn.getAttribute('data-id');
                document.getElementById('modalFecha').textContent = btn.getAttribute('data-fecha').substring(0,10);
                document.getElementById('modalCliente').textContent = btn.getAttribute('data-cliente');
                document.getElementById('modalDni').textContent = btn.getAttribute('data-dni');
                document.getElementById('modalPlaca').textContent = btn.getAttribute('data-placa');
                
                // Fechas con formato limpio
                const ent = btn.getAttribute('data-entrada') || '';
                const sal = btn.getAttribute('data-salida') || '';
                document.getElementById('modalEntrada').textContent = ent.replace('T', ' ').substring(0, 16);
                document.getElementById('modalSalida').textContent = sal.replace('T', ' ').substring(0, 16);

                // Cálculos Financieros
                const total = parseFloat(btn.getAttribute('data-total'));
                const subtotal = total / 1.18; 
                const igv = total - subtotal;

                document.getElementById('modalUnitario').textContent = subtotal.toFixed(2);
                document.getElementById('modalImporte').textContent = subtotal.toFixed(2);
                
                document.getElementById('modalGravada').textContent = subtotal.toFixed(2);
                document.getElementById('modalIgv').textContent = igv.toFixed(2);
                document.getElementById('modalTotal').textContent = 'S/ ' + total.toFixed(2);
                
                // Convertir número a letras (Simplificado)
                document.getElementById('modalLetras').textContent = 'POR MONTO DE ' + total.toFixed(2) + ' SOLES';
            });
        }
    });

    // 4. IMPRESIÓN PDF PERFECTA
    function imprimirBoleta() {
        var contenido = document.getElementById('areaImpresion').outerHTML;
        var ventana = window.open('', '_blank', 'width=900,height=1100');
        ventana.document.write('<html><head><title>Boleta Electrónica</title>');
        // CSS para impresión
        ventana.document.write('<style>');
        ventana.document.write('@import url("https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css");');
        ventana.document.write('body { background-color: #555; display: flex; justify-content: center; padding: 40px; font-family: sans-serif; -webkit-print-color-adjust: exact; }');
        ventana.document.write('.invoice-container { background: white; width: 100%; max-width: 800px; padding: 40px; margin: auto; }');
        ventana.document.write('.invoice-header-box { border-bottom: 2px solid black; padding-bottom: 20px; margin-bottom: 20px; }');
        ventana.document.write('.invoice-table th { background-color: #000 !important; color: white !important; }');
        ventana.document.write('.invoice-total-row td { background-color: #eee !important; font-weight: bold; }');
        ventana.document.write('@media print { body { background: white; padding: 0; } .invoice-container { box-shadow: none; max-width: 100%; } }');
        ventana.document.write('</style>');
        ventana.document.write('</head><body>');
        ventana.document.write(contenido);
        ventana.document.write('</body></html>');
        ventana.document.close();
        
        ventana.onload = function() {
            setTimeout(function() {
                ventana.focus();
                ventana.print();
            }, 800); // Esperar a que carguen estilos
        };
    }
</script>

<jsp:include page="cliente_footer.jsp" />  