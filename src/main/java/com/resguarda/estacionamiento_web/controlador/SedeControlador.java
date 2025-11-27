/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.SedeDAO;
import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import com.resguarda.estacionamiento_web.modelo.TbSede;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/sedes") // <--- ESTA LÍNEA ES LA QUE RESPONDE AL LINK
public class SedeControlador {

    @Autowired
    private SedeDAO sedeDAO;

    // LISTAR SEDES (Responde a /admin/sedes)
    @GetMapping("")
    public String listarSedes(HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        List<TbSede> sedes = sedeDAO.findAll();
        model.addAttribute("sedes", sedes);
        model.addAttribute("titulo", "Gestión de Sedes");
        return "admin_sedes"; // Busca admin_sedes.jsp
    }

    // FORMULARIO NUEVA SEDE
    @GetMapping("/nueva")
    public String nuevaSede(HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        model.addAttribute("sede", new TbSede());
        model.addAttribute("titulo", "Nueva Sede");
        return "admin_sede_form"; // Busca admin_sede_form.jsp
    }

    // GUARDAR SEDE
    @PostMapping("/guardar")
    public String guardarSede(@ModelAttribute TbSede sede, HttpSession session, RedirectAttributes redirectAttributes) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        sede.setEstado("ACTIVA"); // Estado por defecto
        sedeDAO.save(sede);
        
        redirectAttributes.addFlashAttribute("exito", "Sede guardada correctamente.");
        return "redirect:/admin/sedes";
    }
}