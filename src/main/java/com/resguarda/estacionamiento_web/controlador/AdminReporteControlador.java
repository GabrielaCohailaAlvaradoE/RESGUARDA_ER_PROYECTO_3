/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.PagosDAO;
import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import com.resguarda.estacionamiento_web.modelo.TbPagos;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin/reportes")
public class AdminReporteControlador {

    @Autowired private PagosDAO pagosDAO;

    @GetMapping("")
    public String verReportes(HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        // Traer TODOS los pagos de TODAS las sedes
        List<TbPagos> todosLosPagos = pagosDAO.findAll();
        
        model.addAttribute("movimientos", todosLosPagos);
        model.addAttribute("titulo", "Reportes Consolidados");
        return "admin_reportes";
    }
}