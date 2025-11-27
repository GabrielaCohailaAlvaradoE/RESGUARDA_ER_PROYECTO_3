/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.TarifaDAO;
import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import com.resguarda.estacionamiento_web.modelo.TbTarifas;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/tarifas")
public class AdminTarifaControlador {

    @Autowired private TarifaDAO tarifaDAO;

    @GetMapping("")
    public String listarTarifas(HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        List<TbTarifas> tarifas = tarifaDAO.findAll();
        model.addAttribute("tarifas", tarifas);
        model.addAttribute("titulo", "Tarifas Globales");
        return "admin_tarifas";
    }

    @GetMapping("/editar/{id}")
    public String editarTarifa(@PathVariable Integer id, HttpSession session, Model model) {
        TbEmpleado admin = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (admin == null || admin.getIdRol() != 1) return "redirect:/interno/acceso";

        Optional<TbTarifas> opt = tarifaDAO.findById(id);
        if(opt.isPresent()){
            model.addAttribute("tarifa", opt.get());
            model.addAttribute("titulo", "Modificar Tarifa");
            return "admin_tarifa_form";
        }
        return "redirect:/admin/tarifas";
    }

    @PostMapping("/guardar")
    public String guardarTarifa(@ModelAttribute TbTarifas tarifa, HttpSession session, RedirectAttributes redirectAttributes) {
        // Validar Admin...
        tarifaDAO.save(tarifa);
        redirectAttributes.addFlashAttribute("exito", "Tarifa actualizada.");
        return "redirect:/admin/tarifas";
    }
}