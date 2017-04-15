package ar.edu.AppModel

import ar.edu.POIs.Poi
import ar.edu.Repositorios.RepositorioPoi
import ar.edu.usuario.Usuario
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.UserException
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable

@Accessors
@Observable
class BuscadorAppModel {
	String criterioBusqueda=""
	List<Poi> listaDePois
	Poi poiSeleccionado
	Usuario usuarioLogueado
	
	new(Usuario usuario){
		usuarioLogueado = usuario
	}

	def void buscar() {
		listaDePois = getRepositorioPois().search(criterioBusqueda)
		if (listaDePois.isEmpty) throw new UserException("No se han hallado resultados.")
	}

	def RepositorioPoi getRepositorioPois() {
		ApplicationContext.instance.getSingleton(typeof(Poi))
	}
	
	def actualizarUbicacion() {
//		usuarioLogueado.getPosicionActual
		listaDePois.forEach[poi | poi.setPoiEstaCerca(usuarioLogueado.ubicacion)]
	}
		
	def chequearFavorito(){
		listaDePois.forEach[poi | poi.setEstaEnFavoritos(usuarioLogueado.getPoiEstaEnFavoritos(poi))]
	}

}
