<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="header.jsp">
    <jsp:param name="titulo" value="${titulo}" />
</jsp:include>

<div class="row justify-content-center">
    <div class="col-md-8">
        <h3>${titulo}</h3>
        <hr>
        <div class="card shadow-sm">
            <div class="card-body">
                
                <form action="<c:url value='/gerente/pisos/guardar' />" method="post">
                
                    <div class="row mb-3">
                        <div class="col-md-8">
                            <label for="nombrePiso" class="form-label">Nombre del Piso</label>
                            <input type="text" class="form-control" id="nombrePiso" name="nombrePiso" 
                                   placeholder="Ej: Sótano 2, Piso 1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="numeroPiso" class="form-label">Número de Piso</label>
                            <input type="number" class="form-control" id="numeroPiso" name="numeroPiso" 
                                   placeholder="Ej: -2, 1" required>
                        </div>
                    </div>
                    
                    <div class.row mb-3">
                         <div class="col-md-4">
                            <label for="capacidadTotal" class="form-label">Capacidad Total de Espacios</label>
                            <input type="number" class="form-control" id="capacidadTotal" name="capacidadTotal" required>
                        </div>
                    </div>

                    <hr>
                    <button type="submit" class="btn btn-primary">Guardar Piso</button>
                    <a href="<c:url value='/gerente/espacios' />" class="btn btn-secondary">Cancelar</a>

                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
