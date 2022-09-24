package com.proyectoIntegrador.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Data;

@Entity
@Table(name = "cliente")
@Data
public class Cliente {

	@Column(name = "idcliente")
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int idCliente;

	@Column(name = "nombre")
	private String nombre;

	@Column(name = "apellido")
	private String apellido;

	@Column(name = "direccion")
	private String direccion;

	@Column(name = "telefono")
	private String telefono;

	@Column(name = "celular")
	private String celular;

	@Column(name = "dni")
	private String dni;

	@Column(name = "email")
	private String email;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "iddistrito")
	private Distrito idDistrito;

	@JsonIgnoreProperties({ "hibernateLazyInitializer", "handler" })
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "idusuario")
	private Usuario idUsuario;

	public Cliente(int idCliente, String nombre, String apellido, String direccion, String telefono, String celular,
			String dni, String email, Distrito idDistrito, Usuario idUsuario) {
		super();
		this.idCliente = idCliente;
		this.nombre = nombre;
		this.apellido = apellido;
		this.direccion = direccion;
		this.telefono = telefono;
		this.celular = celular;
		this.dni = dni;
		this.email = email;
		this.idDistrito = idDistrito;
		this.idUsuario = idUsuario;
	}

	public Cliente(String nombre, String apellido, String direccion, String telefono, String celular, String dni,
			String email, Distrito idDistrito, Usuario idUsuario) {
		super();
		this.nombre = nombre;
		this.apellido = apellido;
		this.direccion = direccion;
		this.telefono = telefono;
		this.celular = celular;
		this.dni = dni;
		this.email = email;
		this.idDistrito = idDistrito;
		this.idUsuario = idUsuario;
	}

	public Cliente(int idCliente) {
		super();
		this.idCliente = idCliente;
	}

	public Cliente() {
		super();
	}
	
	
	
	
	
}
