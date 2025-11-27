/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.*;
import com.resguarda.estacionamiento_web.modelo.*;
import com.resguarda.estacionamiento_web.util.ApiClientDni;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.resguarda.estacionamiento_web.modelo.TbAlerta;

@Controller
public class ClienteWebControlador {

    @Autowired
    private ApiClientDni apiClientDni;
    @Autowired
    private UsuariosWebDAO usuariosWebDAO;
    @Autowired
    private ReservaDAO reservaDAO;
    @Autowired
    private EspacioDAO espacioDAO;
    @Autowired
    private PisoDAO pisoDAO;
    @Autowired
    private RegistroDAO registroDAO;
    @Autowired
    private AlertaDAO alertaDAO;
    @Autowired
    private EmpleadoDAO empleadoDAO;
    @Autowired
    private VehiculoDAO vehiculoDAO;
    @Autowired
    private AutorizacionDAO autorizacionDAO;
    @Autowired
    private PagosDAO pagosDAO;

    // --- REGISTRO ---
    @GetMapping("/registro")
    public String verPaginaRegistro() {
        return "cliente_registro";
    }

    @GetMapping("/api/consultarDni")
    @ResponseBody
    public ResponseEntity<?> consultarDniApi(@RequestParam String dni) {
        TbUsuariosWeb cliente = apiClientDni.consultarDni(dni);
        if (cliente != null) {
            return ResponseEntity.ok(cliente);
        } else {
            return ResponseEntity.status(404).body(Map.of("error", "DNI no encontrado"));
        }
    }

    @PostMapping("/registroCliente")
    public String registrarCliente(
            @RequestParam String dni, @RequestParam String nombres,
            @RequestParam String apellidos, @RequestParam String email,
            @RequestParam String contrasena, RedirectAttributes redirectAttributes) {
        
        if (usuariosWebDAO.findByDni(dni).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "El DNI ya está registrado.");
            return "redirect:/registro";
        }
        
        TbUsuariosWeb nuevoCliente = new TbUsuariosWeb();
        nuevoCliente.setDni(dni);
        nuevoCliente.setNombres(nombres);
        nuevoCliente.setApellidos(apellidos);
        nuevoCliente.setEmail(email);
        nuevoCliente.setContrasena(contrasena); 

        usuariosWebDAO.save(nuevoCliente);

