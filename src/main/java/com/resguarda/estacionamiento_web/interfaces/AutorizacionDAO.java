/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbAutorizaciones;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AutorizacionDAO extends JpaRepository<TbAutorizaciones, Integer> {
    // Listar autorizaciones de un cliente ordenadas por fecha
    List<TbAutorizaciones> findByPropietarioIdUsuarioOrderByFechaCreacionDesc(int idUsuario);
}