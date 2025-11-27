/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_reservas")
public class TbReservas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_reserva")
    private int idReserva;

    @ManyToOne
    @JoinColumn(name = "id_cliente")
    private TbUsuariosWeb cliente;

    @ManyToOne
    @JoinColumn(name = "id_espacio")
    private TbEspacio espacio;

    @Column(name = "fecha_reserva")
    private LocalDateTime fechaReserva;

    @Column(name = "estado", columnDefinition = "ENUM('PENDIENTE','ACTIVA','FINALIZADA','CANCELADA')")
    private String estado;
    
    // --- ¡AQUÍ ESTÁ LA CORRECCIÓN! ---
    @Column(name = "fecha_hora_reserva")
    private LocalDateTime fechaHoraReserva; // <-- Este campo faltaba

    @Column(name = "monto_reserva", columnDefinition = "decimal(10,2)")
    private BigDecimal montoReserva;

    // --- Getters y Setters (Incluyendo el nuevo) ---
    public int getIdReserva() { return idReserva; }
    public void setIdReserva(int idReserva) { this.idReserva = idReserva; }
    public TbUsuariosWeb getCliente() { return cliente; }
    public void setCliente(TbUsuariosWeb cliente) { this.cliente = cliente; }
    public TbEspacio getEspacio() { return espacio; }
    public void setEspacio(TbEspacio espacio) { this.espacio = espacio; }
    public LocalDateTime getFechaReserva() { return fechaReserva; }
    public void setFechaReserva(LocalDateTime fechaReserva) { this.fechaReserva = fechaReserva; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public BigDecimal getMontoReserva() { return montoReserva; }
    public void setMontoReserva(BigDecimal montoReserva) { this.montoReserva = montoReserva; }
    
    // Getter y Setter para el campo nuevo
    public LocalDateTime getFechaHoraReserva() { return fechaHoraReserva; }
    public void setFechaHoraReserva(LocalDateTime fechaHoraReserva) { this.fechaHoraReserva = fechaHoraReserva; }
}