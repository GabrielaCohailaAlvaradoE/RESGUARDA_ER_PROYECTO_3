/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_alerta")
public class TbAlerta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_alerta")
    private int idAlerta;

    @ManyToOne
    @JoinColumn(name = "id_usuario")
    private TbUsuariosWeb usuario; // El cliente que recibe la alerta

    @Column(name = "titulo")
    private String titulo;

    @Column(name = "mensaje", columnDefinition = "TEXT")
    private String mensaje;

    @Column(name = "fecha")
    private LocalDateTime fecha;

    @Column(name = "tipo")
    private String tipo; // 'INFO', 'ADVERTENCIA', 'EXITO'

    @Column(name = "leida")
    private boolean leida; // Para mostrar el puntito rojo o no

    // --- Getters y Setters ---
    public int getIdAlerta() { return idAlerta; }
    public void setIdAlerta(int idAlerta) { this.idAlerta = idAlerta; }
    public TbUsuariosWeb getUsuario() { return usuario; }
    public void setUsuario(TbUsuariosWeb usuario) { this.usuario = usuario; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getMensaje() { return mensaje; }
    public void setMensaje(String mensaje) { this.mensaje = mensaje; }
    public LocalDateTime getFecha() { return fecha; }
    public void setFecha(LocalDateTime fecha) { this.fecha = fecha; }
    public String getTipo() { return tipo; }
    public void setTipo(String tipo) { this.tipo = tipo; }
    public boolean isLeida() { return leida; }
    public void setLeida(boolean leida) { this.leida = leida; }
}
