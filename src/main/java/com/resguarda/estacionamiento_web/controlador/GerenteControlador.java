/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.*; 
import com.resguarda.estacionamiento_web.modelo.TbEmpleado;
import com.resguarda.estacionamiento_web.modelo.TbPiso;
import com.resguarda.estacionamiento_web.modelo.TbRol;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/gerente")
public class GerenteControlador {

    @Autowired
    private EmpleadoDAO empleadoDAO;
    @Autowired
    private RolDAO rolDAO;
    
    // --- INYECTAR NUEVOS DAOS PARA KPIs ---
    @Autowired
    private EspacioDAO espacioDAO;
    @Autowired
    private RegistroDAO registroDAO;
    @Autowired
    private PisoDAO pisoDAO;


    @GetMapping("/dashboard")
    public String verDashboardGerente(HttpSession session, Model model) {
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) {
            return "redirect:/";
        }
        
        // --- LÓGICA DE KPIs PARA EL DASHBOARD PROFESIONAL ---
        int idSede = gerente.getIdSede();
        
        // 1. Contar Empleados (excluyendo Admins)
        long totalEmpleados = empleadoDAO.countByIdSedeAndIdRolNot(idSede, 1);
        
        // 2. Contar Espacios Totales en la Sede
        long totalEspacios = espacioDAO.countByPisoIdSede(idSede);
        
        // 3. Contar Vehículos Estacionados AHORA
        long vehiculosAhora = registroDAO.countByEspacioPisoIdSedeAndEstado(idSede, "ESTACIONADO");

        model.addAttribute("kpi_total_empleados", totalEmpleados);
        model.addAttribute("kpi_total_espacios", totalEspacios);
        model.addAttribute("kpi_vehiculos_ahora", vehiculosAhora);
        model.addAttribute("titulo", "Dashboard Gerente");
        return "gerente_dashboard";
    }

    @GetMapping("/empleados")
    public String listarEmpleados(HttpSession session, Model model) {
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) {
            return "redirect:/";
        }
        
        List<TbEmpleado> listaEmpleados = empleadoDAO.findByIdSedeAndIdRolNot(gerente.getIdSede(), 1);

        model.addAttribute("empleados", listaEmpleados);
        model.addAttribute("titulo", "Gestión de Empleados");
        return "gerente_empleados";
    }

    // --- FORMULARIO NUEVO (sin cambios) ---
    @GetMapping("/empleados/nuevo")
    public String mostrarFormularioNuevo(HttpSession session, Model model) {
        // ... (código existente)
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) { return "redirect:/"; }
        List<TbRol> listaRoles = rolDAO.findAll();
        model.addAttribute("empleado", new TbEmpleado());
        model.addAttribute("listaRoles", listaRoles);
        model.addAttribute("titulo", "Nuevo Empleado");
        return "gerente_empleado_form";
    }

    // --- FORMULARIO EDITAR (sin cambios) ---
    @GetMapping("/empleados/editar/{id}")
    public String mostrarFormularioEditar(@PathVariable Integer id, HttpSession session, Model model, RedirectAttributes redirectAttributes) {
        // ... (código existente)
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) { return "redirect:/"; }
        Optional<TbEmpleado> optEmpleado = empleadoDAO.findById(id);
        if (optEmpleado.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Empleado no encontrado.");
            return "redirect:/gerente/empleados";
        }
        List<TbRol> listaRoles = rolDAO.findAll();
        model.addAttribute("empleado", optEmpleado.get());
        model.addAttribute("listaRoles", listaRoles);
        model.addAttribute("titulo", "Editar Empleado");
        return "gerente_empleado_form";
    }

    @PostMapping("/empleados/guardar")
    public String guardarEmpleado(@ModelAttribute TbEmpleado empleado, HttpSession session, RedirectAttributes redirectAttributes) {
        // ... (código existente)
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) { return "redirect:/"; }
        empleado.setIdSede(gerente.getIdSede()); 
        if (empleado.getIdEmpleado() == 0 && empleado.getContrasena().isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "La contraseña es obligatoria para nuevos empleados.");
            return "redirect:/gerente/empleados/nuevo";
        }
        empleadoDAO.save(empleado);
        redirectAttributes.addFlashAttribute("exito", "Empleado guardado correctamente.");
        return "redirect:/gerente/empleados";
    }
    @GetMapping("/espacios")
    public String gestionarPisosYEspacios(HttpSession session, Model model) {
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) {
            return "redirect:/";
        }

        List<TbPiso> pisosDeSede = pisoDAO.findAllBySedeWithEspacios(gerente.getIdSede());
        
        model.addAttribute("pisos", pisosDeSede);
        model.addAttribute("titulo", "Gestión de Pisos y Espacios");
        return "gerente_espacios"; 
    }

    @GetMapping("/pisos/nuevo")
    public String mostrarFormularioNuevoPiso(HttpSession session, Model model) {
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) {
            return "redirect:/";
        }

        model.addAttribute("piso", new TbPiso()); 
        model.addAttribute("titulo", "Nuevo Piso");
        return "gerente_piso_form"; 
    }

    @PostMapping("/pisos/guardar")
    public String guardarPiso(@ModelAttribute TbPiso piso, HttpSession session, RedirectAttributes redirectAttributes) {
        TbEmpleado gerente = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (gerente == null || gerente.getIdRol() != 2) {
            return "redirect:/";
        }

        piso.setIdSede(gerente.getIdSede());
        piso.setEstado("ACTIVO");
        
        pisoDAO.save(piso);
        
        redirectAttributes.addFlashAttribute("exito", "Piso '" + piso.getNombrePiso() + "' creado exitosamente.");
        return "redirect:/gerente/espacios";
    }
}