        redirectAttributes.addFlashAttribute("exito", "¡Te has registrado con éxito! Ahora puedes iniciar sesión.");
        return "redirect:/cliente/login";
    }

    // --- LOGIN ---
    @GetMapping("/cliente/login")
    public String verLoginCliente() {
        return "cliente_login";
    }

    @PostMapping("/cliente/login")
    public String procesarLoginCliente(@RequestParam String dni,
                                     @RequestParam String contrasena,
                                     HttpServletRequest request,
                                     RedirectAttributes redirectAttributes) {

        Optional<TbUsuariosWeb> optCliente = usuariosWebDAO.findByDni(dni);

        if (optCliente.isPresent() && optCliente.get().getContrasena().equals(contrasena)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("clienteLogueado", optCliente.get());
            return "redirect:/cliente/reservas";
        } else {
            redirectAttributes.addFlashAttribute("error", "DNI o contraseña incorrectos.");
            return "redirect:/cliente/login";
        }
    }

    // --- RESERVAS ---
    @GetMapping("/cliente/reservas")
    public String verMisReservas(HttpSession session, Model model) {
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        // 1. Cargar Datos Principales (lo que ya tenías)
        List<TbReservas> misReservas = reservaDAO.findByClienteIdUsuarioOrderByFechaReservaDesc(cliente.getIdUsuario());
        List<TbPiso> pisos = pisoDAO.findAllWithEspacios();

        Optional<TbRegistroEstacionamiento> optRegistroActivo = registroDAO.findActiveRegistroByClienteId(cliente.getIdUsuario());
        if (optRegistroActivo.isPresent()) {
            // ... (Tu lógica de cálculo de tiempo/tarifa existente) ...
            // ... (Copia tu lógica de BigDecimal aquí dentro) ...
            TbRegistroEstacionamiento registroActivo = optRegistroActivo.get();
            LocalDateTime ahora = LocalDateTime.now();
            Duration duracion = Duration.between(registroActivo.getHoraEntrada(), ahora);
            long minutosTranscurridos = duracion.toMinutes();
            long horasACobrar = (long) Math.ceil(minutosTranscurridos / 60.0);
            if (horasACobrar == 0) horasACobrar = 1;
            BigDecimal tarifaBase = new BigDecimal("5.00"); 
            BigDecimal tarifaActual = tarifaBase.multiply(new BigDecimal(horasACobrar));
            
            model.addAttribute("registroActivo", registroActivo);
            model.addAttribute("minutosTranscurridos", minutosTranscurridos);
            model.addAttribute("tarifaActual", tarifaActual);
        }

        // 2. --- ¡NUEVO! CARGAR ALERTAS ---
        List<TbAlerta> alertas = alertaDAO.findByUsuarioIdUsuarioOrderByFechaDesc(cliente.getIdUsuario());
        long alertasNoLeidas = alertaDAO.countByUsuarioIdUsuarioAndLeidaFalse(cliente.getIdUsuario());
        
        // Si no hay alertas, creamos una de bienvenida (Simulación para que veas el diseño)
        if (alertas.isEmpty()) {
            TbAlerta bienvenida = new TbAlerta();
            bienvenida.setTitulo("¡Bienvenido a Resguarda!");
            bienvenida.setMensaje("Gracias por registrarte. Aquí recibirás notificaciones sobre tu vehículo.");
            bienvenida.setTipo("INFO");
            bienvenida.setFecha(LocalDateTime.now());
            bienvenida.setLeida(false);
            // No la guardamos en BD para no llenar basura, solo la mostramos
            alertas.add(bienvenida);
            alertasNoLeidas = 1;
        }

        // 3. --- ¡NUEVO! CARGAR PERSONAL EN TURNO (Simulado por ahora) ---
        // En un sistema real, buscaríamos en tb_guardias_turno. 
        // Aquí tomamos el primer VIGILANTE y RECEPCIONISTA activos de la BD para mostrar.
        List<TbEmpleado> vigilantes = empleadoDAO.findByIdSedeAndIdRolNot(1, 0); // Trae todos
        TbEmpleado guardiaTurno = vigilantes.stream().filter(e -> e.getIdRol() == 4).findFirst().orElse(null);
        TbEmpleado recepcionistaTurno = vigilantes.stream().filter(e -> e.getIdRol() == 3).findFirst().orElse(null);

        model.addAttribute("alertas", alertas);
        model.addAttribute("alertasNoLeidas", alertasNoLeidas);
        model.addAttribute("guardiaTurno", guardiaTurno);
        model.addAttribute("recepcionistaTurno", recepcionistaTurno);

        model.addAttribute("misReservas", misReservas);
        model.addAttribute("pisos", pisos);
        model.addAttribute("titulo", "Mis Reservas");
        return "cliente_reservas";
    }

    @PostMapping("/cliente/crearReserva")
    public String crearReserva(@RequestParam Integer idEspacio,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        Optional<TbEspacio> optEspacio = espacioDAO.findById(idEspacio);
        if (optEspacio.isEmpty() || !"LIBRE".equals(optEspacio.get().getEstado())) {
            redirectAttributes.addFlashAttribute("error", "El espacio seleccionado no está disponible.");
            return "redirect:/cliente/reservas";
        }

        TbEspacio espacio = optEspacio.get();
        espacio.setEstado("MANTENIMIENTO"); 
        espacioDAO.save(espacio);

        TbReservas reserva = new TbReservas();
        reserva.setCliente(cliente);
        reserva.setEspacio(espacio);
        reserva.setFechaReserva(LocalDateTime.now());
        reserva.setEstado("PENDIENTE");
        reserva.setMontoReserva(new BigDecimal("5.00"));
        reserva.setFechaHoraReserva(LocalDateTime.now());
        
        reservaDAO.save(reserva);

        redirectAttributes.addFlashAttribute("exito", "¡Reserva creada! El espacio " + espacio.getNumeroEspacio() + " es tuyo.");
        return "redirect:/cliente/reservas";
    }
    
    @PostMapping("/cliente/cancelarReserva")
    public String cancelarReserva(@RequestParam Integer idReserva,
                                HttpSession session,
                                RedirectAttributes redirectAttributes) {
        
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        Optional<TbReservas> optReserva = reservaDAO.findById(idReserva);
        
        if (optReserva.isEmpty() || optReserva.get().getCliente().getIdUsuario() != cliente.getIdUsuario()) {
            redirectAttributes.addFlashAttribute("error", "No se pudo encontrar la reserva a cancelar.");
            return "redirect:/cliente/reservas";
        }
        
        TbReservas reserva = optReserva.get();
        
        if (!"PENDIENTE".equals(reserva.getEstado())) {
             redirectAttributes.addFlashAttribute("error", "Esta reserva ya no se puede cancelar.");
             return "redirect:/cliente/reservas";
        }

        TbEspacio espacio = reserva.getEspacio();
        espacio.setEstado("LIBRE");
        espacioDAO.save(espacio);

        reserva.setEstado("CANCELADA");
        reservaDAO.save(reserva);

        redirectAttributes.addFlashAttribute("exito", "Reserva #" + reserva.getIdReserva() + " cancelada exitosamente.");
        return "redirect:/cliente/reservas";
    }

    // --- VEHÍCULOS ---
    @GetMapping("/cliente/vehiculos")
    public String verMisVehiculos(HttpSession session, Model model) {
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        List<TbVehiculo> misVehiculos = vehiculoDAO.findByPropietarioIdUsuario(cliente.getIdUsuario());

        model.addAttribute("vehiculoNuevo", new TbVehiculo());
        model.addAttribute("misVehiculos", misVehiculos);
        model.addAttribute("titulo", "Mis Vehículos");
        return "cliente_vehiculos";
    }

    @PostMapping("/cliente/agregarVehiculo")
    public String agregarVehiculo(@ModelAttribute TbVehiculo vehiculoNuevo, 
                                HttpSession session, RedirectAttributes redirectAttributes) {
        
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        if (vehiculoDAO.findByPlaca(vehiculoNuevo.getPlaca()).isPresent()) {
            redirectAttributes.addFlashAttribute("error", "La placa '" + vehiculoNuevo.getPlaca() + "' ya está registrada.");
            return "redirect:/cliente/vehiculos";
        }

        vehiculoNuevo.setPropietario(cliente);
        vehiculoNuevo.setFechaActualizacion(LocalDateTime.now());
        vehiculoDAO.save(vehiculoNuevo);

        redirectAttributes.addFlashAttribute("exito", "Vehículo añadido correctamente.");
        return "redirect:/cliente/vehiculos";
    }
    
    @PostMapping("/cliente/eliminarVehiculo")
    public String eliminarVehiculo(@RequestParam Integer idVehiculo,
                                 HttpSession session, RedirectAttributes redirectAttributes) {
        
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        Optional<TbVehiculo> optVehiculo = vehiculoDAO.findById(idVehiculo);

        if (optVehiculo.isEmpty() || optVehiculo.get().getPropietario().getIdUsuario() != cliente.getIdUsuario()) {
            redirectAttributes.addFlashAttribute("error", "No se pudo eliminar el vehículo.");
            return "redirect:/cliente/vehiculos";
        }
        
        vehiculoDAO.deleteById(idVehiculo);
        redirectAttributes.addFlashAttribute("exito", "Vehículo eliminado correctamente.");
        return "redirect:/cliente/vehiculos";
    }

    // --- SEGURIDAD Y PAGOS ---
    @GetMapping("/cliente/seguridad")
    public String verSeguridad(HttpSession session, Model model) {
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        List<TbAutorizaciones> autorizaciones = autorizacionDAO.findByPropietarioIdUsuarioOrderByFechaCreacionDesc(cliente.getIdUsuario());
        List<TbPagos> historialPagos = pagosDAO.findPagosByCliente(cliente.getIdUsuario());
        List<TbVehiculo> misVehiculos = vehiculoDAO.findByPropietarioIdUsuario(cliente.getIdUsuario());

        model.addAttribute("autorizaciones", autorizaciones);
        model.addAttribute("historialPagos", historialPagos);
        model.addAttribute("misVehiculos", misVehiculos);
        model.addAttribute("titulo", "Seguridad y Pagos");
        
        return "cliente_seguridad";
    }

    @PostMapping("/cliente/crearAutorizacion")
    public String crearAutorizacion(@RequestParam Integer idVehiculo,
                                  @RequestParam String dniAutorizado,
                                  @RequestParam String nombresAutorizado,
                                  HttpSession session, RedirectAttributes redirectAttributes) {
        
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        Optional<TbVehiculo> optVehiculo = vehiculoDAO.findById(idVehiculo);
        if (optVehiculo.isEmpty() || optVehiculo.get().getPropietario().getIdUsuario() != cliente.getIdUsuario()) {
             redirectAttributes.addFlashAttribute("error", "Vehículo inválido.");
             return "redirect:/cliente/seguridad";
        }

        TbAutorizaciones aut = new TbAutorizaciones();
        aut.setPropietario(cliente);
        aut.setVehiculo(optVehiculo.get());
        aut.setDniAutorizado(dniAutorizado);
        aut.setNombresAutorizado(nombresAutorizado);
        aut.setFechaCreacion(LocalDateTime.now());
        aut.setFechaExpiracion(LocalDateTime.now().plusHours(24)); 
        aut.setEstado("ACTIVA");

        autorizacionDAO.save(aut);

        redirectAttributes.addFlashAttribute("exito", "Autorización creada para " + nombresAutorizado);
        return "redirect:/cliente/seguridad";
    }
    
    // --- PERFIL ---
    // ¡ESTE ERA EL DUPLICADO! Ya lo he arreglado, ahora solo hay UNO.
    @GetMapping("/cliente/perfil")
    public String verPerfil(HttpSession session, Model model) {
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }
        
        model.addAttribute("cliente", cliente);
        model.addAttribute("titulo", "Mi Perfil");
        return "cliente_perfil";
    }

    @PostMapping("/cliente/actualizarPerfil")
    public String actualizarPerfil(@RequestParam String nombres,
                                 @RequestParam String apellidos,
                                 @RequestParam String email,
                                 @RequestParam(required = false) String nuevaContrasena,
                                 HttpSession session, RedirectAttributes redirectAttributes) {
        
        TbUsuariosWeb clienteSession = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (clienteSession == null) { return "redirect:/cliente/login"; }

        Optional<TbUsuariosWeb> optCliente = usuariosWebDAO.findById(clienteSession.getIdUsuario());
        if (optCliente.isPresent()) {
            TbUsuariosWeb clienteBD = optCliente.get();
            clienteBD.setNombres(nombres);
            clienteBD.setApellidos(apellidos);
            clienteBD.setEmail(email);
            
            if (nuevaContrasena != null && !nuevaContrasena.isBlank()) {
                clienteBD.setContrasena(nuevaContrasena);
            }
            
            usuariosWebDAO.save(clienteBD);
            session.setAttribute("clienteLogueado", clienteBD); 
            
            redirectAttributes.addFlashAttribute("exito", "Perfil actualizado correctamente.");
        }
        
        return "redirect:/cliente/perfil";
    }
    
    @GetMapping("/cliente/mapa")
    public String verMapaEnVivo(HttpSession session, Model model) {
        TbUsuariosWeb cliente = (TbUsuariosWeb) session.getAttribute("clienteLogueado");
        if (cliente == null) { return "redirect:/cliente/login"; }

        // 1. Cargar la estructura del estacionamiento (Pisos y Espacios)
        List<TbPiso> pisos = pisoDAO.findAllWithEspacios();
        
        // 2. Buscar si el cliente tiene un vehículo estacionado actualmente
        //    (Para saber cuál hacer parpadear)
        Optional<TbRegistroEstacionamiento> optRegistro = registroDAO.findActiveRegistroByClienteId(cliente.getIdUsuario());
        
        if (optRegistro.isPresent()) {
            model.addAttribute("miEspacioId", optRegistro.get().getEspacio().getIdEspacio());
            model.addAttribute("miPlaca", optRegistro.get().getVehiculo().getPlaca());
        }

        model.addAttribute("pisos", pisos);
        model.addAttribute("titulo", "Mapa en Vivo");
        
        return "cliente_mapa"; // Nueva vista JSP
    }
}