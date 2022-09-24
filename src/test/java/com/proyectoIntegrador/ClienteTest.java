package com.proyectoIntegrador;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase.Replace;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.annotation.Rollback;


import com.proyectoIntegrador.entity.Cliente;
import com.proyectoIntegrador.entity.Distrito;
import com.proyectoIntegrador.entity.Usuario;
import com.proyectoIntegrador.repository.ClienteRepository;
import com.proyectoIntegrador.repository.UsuarioRepository;

@DataJpaTest
@AutoConfigureTestDatabase(replace = Replace.NONE)
public class ClienteTest {

	@Autowired
	private ClienteRepository repositorioCliente;
	
	@Autowired
	private UsuarioRepository repositorioUsuario;
	
	private BCryptPasswordEncoder encoder;
	
	
	@Test
	@Rollback(false)
	public void TestRegistrarUsuario() {
		Usuario usuario = new Usuario("RobertoCarlos","RobertoCarlos123","Cliente");
		Usuario usuarioGuardado =  repositorioUsuario.save(usuario);
		assertNotNull(usuarioGuardado);
	}
	
	
	
	@Test
	@Rollback(false)
	public void TestRegistrarUsuarioEncriptado() {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		Usuario usuario = new Usuario("PepitoCarlos","PepitoCarlos123","Cliente");
		usuario.setContrasenia(encoder.encode(usuario.getContrasenia()));
		Usuario usuarioGuardado =  repositorioUsuario.save(usuario);
		assertNotNull(usuarioGuardado);
	
	}
	
	
	@Test
	@Rollback(false)
	public void TestRegistrarCliente() {
		 Distrito distrito = new Distrito();
		 distrito.setIdDistrito(25);	
		Usuario usuario = new Usuario("Caballero123","Caballero123","Cliente");
		Usuario usuarioGuardado =  repositorioUsuario.save(usuario);
		Cliente cliente = new Cliente("Pedro","Marmol","Plaza sesamo","1234567","987123457",
				"78014597","jorgito@gmail.com", distrito, usuario
				);
		Cliente clienteguardado =  repositorioCliente.save(cliente);
		assertNotNull(usuarioGuardado);
		assertNotNull(clienteguardado);
	
	}
	
	@Test
	@Rollback(false)
	public void TestRegistrarClienteEncriptado() {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		 Distrito distrito = new Distrito(); 
		 distrito.setIdDistrito(27);	
		Usuario usuario = new Usuario("Rengoku123","Sanemi9874","Cliente");
		usuario.setContrasenia(encoder.encode(usuario.getContrasenia()));
		Usuario usuarioGuardado =  repositorioUsuario.save(usuario);
		Cliente cliente = new Cliente("Carlos","Castro","Polinesio 15","1234567","987123457",
				"78012347","carlos@gmail.com", distrito, usuario
				);
		Cliente clienteguardado =  repositorioCliente.save(cliente);
		assertNotNull(usuarioGuardado);
		assertNotNull(clienteguardado);
	}
	
}
