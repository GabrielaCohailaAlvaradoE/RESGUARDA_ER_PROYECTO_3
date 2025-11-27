/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_autorizaciones")
public class TbAutorizaciones {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_autorizacion")
    private int idAutorizacion;

    @ManyToOne
    @JoinColumn(name = "id_propietario")
    private TbUsuariosWeb propietario;

    @ManyToOne
    @JoinColumn(name = "id_vehiculo")
    private TbVehiculo vehiculo;

    @Column(name = "dni_conductor_autorizado")
    private String dniAutorizado;

    @Column(name = "nombres_autorizado")
    private String nombresAutorizado;

    @Column(name = "fecha_creacion")
    private LocalDateTime fechaCreacion;

    @Column(name = "fecha_expiracion")
    private LocalDateTime fechaExpiracion;

    // ENUM: 'ACTIVA','UTILIZADA','EXPIRADA'
    @Column(name = "estado", columnDefinition = "ENUM('ACTIVA','UTILIZADA','EXPIRADA')")
    private String estado;

    // Getters y Setters
    public int getIdAutorizacion() { return idAutorizacion; }
    public void setIdAutorizacion(int idAutorizacion) { this.idAutorizacion = idAutorizacion; }
    public TbUsuariosWeb getPropietario() { return propietario; }
    public void setPropietario(TbUsuariosWeb propietario) { this.propietario = propietario; }
    public TbVehiculo getVehiculo() { return vehiculo; }
    public void setVehiculo(TbVehiculo vehiculo) { this.vehiculo = vehiculo; }
    public String getDniAutorizado() { return dniAutorizado; }
    public void setDniAutorizado(String dniAutorizado) { this.dniAutorizado = dniAutorizado; }
    public String getNombresAutorizado() { return nombresAutorizado; }
    public void setNombresAutorizado(String nombresAutorizado) { this.nombresAutorizado = nombresAutorizado; }
    public LocalDateTime getFechaCreacion() { return fechaCreacion; }
    public void setFechaCreacion(LocalDateTime fechaCreacion) { this.fechaCreacion = fechaCreacion; }
    public LocalDateTime getFechaExpiracion() { return fechaExpiracion; }
    public void setFechaExpiracion(LocalDateTime fechaExpiracion) { this.fechaExpiracion = fechaExpiracion; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}