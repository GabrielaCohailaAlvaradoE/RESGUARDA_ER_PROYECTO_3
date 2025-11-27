/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbRegistroEstacionamiento;
import java.util.Optional; // Asegúrate de importar Optional
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface RegistroDAO extends JpaRepository<TbRegistroEstacionamiento, Integer> {

    @Query("SELECT r FROM TbRegistroEstacionamiento r " +
           "WHERE r.estado = 'ESTACIONADO' " +
           "AND (r.vehiculo.placa = :placaOpin OR r.pinTemp = :placaOpin)")
    Optional<TbRegistroEstacionamiento> findActiveRegistroByPlacaOrPin(String placaOpin);
    
    @Query("SELECT r FROM TbRegistroEstacionamiento r " +
           "WHERE r.conductor.idUsuario = :idUsuario AND r.estado = 'ESTACIONADO'")
    Optional<TbRegistroEstacionamiento> findActiveRegistroByClienteId(int idUsuario);
    
    long countByEspacioPisoIdSedeAndEstado(int idSede, String estado);
}