package ar.edu.PoiRunnable

import ar.edu.AppModel.LoginAppModel
import ar.edu.PoiUI.LoginWindow
import org.uqbar.arena.Application
import org.uqbar.arena.windows.Window

class PoiApplication extends Application{
	
		new(PoiBootstrap bootstrap) {
		super(bootstrap)
	}
	
	static def void main(String[] args) { 
		new PoiApplication(PoiBootstrap.instance).start()
	}

	override protected Window<?> createMainWindow() {
		return new LoginWindow(this, new LoginAppModel)
	}
	
	
}