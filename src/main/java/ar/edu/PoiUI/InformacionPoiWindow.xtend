package ar.edu.PoiUI

import ar.edu.AppModel.PoiAppModel
import ar.edu.POIs.Poi
import ar.edu.visitas.Review
import java.awt.Color
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.CheckBox
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.RadioSelector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

abstract class InformacionPoiWindow extends SimpleWindow<PoiAppModel<? extends Poi>> {

	new(WindowOwner owner, PoiAppModel<? extends Poi> model) {
		super(owner, model)
		taskDescription = "Usuario: " + modelObject.usuarioLogueado.cuenta
		title = "Resultados"
	}

	override protected createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new HorizontalLayout
			new Label(it).text = "  "
			new Label(it) => [
				bindImageToProperty("poi", new ImgTransformer(this.modelObject.poi))
				height = 75
				width = 75
			]
			new Label(it).text = "         "

			new Panel(it) => [
				layout = new VerticalLayout
				new Label(it).text = "  "
				new Label(it) => [
					value <=> "poi.nombre"
					fontSize = 12
				]
			]
		]
		
		new Panel(mainPanel)=>[  //información
			layout = new ColumnLayout(2)
			addFormPanel(it)
			
			new Label(it).text = "Distancia(km):"
			new Label(it).value <=> "distancia"
			
			addInformacion(it, "   ", "   ")

			new Panel(it)=>[ //izquierdo
				layout = new HorizontalLayout
				new Label(it).text = "Calificación General:  "
				new Label(it).value <=> "calificacion"
			]
			
			new Panel(it)=>[ //derecho
				layout = new HorizontalLayout
				new Label(it).text = "Favorito:  "
				new CheckBox(it).value <=> "esFavorito"			
			]
		]
		
//		new Panel(mainPanel)=>[ //panel opinión 
			new Panel(/*it*/mainPanel)=>[
				layout = new ColumnLayout(2)
				
				new Label(it) => [
					fontSize = 12
					text = "Tu Opinión:"
				]
				new Label(it)
				new Label(it).text = "Comentario:"
					new TextBox(it) => [
					value <=> "comentario"
					width = 188
				]
				new Label(it).text = "Calificación:"
				new RadioSelector(it) => [
					items <=> "listaDeCalificaciones"
					value <=> "calificacionDelUsuario"
				]

				new Label(it)
				new Button(it) => [
					caption = "Enviar"
					onClick[|this.modelObject.generarReview]
					width = 85
					setAsDefault
					background = Color.orange
				]
			]
//		]
			
			new Panel(mainPanel) =>[ //panel tabla reviews
				new Panel(it)=>[	//panel titulo
					new Label(it) => [ 
						fontSize = 12
						text = "Opiniones:"
					]
				]
				createResultsGrid(it)
			]
	
	}

	def createResultsGrid(Panel mainPanel) {
		this.describeResultsGrid(new Table<Review>(mainPanel, Review) => [
			items <=> "listReviews"
			numberVisibleRows = 7//10
		])
	}

	def void describeResultsGrid(Table<Review> table) {
		new Column<Review>(table) => [
			title = "Usuario"
			fixedSize = 110
			bindContentsToProperty("nombreDeUsuario")
		]

		new Column<Review>(table) => [
			title = "Comentario"
			fixedSize = 200
			bindContentsToProperty("comentario")
		]

		new Column<Review>(table) => [
			title = "Calificación"
			fixedSize = 100
			bindContentsToProperty("puntuacion")
		]
	}

	def void addFormPanel(Panel panel)

	def void addInformacion(Panel panel, String nombre, String contenido) {
		new Label(panel).text = nombre
		new Label(panel).text = contenido
	}
}
