/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbVehiculo;
import java.util.List; // <-- IMPORTAR
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface VehiculoDAO extends JpaRepository<TbVehiculo, Integer> {
    
    Optional<TbVehiculo> findByPlaca(String placa);

    List<TbVehiculo> findByPropietarioIdUsuario(int idUsuario);
}