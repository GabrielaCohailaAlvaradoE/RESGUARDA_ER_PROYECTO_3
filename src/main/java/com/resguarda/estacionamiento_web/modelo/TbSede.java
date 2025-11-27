/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_sede")
public class TbSede {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_sede")
    private int idSede;

    @Column(name = "nombre")
    private String nombre;

    // --- ESTOS CAMPOS FALTABAN ---
    @Column(name = "direccion")
    private String direccion;

    @Column(name = "telefono")
    private String telefono;

    // Importante: Definición del ENUM para evitar errores de validación
    @Column(name = "estado", columnDefinition = "ENUM('ACTIVA','INACTIVA')")
    private String estado;

    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;
    // -----------------------------

    @Column(name = "tarifa_base", columnDefinition = "decimal(8,2)")
    private BigDecimal tarifaBase;

    // --- Getters y Setters ---
    public int getIdSede() { return idSede; }
    public void setIdSede(int idSede) { this.idSede = idSede; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getDireccion() { return direccion; }
    public void setDireccion(String direccion) { this.direccion = direccion; }
    
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    public BigDecimal getTarifaBase() { return tarifaBase; }
    public void setTarifaBase(BigDecimal tarifaBase) { this.tarifaBase = tarifaBase; }

    public LocalDateTime getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(LocalDateTime fechaCreacion) { this.fechaCreacion = fechaCreacion; }
}