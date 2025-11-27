/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.interfaces;

import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmpleadoDAO extends JpaRepository<TbEmpleado, Integer> {

    Optional<TbEmpleado> findByUsuarioAndContrasena(String usuario, String contrasena);
    
    List<TbEmpleado> findByIdSedeAndIdRolNot(int idSede, int idRol);
    
    long countByIdSedeAndIdRolNot(int idSede, int idRol);
    
    List<TbEmpleado> findByIdRol(int idRol);
}
