/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.*;
import com.resguarda.estacionamiento_web.modelo.*;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminControlador {

    @Autowired private EmpleadoDAO empleadoDAO;
    @Autowired private UsuariosWebDAO usuariosWebDAO;
    @Autowired private SedeDAO sedeDAO;
    @Autowired private PagosDAO pagosDAO;

    @GetMapping("/dashboard")
    public String verDashboardAdmin(HttpSession session, Model model) {
        // 1. Seguridad: Verificar si es Admin (Rol 1)
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) {
            return "redirect:/interno/acceso";
        }

        // 2. CÁLCULOS REALES (KPIs)
        long totalEmpleados = empleadoDAO.count();
        long totalClientes = usuariosWebDAO.count();
        long totalSedes = sedeDAO.count();
        
        // Sumar ganancias totales desde la tabla tb_pagos
        List<TbPagos> todosLosPagos = pagosDAO.findAll();
        BigDecimal totalIngresos = BigDecimal.ZERO;
        
        for (TbPagos pago : todosLosPagos) {
            if (pago.getMontoTotal() != null) {
                totalIngresos = totalIngresos.add(pago.getMontoTotal());
            }
        }

        // 3. Pasar datos a la vista (admin_dashboard.jsp)
        model.addAttribute("kpi_empleados", totalEmpleados);
        model.addAttribute("kpi_clientes", totalClientes);
        model.addAttribute("kpi_sedes", totalSedes);
        model.addAttribute("kpi_ingresos", totalIngresos); // ¡Aquí va el dinero real!
        
        model.addAttribute("titulo", "Panel General - CEO");
        
        // Nombre para el header
        model.addAttribute("empleadoLogueado", admin);

        return "admin_dashboard";
    }
}