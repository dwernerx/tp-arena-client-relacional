package ar.edu.AppModel

import ar.edu.POIs.Poi
import ar.edu.usuario.Usuario
import ar.edu.visitas.Review
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.utils.Dependencies
import org.uqbar.commons.utils.Observable

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
		usuarioLogueado = _usuarioLogueado
		poi = _poiSeleccionado
		buildLista()
		esFavorito = usuarioLogueado.getPoiEstaEnFavoritos(poi)
	}

	def generarReview() {
		poi.calificacion.asignarReview(usuarioLogueado, comentario, calificacionDelUsuario)
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
		if (esFavorito != usuarioLogueado.getPoiEstaEnFavoritos(poi)) {
			if (usuarioLogueado.getPoiEstaEnFavoritos(poi)) {
				usuarioLogueado.eliminarPoiFavorito(poi)
			} else {
				usuarioLogueado.agregarPoiFavorito(poi)
			}
		}
		esFavorito
	}

}
