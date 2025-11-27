/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.EspacioDAO;
import com.resguarda.estacionamiento_web.interfaces.PisoDAO;
import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import com.resguarda.estacionamiento_web.modelo.TbEspacio;
import com.resguarda.estacionamiento_web.modelo.TbPiso;
import jakarta.servlet.http.HttpSession;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/gerente/espacios")
public class GerenteEspacioControlador {

    @Autowired private EspacioDAO espacioDAO;
    @Autowired private PisoDAO pisoDAO;

    // --- AÑADIR ESPACIO A UN PISO ---
    @PostMapping("/crear")
    public String crearEspacio(@RequestParam Integer idPiso, 
                               @RequestParam String numeroEspacio,
                               HttpSession session, RedirectAttributes redirectAttributes) {
        
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) return "redirect:/interno/acceso";

        Optional<TbPiso> optPiso = pisoDAO.findById(idPiso);
        if (optPiso.isEmpty()) {
             redirectAttributes.addFlashAttribute("error", "Piso no encontrado.");
             return "redirect:/gerente/espacios";
        }

        TbEspacio nuevo = new TbEspacio();
        nuevo.setPiso(optPiso.get());
        // CORRECCIÓN: Guardamos DIRECTAMENTE lo que escribiste, sin prefijos forzados
        nuevo.setNumeroEspacio(numeroEspacio.toUpperCase().trim()); 
        nuevo.setEstado("LIBRE");
        
        try {
            espacioDAO.save(nuevo);
            redirectAttributes.addFlashAttribute("exito", "Espacio " + numeroEspacio + " creado.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error: Ya existe un espacio con ese nombre.");
        }

        return "redirect:/gerente/espacios";
    }

    // --- CAMBIAR ESTADO (MANTENIMIENTO / LIBRE) ---
    @GetMapping("/cambiarEstado/{id}")
    public String cambiarEstado(@PathVariable Integer id, HttpSession session, RedirectAttributes redirectAttributes) {
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) return "redirect:/interno/acceso";

        Optional<TbEspacio> opt = espacioDAO.findById(id);
        if (opt.isPresent()) {
            TbEspacio espacio = opt.get();
            
            if ("OCUPADO".equals(espacio.getEstado())) {
                 redirectAttributes.addFlashAttribute("error", "No puedes modificar un espacio que tiene un auto dentro.");
            } else if ("LIBRE".equals(espacio.getEstado())) {
                // Si estaba libre, lo "cerramos" (Mantenimiento)
                espacio.setEstado("MANTENIMIENTO");
                espacioDAO.save(espacio);
                redirectAttributes.addFlashAttribute("exito", "Espacio " + espacio.getNumeroEspacio() + " puesto en Mantenimiento.");
            } else {
                // Si estaba en mantenimiento (o reservado), lo liberamos
                espacio.setEstado("LIBRE");
                espacioDAO.save(espacio);
                redirectAttributes.addFlashAttribute("exito", "Espacio " + espacio.getNumeroEspacio() + " habilitado y LIBRE.");
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Espacio no encontrado.");
        }
        return "redirect:/gerente/espacios";
    }
}