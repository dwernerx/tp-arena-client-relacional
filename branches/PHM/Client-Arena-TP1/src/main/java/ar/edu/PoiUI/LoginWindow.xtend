package ar.edu.PoiUI

import ar.edu.AppModel.BuscadorAppModel
import ar.edu.AppModel.LoginAppModel
import java.awt.Color
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.PasswordField
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.layout.ColumnLayout

class LoginWindow extends SimpleWindow<LoginAppModel> {
	
	new(WindowOwner parent, LoginAppModel model) {
		super(parent, model)
		title = "Login - Points of Interest "
		taskDescription = "Ingrese usuario y contraseña"
		iconImage = "src/main/java/login.png"
	}

	override protected createFormPanel(Panel mainPanel) {
		
		new Panel(mainPanel) => [
		layout = new ColumnLayout(2)
		
			new Label(it)=>[
				text = "Usuario"
				fontSize = 11
				width = 150
			]
	
			new TextBox(it)=>[
				value <=> "cuenta"
				height = 18
				fontSize = 10
				width = 150
			]
	
			new Label(it)=>[
				text = "Contraseña"
				fontSize = 11
				width = 150
			]
	
			new PasswordField(it)=>[
				value <=> "password"
				height= 18
				fontSize = 10
				width = 150
			]
		]

	}
	
	override protected addActions(Panel actionsPanel) {

			new Button(actionsPanel) => [
				caption = "OK"
				onClick[|
	//				close
					this.ingresar
				]
				width = 165
				setAsDefault
				background = Color.orange
			]
			new Button(actionsPanel) => [
				caption = "Cancelar"
				onClick[|close]
				width = 165
				background = Color.orange
			]

	}
	
	def ingresar() {
		this.modelObject.iniciarSesion()
		this.modelObject.limpiar()
		new BuscadorPoiWindow(this, new BuscadorAppModel(modelObject.usuarioLogueado)).open
	}
	


}