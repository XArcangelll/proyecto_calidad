package com.proyectoIntegrador.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.proyectoIntegrador.entity.Boleta;
import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.DetalleBoleta;
import com.proyectoIntegrador.entity.Producto;
import com.proyectoIntegrador.service.BoletaService;
import com.proyectoIntegrador.service.ClienteService;
import com.proyectoIntegrador.service.DetalleBoletaService;
import com.proyectoIntegrador.service.ProductoService;

@Controller
public class boletaController {

	@Autowired
	private BoletaService service;

	@Autowired
	private ProductoService servicePro;

	@Autowired
	private ClienteService serviceCli;

	@Autowired
	private DetalleBoletaService serviceDetBol;

	@RequestMapping("/listadoDetalleBoleta")
	@ResponseBody
	public List<DetalleBoleta> listadoDetalleBoleta(String idBoleta) {
		int id = Integer.parseInt(idBoleta);
		List<DetalleBoleta> listadetalleBoleta = serviceDetBol.listarDetallesPorBoleta(id);
		return listadetalleBoleta;
	}

	@RequestMapping("/detalleBoleta")
	@ResponseBody
	public Map<String, Object> detalleBoleta(HttpServletRequest request) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		if (session.getAttribute("objListaProductosTexto") != null) {
			String[] listaAyuda = session.getAttribute("objListaProductosTexto").toString().split(",");
			double totalPagar = 0;
			for (int i = 0; i < listaAyuda.length; i++) {
				totalPagar += servicePro.listaProductosId(Integer.parseInt(listaAyuda[i])).getPrecio();
			}
			salida.put("TOTAL", totalPagar);
			salida.put("FECHA", LocalDateTime.now().toString().split("T")[0]);
			return salida;
		} else {
			return salida;
		}
	}

	@RequestMapping("/agregarQuitarCantidad")
	@Transactional
	@ResponseBody
	public Map<String, Object> agregarCantidad(HttpServletRequest request, String idProducto, String cantidad) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		String[] listaProductos = session.getAttribute("objListaProductosBoletaTexto").toString().split(",");
		String listaAyuda = "";
		int contador = 0;
		int cant = Integer.parseInt(cantidad);
		int id = Integer.parseInt(idProducto);
		double totalPagar = 0;
		for (int i = 0; i < listaProductos.length; i++) {
			int idProd = Integer.parseInt(listaProductos[i].toString());
			if ((contador < cant) && (idProd == id)) {
				listaAyuda += String.valueOf(idProd) + ",";
				contador++;
			} else if (idProd != id) {
				listaAyuda += String.valueOf(idProd) + ",";
			}
		}
		if (contador < cant) {
			for (int i = contador; i < cant; i++) {
				listaAyuda += String.valueOf(idProducto) + ",";
			}
		}
		listaAyuda = listaAyuda.substring(0, listaAyuda.length() - 1);
		String[] listaProd = listaAyuda.split(",");
		for (int i = 0; i < listaProd.length; i++) {
			totalPagar += servicePro.listaProductosId(Integer.parseInt(listaProd[i])).getPrecio();
		}
		session.setAttribute("objListaProductosBoletaTexto", listaAyuda);
		salida.put("TOTAL", totalPagar);
		return salida;
	}

	@RequestMapping("/eliminarProductoBoleta")
	@Transactional
	@ResponseBody
	public Map<String, Object> eliminarProductoBoleta(HttpServletRequest request, String idProducto) {
		HttpSession session = request.getSession(true);
		Map<String, Object> salida = new HashMap<>();
		String[] listaProductosCarrito = session.getAttribute("objListaProductosTexto").toString().split(",");
		String[] listaProductos = session.getAttribute("objListaProductosBoletaTexto").toString().split(",");
		List<Producto> listaProductosEntidad = new ArrayList<Producto>();
		String ayuda = "";
		double totalPagar = 0;
		for (int i = 0; i < listaProductos.length; i++) {
			if (!listaProductos[i].equals(idProducto)) {
				ayuda += listaProductos[i] + ",";
				totalPagar += servicePro.listaProductosId(Integer.parseInt(listaProductos[i])).getPrecio();
				listaProductosEntidad.add(servicePro.listaProductosId(Integer.parseInt(listaProductos[i])));
			}
		}
		if (ayuda.length() == 0)
			session.setAttribute("objListaProductosBoletaTexto", null);
		else if (ayuda.split(",").length >= 1)
			session.setAttribute("objListaProductosBoletaTexto", ayuda.substring(0, ayuda.length() - 1));
		ayuda = "";
		for (int i = 0; i < listaProductosCarrito.length; i++) {
			if (!listaProductosCarrito[i].equals(idProducto)) {
				ayuda += listaProductosCarrito[i] + ",";
			}
		}
		if (ayuda.length() == 0)
			session.setAttribute("objListaProductosTexto", null);
		else if (ayuda.split(",").length >= 1)
			session.setAttribute("objListaProductosTexto", ayuda.substring(0, ayuda.length() - 1));
		String ultimoProducto = ayuda.split(",")[ayuda.split(",").length - 1];
		session.setAttribute("objContadorProductos",
				Integer.parseInt(session.getAttribute("objContadorProductos").toString()) - 1);
		session.setAttribute("objUltimoProducto", ultimoProducto);
		session.setAttribute("objListaProductosEntidad", listaProductosEntidad);
		salida.put("TOTAL", totalPagar);
		salida.put("CANTIDAD", session.getAttribute("objContadorProductos").toString());
		return salida;
	}

	@RequestMapping("/agregarBoleta")
	@Transactional
	@ResponseBody
	public Map<String, Object> agregarBoleta(HttpServletRequest request, Boleta obj) {
		Map<String, Object> salida = new HashMap<>();
		try {
			HttpSession session = request.getSession(true);
			if (session.getAttribute("objCargo") != null) {
				if (session.getAttribute("objCargo").equals("Cliente")) {
					String confirmacion = "SI";
					// Se obtienen los productos del carrito
					String[] listaProductosCarrito = session.getAttribute("objListaProductosTexto").toString()
							.split(",");
					String[] listaProductos = session.getAttribute("objListaProductosBoletaTexto").toString()
							.split(",");

					for (int i = 0; i < listaProductosCarrito.length; i++) {
						int contador = 0;
						for (int j = 0; j < listaProductos.length; j++) {
							if (listaProductosCarrito[i].equals(listaProductos[j])) {
								contador++;
							}
						}
						Producto producto = servicePro.listaProductosId(Integer.parseInt(listaProductosCarrito[i]));
						if (producto.getStock() < contador) {
							confirmacion = "NO";
							salida.put("MENSAJE",
									"El producto " + producto.getNombre()
											+ " no tiene el stock suficiente.El stock actual es de "
											+ producto.getStock() + ".");
							break;
						}
					}
					if (!confirmacion.equals("NO")) {
						int idCliente = Integer.parseInt(session.getAttribute("objIdCliente").toString());
						Cliente c = serviceCli.listaClientesId(idCliente);
						obj.setNumero("111111111");
						obj.setNombre(c.getNombre() + " " + c.getApellido());
						obj.setDni(c.getDni());
						obj.setFecha(LocalDateTime.now().toString().split("T")[0]);
						obj.setEstado("En Proceso");
						obj.setIdCliente(c);
						service.agregarBoleta(obj);
						for (int i = 0; i < listaProductosCarrito.length; i++) {
							int contador = 0;
							double costo = 0;
							for (int j = 0; j < listaProductos.length; j++) {
								if (listaProductosCarrito[i].equals(listaProductos[j])) {
									contador++;
									costo += servicePro.listaProductosId(Integer.parseInt(listaProductosCarrito[i]))
											.getPrecio();
								}
							}
							Producto producto = servicePro.listaProductosId(Integer.parseInt(listaProductosCarrito[i]));
							producto.setStock(producto.getStock() - contador);
							servicePro.agregarModificarProducto(producto);
							DetalleBoleta detalleBoleta = new DetalleBoleta();
							detalleBoleta.setCantidad(contador);
							detalleBoleta.setCosto(costo);
							detalleBoleta.setIdProducto(
									servicePro.listaProductosId(Integer.parseInt(listaProductosCarrito[i])));
							detalleBoleta.setIdBoleta(obj);
							serviceDetBol.agregarDetalleBoleta(detalleBoleta);
						}
						session.removeAttribute("objListaProductosTexto");
						session.removeAttribute("objListaProductosBoletaTexto");
						session.removeAttribute("objContadorProductos");
						session.removeAttribute("objUltimoProducto");
						session.removeAttribute("objListaProductosEntidad");
						salida.put("CONFIRMACION", "SI");
						salida.put("MENSAJE", "La Boleta fue registrada correctamente");
					}
					return salida;
				} else {
					salida.put("MENSAJE", "Error al registrar la boleta.");
					return salida;
				}
			}
			return salida;
		} catch (Exception e) {
			e.printStackTrace();
			salida.put("MENSAJE", "Error al registrar la boleta.");
			return salida;
		}
	}

	@RequestMapping("/editarBoleta")
	@ResponseBody
	public Map<String, Object> editarBoleta(HttpServletRequest request, String idBoleta, String estado) {
		Map<String, Object> salida = new HashMap<>();
		HttpSession session = request.getSession(true);
		if (session.getAttribute("objCargo") != null) {
			if (session.getAttribute("objCargo").equals("Personal de Ventas")) {
				Boleta boleta = service.listarBoletasId(Integer.parseInt(idBoleta));
				boleta.setEstado(estado);
				service.agregarBoleta(boleta);
				salida.put("CONFIRMACION", "SI");
				salida.put("MENSAJE", "Éxito al editar la Boleta.");
				return salida;
			}
		}
		salida.put("CONFIRMACION", "NO");
		salida.put("MENSAJE", "Error al editar la Boleta.");
		return salida;
	}
}
