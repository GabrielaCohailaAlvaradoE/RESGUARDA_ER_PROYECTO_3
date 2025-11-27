/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.*;
import com.resguarda.estacionamiento_web.modelo.*;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/gerentes")
public class AdminGerenteControlador {

    @Autowired private EmpleadoDAO empleadoDAO;
    @Autowired private SedeDAO sedeDAO; // Para asignar sede

    // Listar Gerentes
    @GetMapping("")
    public String listarGerentes(HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        // Buscar solo rol 2 (Gerentes)
        List<TbEmpleado> gerentes = empleadoDAO.findByIdRol(2);
        model.addAttribute("gerentes", gerentes);
        model.addAttribute("titulo", "Gestión de Gerentes");
        return "admin_gerentes";
    }

    // Formulario Nuevo
    @GetMapping("/nuevo")
    public String nuevoGerente(HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        model.addAttribute("gerente", new TbEmpleado());
        model.addAttribute("sedes", sedeDAO.findAll()); // Lista de sedes para asignar
        model.addAttribute("titulo", "Nuevo Gerente");
        return "admin_gerente_form";
    }
    
    // Formulario Editar
    @GetMapping("/editar/{id}")
    public String editarGerente(@PathVariable Integer id, HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        Optional<TbEmpleado> opt = empleadoDAO.findById(id);
        if(opt.isPresent()){
            model.addAttribute("gerente", opt.get());
            model.addAttribute("sedes", sedeDAO.findAll());
            model.addAttribute("titulo", "Editar Gerente");
            return "admin_gerente_form";
        }
        return "redirect:/admin/gerentes";
    }

    // Guardar
    @PostMapping("/guardar")
    public String guardarGerente(@ModelAttribute TbEmpleado gerente, HttpSession session, RedirectAttributes redirectAttributes) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        gerente.setIdRol(2); // Forzamos Rol de Gerente
        
        // Validación simple de contraseña para nuevos
        if(gerente.getIdEmpleado() == 0 && (gerente.getContrasena() == null || gerente.getContrasena().isEmpty())){
             redirectAttributes.addFlashAttribute("error", "La contraseña es obligatoria.");
             return "redirect:/admin/gerentes/nuevo";
        }

        empleadoDAO.save(gerente);
        redirectAttributes.addFlashAttribute("exito", "Gerente guardado correctamente.");
        return "redirect:/admin/gerentes";
    }
}