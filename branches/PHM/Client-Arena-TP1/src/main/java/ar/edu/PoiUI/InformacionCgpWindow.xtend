package ar.edu.PoiUI

import ar.edu.AppModel.PoiAppModel
import ar.edu.POIs.Cgp
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class InformacionCgpWindow extends InformacionPoiWindow  {
	
	new(WindowOwner owner, PoiAppModel<Cgp> model) {
		super(owner, model)
		title = "CGP"
		iconImage = "src/main/java/community-icon.png"
	}
	
	override addFormPanel(Panel panel) {
		addInformacion(panel, "Dirección: ", poi.direccion)
		addInformacion(panel, "   ", "   ")
		addInformacion(panel, "Servicios:  ", "Horarios: ")
		poi.servicios.forEach[servicio|addInformacion(panel,servicio.nombre,servicio.horario.toString)]
		addInformacion(panel, "   ", "   ")
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	def Cgp getPoi(){
		modelObject.poi as Cgp
	}
}
