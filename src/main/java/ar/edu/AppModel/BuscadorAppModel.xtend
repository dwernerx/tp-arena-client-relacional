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
	String criterioBusqueda = "" // desde el cliente lo que se ingresa para matchear los pois.
	List<Poi> listaDePois // todos los pois
	Poi poiSeleccionado // poi seleccionado en la pantalla de busqueda.
	Usuario usuarioLogueado // usuario que viene de la pantalla de login.

	new(Usuario usuario) {
		usuarioLogueado = usuario
	}
	
	def void allPois() {
		criterioBusqueda = "" 
		factorizarLista(repositorioPois.allInstances)
	}
	
	def void buscar() {
		factorizarLista(tipoDeBusqueda())
		if (listaDePois.isEmpty) throw new UserException("No se han hallado resultados.")
	}
	
	def List<Poi> tipoDeBusqueda() {
		// busco todos los pois al inicializar la pantalla
		if(criterioBusqueda.nullOrEmpty){repositorioPois.allInstances}
		//traigo los pois y los matcheo para traer los que coinciden
		else{repositorioPois.filtrarBusqueda(criterioBusqueda)}
	}
	
	def List<Poi> factorizarLista(List<Poi> listaDePoisAux){
		actualizarUbicacion(listaDePoisAux)
		chequearFavorito(listaDePoisAux)
		listaDePois = listaDePoisAux
	}
	
	def chequearFavorito(List<Poi> listaAuxiliar ) {
		listaAuxiliar.forEach[poi | poi.setEstaEnFavoritos(usuarioLogueado.poiEstaEnFavoritos(poi))]
	}
	
	def actualizarUbicacion(List<Poi> listaAuxiliar) {
		listaAuxiliar.forEach[poi | poi.setPoiEstaCerca(usuarioLogueado.ubicacion)]
	}

	def RepositorioPoi repositorioPois() {
		ApplicationContext.instance.getSingleton(typeof(Poi)) // instancio un RepositorioPoi
	}
	
//	def actualizarUbicacion() {
//		listaDePois.forEach[poi | poi.setPoiEstaCerca(usuarioLogueado.ubicacion)] //A los pois seteo si estan cerca o no cumpliendo con sus criterios de cercania.
//	}
//		
//	def chequearFavorito(){
//		listaDePois.forEach[poi | poi.setEstaEnFavoritos(usuarioLogueado.poiEstaEnFavoritos(poi))]// Seteo a los pois, esto en el dominio porque con cada usuario cambiar, no se persiste. Lo que se persiste es la lista de favoritos. Esto solo sirve para mostrarlo en pantalla
//	}

}
