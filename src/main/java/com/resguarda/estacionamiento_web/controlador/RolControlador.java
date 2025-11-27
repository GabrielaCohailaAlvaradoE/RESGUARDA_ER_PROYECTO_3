/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.RolDAO;
import com.resguarda.estacionamiento_web.modelo.TbRol;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RolControlador {

    @Autowired
    private RolDAO rolDAO;

    @GetMapping("/test_conexion")
    public String probarConexion(Model model) {
        
        List<TbRol> listaDeRoles = rolDAO.findAll();
        
        model.addAttribute("listaRoles", listaDeRoles);
        
        return "pagina_test_roles";
    }
}
