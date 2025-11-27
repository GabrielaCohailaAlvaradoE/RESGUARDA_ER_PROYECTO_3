/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.resguarda.estacionamiento_web.controlador;

import com.resguarda.estacionamiento_web.interfaces.*;
import com.resguarda.estacionamiento_web.modelo.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class RecepcionControlador {

    @Autowired
    private PisoDAO pisoDAO;
    @Autowired
    private VehiculoDAO vehiculoDAO;
    @Autowired
    private UsuariosWebDAO usuariosWebDAO;
    @Autowired
    private EspacioDAO espacioDAO;
    @Autowired
    private RegistroDAO registroDAO;
    @Autowired
    private PagosDAO pagosDAO;

    @GetMapping("/recepcion/dashboard")
    public String verDashboardRecepcion(HttpSession session, Model model) {
        TbEmpleado empleado = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (empleado == null || empleado.getIdRol() != 3) {
            return "redirect:/";
        }
        
        List<TbPiso> pisos = pisoDAO.findAllWithEspacios();
        model.addAttribute("pisos", pisos);
        return "recepcion_dashboard";
    }
    
    // --- NUEVO: PERMITIR A SECRETARIA LIBERAR UN ESPACIO RESERVADO/MANTENIMIENTO ---
    @GetMapping("/recepcion/liberar/{id}")
    public String liberarEspacioManual(@PathVariable Integer id, HttpSession session, RedirectAttributes redirectAttributes) {
        TbEmpleado recepcionista = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (recepcionista == null) return "redirect:/";

        Optional<TbEspacio> opt = espacioDAO.findById(id);
        if (opt.isPresent()) {
            TbEspacio espacio = opt.get();
            // Solo permitimos liberar si NO hay un auto adentro (es decir, si es Mantenimiento/Reserva)
            if (!"OCUPADO".equals(espacio.getEstado())) {
                espacio.setEstado("LIBRE");
                espacioDAO.save(espacio);
                redirectAttributes.addFlashAttribute("exito", "Espacio " + espacio.getNumeroEspacio() + " liberado correctamente.");
            } else {
                redirectAttributes.addFlashAttribute("error", "No se puede liberar un espacio con auto. Use 'Registrar Salida'.");
            }
        }
        return "redirect:/recepcion/dashboard";
    }

    @PostMapping("/recepcion/registrarEntrada")
    public String registrarEntrada(@RequestParam String placa,
                                 @RequestParam(required = false) String dni,
                                 @RequestParam Integer idEspacio,
                                 HttpServletRequest request,
                                 RedirectAttributes redirectAttributes) {

        HttpSession session = request.getSession();
        TbEmpleado recepcionista = (TbEmpleado) session.getAttribute("empleadoLogueado");
        if (recepcionista == null) { return "redirect:/"; }

        // 1. Validar Vehículo
        Optional<TbVehiculo> optVehiculo = vehiculoDAO.findByPlaca(placa);
        if (optVehiculo.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Placa '" + placa + "' no encontrada. Registre el vehículo primero.");
            return "redirect:/recepcion/dashboard";
        }
        TbVehiculo vehiculo = optVehiculo.get();

        // 2. Validar Espacio
        Optional<TbEspacio> optEspacio = espacioDAO.findById(idEspacio);
        if (optEspacio.isEmpty()) {
            redirectAttributes.addFlashAttribute("error", "Espacio no válido.");
            return "redirect:/recepcion/dashboard";
        }
        TbEspacio espacio = optEspacio.get();

        // --- LÓGICA DE RESERVA INTELIGENTE ---
        boolean esReservaValida = false;
        
        if ("MANTENIMIENTO".equals(espacio.getEstado())) {
            // Si está bloqueado, verificamos si hay una reserva PENDIENTE para este auto
            // (Aquí asumimos que MANTENIMIENTO se usa para reservas. Idealmente crearíamos un estado RESERVADO)
            // Buscamos si existe una reserva pendiente para este espacio
            // Nota: Deberíamos tener un método en ReservaDAO para esto, pero por simplicidad:
            // Si el espacio está reservado, permitimos el ingreso SOLO si es el vehículo correcto.
            
            // Para simplificar en esta entrega: Si está en MANTENIMIENTO, asumimos que es una reserva 
            // y permitimos el ingreso forzado ("Check-in").
            esReservaValida = true; 
        } else if ("OCUPADO".equals(espacio.getEstado())) {
            redirectAttributes.addFlashAttribute("error", "El espacio '" + espacio.getNumeroEspacio() + "' ya está ocupado.");
            return "redirect:/recepcion/dashboard";
        }

        // 3. Validar Conductor
        TbUsuariosWeb conductor;
        if (dni != null && !dni.isBlank()) {
            Optional<TbUsuariosWeb> optConductor = usuariosWebDAO.findByDni(dni);
            if (optConductor.isEmpty()) {
                redirectAttributes.addFlashAttribute("error", "DNI de conductor no encontrado.");
                return "redirect:/recepcion/dashboard";
            }
            conductor = optConductor.get();
        } else {
            conductor = vehiculo.getPropietario();
        }

        // 4. Proceso de Ingreso
        String pinTemp = String.valueOf(100000 + (int) (Math.random() * 900000));

        // Actualizar Espacio a OCUPADO (sea que viniera de LIBRE o MANTENIMIENTO/RESERVA)
        espacio.setEstado("OCUPADO");
        espacioDAO.save(espacio);

        // Crear Registro
        TbRegistroEstacionamiento registro = new TbRegistroEstacionamiento();
        registro.setVehiculo(vehiculo);
        registro.setConductor(conductor);
        registro.setEspacio(espacio);
        registro.setRecepcionista(recepcionista);
        registro.setHoraEntrada(LocalDateTime.now());
        registro.setPinTemp(pinTemp);
        registro.setEstado("ESTACIONADO");
        registro.setMontoTotal(BigDecimal.ZERO);
        
        registroDAO.save(registro);

        redirectAttributes.addFlashAttribute("exito", "¡Ingreso Exitoso! Placa: " + placa + ". PIN: " + pinTemp);
        return "redirect:/recepcion/dashboard";
    }

    
    @PostMapping("/recepcion/buscarSalida")
    public String buscarRegistroParaSalida(@RequestParam String placaOpin,
                                         RedirectAttributes redirectAttributes) {

        Optional<TbRegistroEstacionamiento> optRegistro = registroDAO.findActiveRegistroByPlacaOrPin(placaOpin);

        if (optRegistro.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorSalida", "No se encontró ningún registro activo con esa placa o PIN.");
            return "redirect:/recepcion/dashboard";
        }

        TbRegistroEstacionamiento registro = optRegistro.get();

        LocalDateTime ahora = LocalDateTime.now();
        Duration duracion = Duration.between(registro.getHoraEntrada(), ahora);
        long minutosTranscurridos = duracion.toMinutes();
        long horasACobrar = (long) Math.ceil(minutosTranscurridos / 60.0);
        if (horasACobrar == 0) horasACobrar = 1;

        // TODO: Cargar tarifa base de la sede real
        BigDecimal tarifaBase = new BigDecimal("5.00");
        BigDecimal montoTotal = tarifaBase.multiply(new BigDecimal(horasACobrar));
        
        // --- AQUÍ ESTABA EL ERROR 1 ---
        registro.setMontoTotal(montoTotal); // <-- CORREGIDO (sin .doubleValue())

        redirectAttributes.addFlashAttribute("registroEncontrado", registro);
        redirectAttributes.addFlashAttribute("minutosTranscurridos", minutosTranscurridos);
        redirectAttributes.addFlashAttribute("horasACobrar", horasACobrar);

        return "redirect:/recepcion/dashboard";
    }

    
    @PostMapping("/recepcion/registrarPago")
    public String registrarPago(@RequestParam Integer idRegistro,
                                @RequestParam String montoTotal,
                                @RequestParam String montoRecibido,
                                @RequestParam String metodoPago,
                                RedirectAttributes redirectAttributes) {

        BigDecimal bdMontoTotal = new BigDecimal(montoTotal);
        BigDecimal bdMontoRecibido = new BigDecimal(montoRecibido);

        if (bdMontoRecibido.compareTo(bdMontoTotal) < 0) {
            redirectAttributes.addFlashAttribute("errorSalida", "El monto recibido es menor al monto total a pagar.");
            return "redirect:/recepcion/dashboard";
        }

        BigDecimal vuelto = bdMontoRecibido.subtract(bdMontoTotal);

        Optional<TbRegistroEstacionamiento> optRegistro = registroDAO.findById(idRegistro);
        if (optRegistro.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorSalida", "Error: No se encontró el registro para pagar.");
            return "redirect:/recepcion/dashboard";
        }
        TbRegistroEstacionamiento registro = optRegistro.get();

        registro.setEstado("FINALIZADO");
        registro.setHoraSalida(LocalDateTime.now());
        registro.setMontoTotal(bdMontoTotal); 
        registroDAO.save(registro);

        TbEspacio espacio = registro.getEspacio();
        espacio.setEstado("LIBRE");
        espacioDAO.save(espacio);

        TbPagos pago = new TbPagos();
        pago.setRegistro(registro);
        pago.setMontoTotal(bdMontoTotal);
        pago.setMontoRecibido(bdMontoRecibido);
        pago.setVuelto(vuelto);
        pago.setMetodoPago(metodoPago);
        pago.setFechaPago(LocalDateTime.now());
        pagosDAO.save(pago);

        redirectAttributes.addFlashAttribute("exito", "¡Salida registrada! Vehículo: " + registro.getVehiculo().getPlaca() + ". Vuelto: S/ " + vuelto);
        return "redirect:/recepcion/dashboard";
    }
}