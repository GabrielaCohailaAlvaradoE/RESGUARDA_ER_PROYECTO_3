/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.EmpleadoDAO;
import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class LoginControlador {

    @Autowired
    private EmpleadoDAO empleadoDAO;
    
    @GetMapping("/")
    public String raiz() {
        return "redirect:/cliente/login";
    }

    @GetMapping("/interno/acceso")
    public String verPaginaDeLogin(Model model) {
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(@RequestParam String usuario,
                              @RequestParam String contrasena,
                              HttpServletRequest request,
                              RedirectAttributes redirectAttributes) {

        Optional<TbEmpleado> optEmpleado = empleadoDAO.findByUsuarioAndContrasena(usuario, contrasena);

        if (optEmpleado.isPresent()) {
            TbEmpleado empleado = optEmpleado.get();
            if ("ACTIVO".equals(empleado.getEstado())) {
                
                HttpSession session = request.getSession(true);
                session.setAttribute("empleadoLogueado", empleado);
                
                // --- LÓGICA DE REDIRECCIÓN POR ROL ---
                switch (empleado.getIdRol()) {
                    case 1: // ADMIN
                        return "redirect:/admin/dashboard";
                    case 2: // GERENTE
                        return "redirect:/gerente/dashboard";
                    case 3: // CAJERO (Recepcionista)
                        return "redirect:/recepcion/dashboard";
                    case 4: // VIGILANTE
                        return "redirect:/vigilante/dashboard";
                    default:
                        redirectAttributes.addFlashAttribute("error", "Rol no autorizado.");
                        return "redirect:/interno/acceso";
                }
                
            } else {
                redirectAttributes.addFlashAttribute("error", "El usuario está inactivo.");
                return "redirect:/interno/acceso";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Usuario o contraseña incorrectos.");
            return "redirect:/interno/acceso";
        }
    }

    @GetMapping("/logout")
    public String cerrarSesion(HttpSession session) {
        session.invalidate();
        return "redirect:/interno/acceso";
    }
    
    @GetMapping("/logout2")
    public String cerrarSesion2(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
    
    @GetMapping("/vigilante/dashboard")
    public String verDashboardVigilante(HttpSession session, Model model) {
        TbEmpleado empleado = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (empleado == null || empleado.getIdRol() != 4) {
            return "redirect:/";
        }
        model.addAttribute("empleado", empleado);
        return "vigilante_dashboard";
    }
}