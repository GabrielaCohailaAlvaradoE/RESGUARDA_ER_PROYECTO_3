/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_pagos")
public class TbPagos {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pago")
    private int idPago;

    @OneToOne
    @JoinColumn(name = "id_registro")
    private TbRegistroEstacionamiento registro;

    @Column(name = "monto_total", columnDefinition = "decimal(10,2)")
    private BigDecimal montoTotal;

    @Column(name = "monto_recibido", columnDefinition = "decimal(10,2)")
    private BigDecimal montoRecibido;

    @Column(name = "vuelto", columnDefinition = "decimal(10,2)")
    private BigDecimal vuelto;

    @Column(name = "fecha_pago")
    private LocalDateTime fechaPago;

    @Column(name = "metodo_pago", columnDefinition = "ENUM('EFECTIVO','TARJETA','YAPE','PLIN')")
    private String metodoPago;

    // --- Getters y Setters ---
    public int getIdPago() { return idPago; }
    public void setIdPago(int idPago) { this.idPago = idPago; }
    public TbRegistroEstacionamiento getRegistro() { return registro; }
    public void setRegistro(TbRegistroEstacionamiento registro) { this.registro = registro; }
    public BigDecimal getMontoTotal() { return montoTotal; }
    public void setMontoTotal(BigDecimal montoTotal) { this.montoTotal = montoTotal; }
    public BigDecimal getMontoRecibido() { return montoRecibido; }
    public void setMontoRecibido(BigDecimal montoRecibido) { this.montoRecibido = montoRecibido; }
    public BigDecimal getVuelto() { return vuelto; }
    public void setVuelto(BigDecimal vuelto) { this.vuelto = vuelto; }
    public LocalDateTime getFechaPago() { return fechaPago; }
    public void setFechaPago(LocalDateTime fechaPago) { this.fechaPago = fechaPago; }
    public String getMetodoPago() { return metodoPago; }
    public void setMetodoPago(String metodoPago) { this.metodoPago = metodoPago; }
}