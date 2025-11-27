<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="cliente_header.jsp">
    <jsp:param name="titulo" value="Mi Perfil" />
</jsp:include>

<div class="container px-4 py-5">
    <div class="row justify-content-center">
        <div class="col-lg-8">
            
            <c:if test="${not empty exito}">
                <div class="alert alert-success border-0 shadow-sm mb-4"><i class="bi bi-check-circle me-2"></i> ${exito}</div>
            </c:if>

            <div class="card border-0 shadow-lg overflow-hidden">
                <div class="card-header bg-white border-0 p-5 pb-0 text-center">
                    <img src="https://ui-avatars.com/api/?name=${cliente.nombres}&size=128&background=0d6efd&color=fff" class="rounded-circle shadow mb-3" alt="Profile">
                    <h3 class="fw-bold">${cliente.nombres} ${cliente.apellidos}</h3>
                    <p class="text-muted">${cliente.dni}</p>
                </div>
                
                <div class="card-body p-5 pt-4">
                    <form action="<c:url value='/cliente/actualizarPerfil' />" method="post">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-uppercase text-muted">Nombres</label>
                                <input type="text" class="form-control form-control-lg" name="nombres" value="${cliente.nombres}" required>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold small text-uppercase text-muted">Apellidos</label>
                                <input type="text" class="form-control form-control-lg" name="apellidos" value="${cliente.apellidos}" required>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold small text-uppercase text-muted">Correo Electrónico</label>
                                <input type="email" class="form-control form-control-lg" name="email" value="${cliente.email}" required>
                            </div>
                            
                            <div class="col-12 mt-4">
                                <div class="bg-light p-3 rounded border">
                                    <label class="form-label fw-bold small text-uppercase text-muted mb-1">Cambiar Contraseña</label>
                                    <small class="d-block text-muted mb-2">Deja en blanco si no deseas cambiarla.</small>
                                    <input type="password" class="form-control" name="nuevaContrasena" placeholder="Nueva contraseña...">
                                </div>
                            </div>
                            
                            <div class="col-12 mt-4 text-end">
                                <button type="submit" class="btn btn-primary btn-lg px-5 rounded-pill fw-bold shadow">
                                    Guardar Cambios
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="cliente_footer.jsp" />
