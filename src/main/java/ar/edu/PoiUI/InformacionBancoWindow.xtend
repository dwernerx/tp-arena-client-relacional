package ar.edu.PoiUI

import ar.edu.AppModel.PoiAppModel
import ar.edu.POIs.Banco
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.WindowOwner

class InformacionBancoWindow extends InformacionPoiWindow {

	new(WindowOwner owner, PoiAppModel<Banco> model) {
		super(owner, model)
		title = "Sucursal de un Banco"
		iconImage = "src/main/java/bank-icon.png"
	}

	override addFormPanel(Panel panel) {
		addInformacion(panel, "Dirección: ", poi.direccion)
		addInformacion(panel, "Barrio: ", poi._direccion.barrio)
		addInformacion(panel, "Servicios: ", poi.serviciosToString) 
		//TODO  arreglar metodo serviciosToString() porque ahora tiene lista de Servicio
		
	}
	
	override protected addActions(Panel actionsPanel) {
	}
	
	def Banco getPoi(){
		modelObject.poi as Banco
	}	

}
