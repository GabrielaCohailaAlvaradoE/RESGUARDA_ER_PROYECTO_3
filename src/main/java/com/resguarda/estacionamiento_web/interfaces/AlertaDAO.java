/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbAlerta;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AlertaDAO extends JpaRepository<TbAlerta, Integer> {
    // Obtener alertas del cliente ordenadas por las más recientes primero
    List<TbAlerta> findByUsuarioIdUsuarioOrderByFechaDesc(int idUsuario);
    
    // Contar cuántas no ha leído (para el numerito en la campana)
    long countByUsuarioIdUsuarioAndLeidaFalse(int idUsuario);
}