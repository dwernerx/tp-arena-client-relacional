package ar.edu.AppModel

import ar.edu.Repositorios.RepositorioUsuario
import ar.edu.usuario.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class LoginAppModel {
	String cuenta
	String password
	Usuario usuarioLogueado
	
	def RepositorioUsuario getRepositorioUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
	
	def iniciarSesion() {
		usuarioLogueado = repositorioUsuarios.iniciarSesion(new Usuario(cuenta,password))
//		usuarioLogueado = repositorioUsuarios.iniciarSesion(cuenta,password)
		/** en el repo toma la cuenta y el password del usuario, no estaria mejor si se 
		 * pasan estos dos atributos directamente??*/
	}
	
	def limpiar() {
		cuenta=""
		password=""
	}
}