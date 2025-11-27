/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbPiso;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface PisoDAO extends JpaRepository<TbPiso, Integer> {
    
    @Query("SELECT DISTINCT p FROM TbPiso p LEFT JOIN FETCH p.espacios")
    List<TbPiso> findAllWithEspacios();
    
    @Query("SELECT DISTINCT p FROM TbPiso p LEFT JOIN FETCH p.espacios WHERE p.idSede = :idSede")
    List<TbPiso> findAllBySedeWithEspacios(int idSede);
}