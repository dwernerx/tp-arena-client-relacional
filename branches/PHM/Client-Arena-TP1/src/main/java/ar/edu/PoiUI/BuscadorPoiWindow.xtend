package ar.edu.PoiUI

import ar.edu.AppModel.BuscadorAppModel
import ar.edu.AppModel.PoiAppModel
import ar.edu.POIs.Banco
import ar.edu.POIs.Cgp
import ar.edu.POIs.Colectivo
import ar.edu.POIs.LocalComercial
import ar.edu.POIs.Poi
import java.awt.Color
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class BuscadorPoiWindow extends SimpleWindow<BuscadorAppModel> {

	new(WindowOwner parent, BuscadorAppModel model) {
		super(parent, model)
		title = "Busqueda de Puntos de Interes"
		iconImage = "src/main/java/mapsicon.png"
		modelObject.buscar
	}

	override def createMainTemplate(Panel mainPanel) {
		taskDescription = "Bienvenido usuario: " + modelObject.usuarioLogueado.cuenta
		super.createMainTemplate(mainPanel)
		this.createResultsGrid(mainPanel)
		this.createGridActions(mainPanel)
	}

	override def void createFormPanel(Panel mainPanel) {

		new Panel(mainPanel)=>[ //panel de titulos
			new Label(it) => [
			text = "Criterio de búsqueda" + "\n"
			fontSize = 12
			]
			new Label(it) => [
				text = "\n" + "Nombre" + "\t\t\t"
				width = 150
			]				
		]
		
		new Panel(mainPanel)=>[ //panel de busqueda
			layout = new HorizontalLayout
			new TextBox(it) => [
				value <=> "criterioBusqueda"
				width = 200
			]
		
			new Label(it).text = "         "

			new Button(it) => [
			caption = "Buscar"
			onClick[|this.modelObject.buscar]
			width = 100
			setAsDefault
			background = Color.orange
			]	
			
			new Label(it).text = "         "

			new Button(it) => [
			caption = "Todos"
			onClick[|this.modelObject.allPois]
			width = 100
			background = Color.blue
			]	
		]
		
		new Panel(mainPanel)=>[  //panel de grids
			new Label(it) => [
				text = "\n" + "Resultado"
				fontSize = 12
			]
		]
	}

	override protected addActions(Panel mainPanel) {}

	def protected createResultsGrid(Panel mainPanel) {
		this.describeResultsGrid(new Table<Poi>(mainPanel, Poi) => [
			numberVisibleRows = 7
			items <=> "listaDePois"
			value <=> "poiSeleccionado"
		])
	}

	def void describeResultsGrid(Table<Poi> table) {
		new Column<Poi>(table) => [
			title = "Nombre"
			fixedSize = 150
			bindContentsToProperty("nombre") 
		]

		new Column<Poi>(table) => [
			title = "Dirección"
			fixedSize = 150
			bindContentsToProperty("direccion") 
		]
		
		new Column<Poi>(table) =>[
			title = "Favorito"
			fixedSize = 100
			bindContentsToProperty("estaEnFavoritos").transformer = 
											[ Boolean favorito | if(favorito) "SI" else "NO"]
			bindForeground("estaEnFavoritos").transformer = 
											[ Boolean favorito | if(favorito) Color.BLUE else Color.RED]
		]

		new Column<Poi>(table) =>[	
			title = "Cerca"
			fixedSize = 100
			bindContentsToProperty("estaCerca").transformer = 
											[ Boolean cerca | if(cerca) "SI" else "NO"]
			bindForeground("estaCerca").transformer = 
											[ Boolean cerca | if(cerca) Color.BLUE else Color.RED]
		]
	}

	def createGridActions(Panel mainPanel) {
		new Panel(mainPanel)=>[
			layout = new HorizontalLayout
			new Button(it) => [
				setCaption("Información")
				background= Color.ORANGE
				onClick[|this.executePoiWindow(modelObject.poiSeleccionado)]
				bindEnabled(new NotNullObservable("poiSeleccionado"))
			]
		]
	}
	
	def executePoiWindow(Poi poi){
		openPoiWindow(poi)
	}

	def dispatch openPoiWindow(Banco banco) {
		new InformacionBancoWindow(this, new PoiAppModel(modelObject.usuarioLogueado,banco)).open
	}

	def dispatch openPoiWindow(Cgp cgp) {
		new InformacionCgpWindow(this, new PoiAppModel(modelObject.usuarioLogueado,cgp)).open
	}

	def dispatch openPoiWindow(Colectivo bondi) {
		new InformacionColectivoWindow(this, new PoiAppModel(modelObject.usuarioLogueado,bondi)).open
	}

	def dispatch openPoiWindow(LocalComercial comercial) {
		new InformacionLocalComercialWindow(this, new PoiAppModel(modelObject.usuarioLogueado,comercial)).open
	}
}
