package com.proyectoIntegrador.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.Trabajador;
import com.proyectoIntegrador.entity.Usuario;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.TrabajadorService;
import com.proyectoIntegrador.service.UsuarioService;

@Controller
public class usuarioController {

	@Autowired
	private UsuarioService service;

	@Autowired
	private ClienteService serviceCli;

	@Autowired
	private TrabajadorService serviceTra;

	@RequestMapping("/login")
	public String login(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") == null) {
			return "login";
		} else {
			if (session.getAttribute("objCargo").equals("Cliente")) {
				return "redirect:datosMascotas";
			} else if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
				return "redirect:crudProductos";
			} else {
				return "redirect:listaProductos";
			}
		}
	}

	@RequestMapping("/validacionLogin")
	@ResponseBody
	public Map<String, Object> validacionLogin(HttpServletRequest request, String nom_usuario, String con_usuario) {
		Map<String, Object> salida = new HashMap<>();
		try {
			HttpSession session = request.getSession(true);
			Usuario usu = service.findByNomUsuario(nom_usuario);
			if (usu == null) {
				salida.put("CONFIRMACION", "NO");
				salida.put("MENSAJE", "Usuario Incorrecto");
				return salida;
			}
			PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
			boolean confirmar = passwordEncoder.matches(con_usuario, usu.getContrasenia());
			if (confirmar) {
				session.setAttribute("objUsuario", usu.getNomUsuario());
				if (usu.getCargo().equals("Cliente")) {
					Cliente cli = serviceCli.listaClienteUsuario(usu.getIdUsuario());
					if (cli != null) {
						salida.put("USUARIO", cli.getApellido() + ", " + cli.getNombre());
					}
				} else if (!usu.getCargo().equals("Cliente")) {
					Trabajador tra = serviceTra.buscarTrabajadorUsuario(usu.getIdUsuario());
					if (tra != null) {
						salida.put("USUARIO", tra.getApellido() + ", " + tra.getNombre());
					}
				}
				salida.put("CONFIRMACION", "SI");
				return salida;
			} else {
				salida.put("CONFIRMACION", "NO");
				salida.put("MENSAJE", "Contreña Incorrecta");
				return salida;
			}
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("CONFIRMACION", "NO");
			salida.put("MENSAJE", "Error al ingresar");
			return salida;
		}
	}

	@RequestMapping("/redireccionar")
	public String redireccionar(HttpServletRequest request) {
		try {
			HttpSession session = request.getSession(true);
			if (session.getAttribute("objUsuario") != null) {
				session.setAttribute("mensajeLogin", null);
				String nomUsu = session.getAttribute("objUsuario").toString();
				Usuario usu = service.findByNomUsuario(nomUsu);
				session.setAttribute("objCargo", usu.getCargo());
				if (usu.getCargo().equals("Cliente")) {
					Cliente cli = serviceCli.listaClienteUsuario(usu.getIdUsuario());
					session.setAttribute("objIdCliente", cli.getIdCliente());
					return "redirect:datosMascotas";
				} else if (!usu.getCargo().equals("Cliente")) {
					Trabajador tra = serviceTra.buscarTrabajadorUsuario(usu.getIdUsuario());
					session.setAttribute("objIdTrabajador", tra.getIdTrabajador());
					if (usu.getCargo().equals("Personal de Ventas"))
						return "redirect:crudProductos";
					else if (usu.getCargo().equals("Veterinario"))
						return "redirect:historialMascotas";
				}
			}
			return "redirect:error404";
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:error404";
		}
	}

	@RequestMapping("/salir")
	public String salir(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("objCargo");
		session.removeAttribute("objIdCliente");
		session.removeAttribute("objUsuario");
		session.removeAttribute("objIdTrabajador");
		System.out.println(session.getAttributeNames().toString());
		return "redirect:listaProductos";
	}

}
