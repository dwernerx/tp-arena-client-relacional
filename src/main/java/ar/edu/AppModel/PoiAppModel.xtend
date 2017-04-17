package ar.edu.AppModel

import ar.edu.POIs.Poi
import ar.edu.usuario.Usuario
import ar.edu.visitas.Review
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable
import org.uqbar.commons.utils.ApplicationContext
import ar.edu.Repositorios.RepositorioPoi
import ar.edu.Repositorios.RepositorioUsuario

@Accessors
@Observable
class PoiAppModel<T extends Poi> {
	List<Integer> listaDeCalificaciones = #[1, 2, 3, 4, 5]
	List<Review> listReviews = newArrayList
	int calificacionDelUsuario = 1
	Usuario usuarioLogueado
	String comentario = ""
	T poi
	Boolean esFavorito

	new(Usuario _usuarioLogueado, T _poiSeleccionado) {
		usuarioLogueado = _usuarioLogueado// recibo el usuario
		poi = repositorioPois.searchById(_poiSeleccionado.id) as T//recibo el poi cosa que ahora voy a mandar a buscar bien rico.
		buildLista()//relleno la listaDeReviews
		esFavorito = usuarioLogueado.poiEstaEnFavoritos(poi)//El checkbox papá
	}
	
	def RepositorioPoi repositorioPois() {
		ApplicationContext.instance.getSingleton(typeof(Poi)) // instancio un RepositorioPoi
	}
	
	def RepositorioUsuario repositorioUsuario() {
		ApplicationContext.instance.getSingleton(typeof(Usuario)) // instancio un RepositorioPoi
	}

	def generarReview() {
		//guardar review y despues actualizar poi motherfucka
		poi.calificacion.asignarReview(usuarioLogueado, comentario, calificacionDelUsuario)
		repositorioPois.createOrUpdate(poi)
		buildLista()
	}

	@Dependencies("listReviews")
	def getCalificacion() {
		poi.calificacion.getPromedioCalificacion()
	}

	def buildLista() {
		listReviews.clear
		poi.calificacion.listaReview.forEach[o|listReviews.add(o)]
	}

	def getDistancia() {
		poi.getDistancia(usuarioLogueado.ubicacion)//(usuarioLogueado.getPosicionActual)
	}

	def getEsFavorito() {
		if (esFavorito != usuarioLogueado.poiEstaEnFavoritos(poi)) {
			if (usuarioLogueado.poiEstaEnFavoritos(poi)) {
				usuarioLogueado.eliminarPoiFavorito(poi)
			} else {
				usuarioLogueado.agregarPoiFavorito(poi)
			}
		repositorioUsuario.createOrUpdate(usuarioLogueado)
		}
		esFavorito
	}

}
