/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;

@Entity
@Table(name = "tb_espacio")
public class TbEspacio {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_espacio")
    private int idEspacio;

    @Column(name = "numero_espacio")
    private String numeroEspacio;

    @Column(name = "estado", columnDefinition = "ENUM('LIBRE','OCUPADO','MANTENIMIENTO')")
    private String estado;

    @ManyToOne
    @JoinColumn(name = "id_piso")
    private TbPiso piso;

    // Getters y Setters
    public int getIdEspacio() {
        return idEspacio;
    }

    public void setIdEspacio(int idEspacio) {
        this.idEspacio = idEspacio;
    }

    public String getNumeroEspacio() {
        return numeroEspacio;
    }

    public void setNumeroEspacio(String numeroEspacio) {
        this.numeroEspacio = numeroEspacio;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public TbPiso getPiso() {
        return piso;
    }

    public void setPiso(TbPiso piso) {
        this.piso = piso;
    }
}
