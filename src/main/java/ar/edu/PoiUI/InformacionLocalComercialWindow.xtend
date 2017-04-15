package ar.edu.PoiUI

import ar.edu.AppModel.PoiAppModel
import ar.edu.POIs.LocalComercial
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class InformacionLocalComercialWindow extends InformacionPoiWindow  {
	
	new(WindowOwner owner, PoiAppModel<LocalComercial> model) {
		super(owner, model)
		title = "Local Comercial"
		iconImage = "src/main/java/shopicon.png"
	}
	
	override addFormPanel(Panel panel) {
		addInformacion(panel, "Dirección: ", poi.direccion)
		addInformacion(panel, "Rubro: ", poi.rubro.nombre)
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	def LocalComercial getPoi(){
		modelObject.poi as LocalComercial
	}	
}
