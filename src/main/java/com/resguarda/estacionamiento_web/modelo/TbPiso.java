/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "tb_piso")
public class TbPiso {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_piso")
    private int idPiso;

    @Column(name = "id_sede")
    private int idSede;
    
    // --- CAMPO AÑADIDO ---
    @Column(name = "numero_piso")
    private int numeroPiso;

    @Column(name = "nombre_piso")
    private String nombrePiso;
    
    // --- CAMPO AÑADIDO ---
    @Column(name = "capacidad_total")
    private int capacidadTotal;
    
    // --- CAMPO AÑADIDO ---
    @Column(name = "estado", columnDefinition = "ENUM('ACTIVO','INACTIVO')")
    private String estado;

    @OneToMany(mappedBy = "piso")
    private List<TbEspacio> espacios;

    // --- Getters y Setters (Incluyendo los nuevos) ---
    
    public int getIdPiso() { return idPiso; }
    public void setIdPiso(int idPiso) { this.idPiso = idPiso; }
    public int getIdSede() { return idSede; }
    public void setIdSede(int idSede) { this.idSede = idSede; }
    public int getNumeroPiso() { return numeroPiso; }
    public void setNumeroPiso(int numeroPiso) { this.numeroPiso = numeroPiso; }
    public String getNombrePiso() { return nombrePiso; }
    public void setNombrePiso(String nombrePiso) { this.nombrePiso = nombrePiso; }
    public int getCapacidadTotal() { return capacidadTotal; }
    public void setCapacidadTotal(int capacidadTotal) { this.capacidadTotal = capacidadTotal; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    public List<TbEspacio> getEspacios() { return espacios; }
    public void setEspacios(List<TbEspacio> espacios) { this.espacios = espacios; }
}