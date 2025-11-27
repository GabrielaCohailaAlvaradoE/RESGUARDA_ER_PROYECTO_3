/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbPagos;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface PagosDAO extends JpaRepository<TbPagos, Integer> {
    
    @Query("SELECT p FROM TbPagos p WHERE p.registro.vehiculo.propietario.idUsuario = :idUsuario ORDER BY p.fechaPago DESC")
    List<TbPagos> findPagosByCliente(int idUsuario);
}