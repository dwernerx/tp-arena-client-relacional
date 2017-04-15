package ar.edu.PoiUI

import ar.edu.AppModel.PoiAppModel
import ar.edu.POIs.Colectivo
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class InformacionColectivoWindow extends InformacionPoiWindow  {
	
	new(WindowOwner owner, PoiAppModel<Colectivo> model) {
		super(owner, model)
		title = "Línea de Colectivo"
		iconImage = "src/main/java/bus-icon.png"
	}
	
	override addFormPanel(Panel panel) {
		addInformacion(panel, "Cantidad de Paradas: ", poi.recorrido.size.toString)
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	def Colectivo getPoi(){
		modelObject.poi as Colectivo
	}	
}
