/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_vehiculo")
public class TbVehiculo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_vehiculo")
    private int idVehiculo;

    @ManyToOne
    @JoinColumn(name = "id_propietario")
    private TbUsuariosWeb propietario;

    @Column(name = "placa")
    private String placa;

    @Column(name = "marca")
    private String marca;

    @Column(name = "modelo")
    private String modelo;

    @Column(name = "anio_fabricacion")
    private int anioFabricacion;

    @Column(name = "color")
    private String color;

    @Column(name = "vin")
    private String vin;

    @Column(name = "estado_soat", columnDefinition = "ENUM('VIGENTE','VENCIDO')")
    private String estadoSoat;


    @Column(name = "clase_vehicular", columnDefinition = "ENUM('LIVIANO','PESADO','MOTO','OTRO')")
    private String claseVehicular;

    @Column(name = "fecha_actualizacion")
    private LocalDateTime fechaActualizacion;
    

    public int getIdVehiculo() { return idVehiculo; }
    public void setIdVehiculo(int idVehiculo) { this.idVehiculo = idVehiculo; }
    public TbUsuariosWeb getPropietario() { return propietario; }
    public void setPropietario(TbUsuariosWeb propietario) { this.propietario = propietario; }
    public String getPlaca() { return placa; }
    public void setPlaca(String placa) { this.placa = placa; }
    public String getMarca() { return marca; }
    public void setMarca(String marca) { this.marca = marca; }
    public String getModelo() { return modelo; }
    public void setModelo(String modelo) { this.modelo = modelo; }
    public int getAnioFabricacion() { return anioFabricacion; }
    public void setAnioFabricacion(int anioFabricacion) { this.anioFabricacion = anioFabricacion; }
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    public String getVin() { return vin; }
    public void setVin(String vin) { this.vin = vin; }
    public String getEstadoSoat() { return estadoSoat; }
    public void setEstadoSoat(String estadoSoat) { this.estadoSoat = estadoSoat; }
    public String getClaseVehicular() { return claseVehicular; }
    public void setClaseVehicular(String claseVehicular) { this.claseVehicular = claseVehicular; }
    public LocalDateTime getFechaActualizacion() { return fechaActualizacion; }
    public void setFechaActualizacion(LocalDateTime fechaActualizacion) { this.fechaActualizacion = fechaActualizacion; }
}