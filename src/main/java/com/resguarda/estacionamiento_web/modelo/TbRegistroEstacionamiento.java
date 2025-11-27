/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.modelo;

import jakarta.persistence.*;
import java.math.BigDecimal; 
import java.time.LocalDateTime;

@Entity
@Table(name = "tb_registro_estacionamiento")
public class TbRegistroEstacionamiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_registro")
    private int idRegistro;

    @ManyToOne
    @JoinColumn(name = "id_vehiculo")
    private TbVehiculo vehiculo;

    @ManyToOne
    @JoinColumn(name = "id_conductor")
    private TbUsuariosWeb conductor;

    @ManyToOne
    @JoinColumn(name = "id_espacio")
    private TbEspacio espacio;

    @ManyToOne
    @JoinColumn(name = "id_recepcionista")
    private TbEmpleado recepcionista;

    @Column(name = "hora_entrada")
    private LocalDateTime horaEntrada;

    @Column(name = "hora_salida")
    private LocalDateTime horaSalida;

    @Column(name = "pin_temp")
    private String pinTemp;

    // --- 2. Corrección de MONTO_TOTAL ---
    @Column(name = "monto_total", columnDefinition = "decimal(10,2)")
    private BigDecimal montoTotal;

    // --- 3. Corrección de ESTADO (la que ya hicimos) ---
    @Column(name = "estado", columnDefinition = "ENUM('ESTACIONADO','PENDIENTE_PAGO','FINALIZADO')")
    private String estado;

    // --- Getters y Setters (actualizados para BigDecimal) ---
    
    public int getIdRegistro() { return idRegistro; }
    public void setIdRegistro(int idRegistro) { this.idRegistro = idRegistro; }
    public TbVehiculo getVehiculo() { return vehiculo; }
    public void setVehiculo(TbVehiculo vehiculo) { this.vehiculo = vehiculo; }
    public TbUsuariosWeb getConductor() { return conductor; }
    public void setConductor(TbUsuariosWeb conductor) { this.conductor = conductor; }
    public TbEspacio getEspacio() { return espacio; }
    public void setEspacio(TbEspacio espacio) { this.espacio = espacio; }
    public TbEmpleado getRecepcionista() { return recepcionista; }
    public void setRecepcionista(TbEmpleado recepcionista) { this.recepcionista = recepcionista; }
    public LocalDateTime getHoraEntrada() { return horaEntrada; }
    public void setHoraEntrada(LocalDateTime horaEntrada) { this.horaEntrada = horaEntrada; }
    public LocalDateTime getHoraSalida() { return horaSalida; }
    public void setHoraSalida(LocalDateTime horaSalida) { this.horaSalida = horaSalida; }
    public String getPinTemp() { return pinTemp; }
    public void setPinTemp(String pinTemp) { this.pinTemp = pinTemp; }
    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
    
    // Getter y Setter para BigDecimal
    public BigDecimal getMontoTotal() { return montoTotal; }
    public void setMontoTotal(BigDecimal montoTotal) { this.montoTotal = montoTotal; }
}