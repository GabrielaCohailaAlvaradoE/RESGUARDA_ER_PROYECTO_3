/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

@Entity
@Table(name = "tb_tarifas")
public class TbTarifas {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_tarifa")
    private int idTarifa;

    @Column(name = "tipo_vehiculo", columnDefinition = "ENUM('AUTO','MOTO','CAMIONETA','CAMION')")
    private String tipoVehiculo;

    @Column(name = "precio_hora", columnDefinition = "decimal(10,2)")
    private BigDecimal precioHora;

    @Column(name = "precio_reserva", columnDefinition = "decimal(10,2)")
    private BigDecimal precioReserva;

    @Column(name = "fecha_inicio")
    private LocalDate fechaInicio;

    @Column(name = "activo")
    private boolean activo;

    // Getters y Setters
    public int getIdTarifa() { return idTarifa; }
    public void setIdTarifa(int idTarifa) { this.idTarifa = idTarifa; }
    public String getTipoVehiculo() { return tipoVehiculo; }
    public void setTipoVehiculo(String tipoVehiculo) { this.tipoVehiculo = tipoVehiculo; }
    public BigDecimal getPrecioHora() { return precioHora; }
    public void setPrecioHora(BigDecimal precioHora) { this.precioHora = precioHora; }
    public BigDecimal getPrecioReserva() { return precioReserva; }
    public void setPrecioReserva(BigDecimal precioReserva) { this.precioReserva = precioReserva; }
    public LocalDate getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(LocalDate fechaInicio) { this.fechaInicio = fechaInicio; }
    public boolean isActivo() { return activo; }
    public void setActivo(boolean activo) { this.activo = activo; }
}