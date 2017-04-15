package ar.edu.PoiRunnable

import ar.edu.POIs.Banco
import ar.edu.POIs.Cgp
import ar.edu.POIs.Colectivo
import ar.edu.POIs.Comuna
import ar.edu.POIs.Direccion
import ar.edu.POIs.HorarioDeAtencion
import ar.edu.POIs.LocalComercial
import ar.edu.POIs.Poi
import ar.edu.POIs.Rubro
import ar.edu.POIs.Servicio
import ar.edu.POIs.ServicioCGP
import ar.edu.Repositorios.RepositorioCalificacion
import ar.edu.Repositorios.RepositorioPoi
import ar.edu.Repositorios.RepositorioReview
import ar.edu.Repositorios.RepositorioRubro
import ar.edu.Repositorios.RepositorioServicio
import ar.edu.Repositorios.RepositorioUsuario
import ar.edu.builder.BancoBuilder
import ar.edu.builder.ColectivoBuilder
import ar.edu.builder.DireccionBuilder
import ar.edu.builder.HorarioDeAtencionBuilder
import ar.edu.builder.LocalComercialBuilder
import ar.edu.usuario.Usuario
import ar.edu.visitas.Calificacion
import ar.edu.visitas.Review
import java.util.Arrays
import org.joda.time.LocalTime
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.geodds.Poligono
import org.uqbar.geodds.Punto

class PoiBootstrap extends CollectionBasedBootstrap {
	static PoiBootstrap instance

	static def getInstance() {
		if (instance == null) {
			instance = new PoiBootstrap
		}
		instance
	}
	Poligono poligono1
	Poligono poligono2
	Poligono poligono3
	Poligono poligono4
	Poligono poligono5
	
	Calificacion calificacion1
	Calificacion calificacion2
	Calificacion calificacion3
	Calificacion calificacion4
	Calificacion calificacion5
	Calificacion calificacion6
	Calificacion calificacion7
	Calificacion calificacion8
	Calificacion calificacion9
	Calificacion calificacion10
	Calificacion calificacion11
	Calificacion calificacion12
	
	Servicio deposito
	Servicio transferencia
	Servicio cobro_cheques
	Servicio extracciones
	Servicio prestamo
	Servicio inversion
	
	Review opinion1
	Review opinion2
	Review opinion3
	Review opinion4
	Review opinion5
	Review opinion6
	Review opinion7
	Review opinion8
	Review opinion9
	Review opinion10
	Review opinion11
	Review opinion12
	Review opinion13
	Review opinion14
	Review opinion15
	Review opinion16
	Review opinion17
	Review opinion18
	Review opinion19
	Review opinion20
	
	Rubro rubroVerduleria
	Rubro rubroVivero
	Rubro rubroLibreria
	
	Usuario armando
	Usuario guillermo
	Usuario admin
	Usuario juanchi
	Usuario susy
	Usuario jaimito
	Usuario bergoglio
	Usuario lueta
	Usuario martin
	Usuario edu

	Cgp sedeComuna1
	Cgp sedeComuna2
	Cgp sedeComuna3
	Cgp sedeComuna4
	Cgp sedeComuna5

	Colectivo colectivo78
	Colectivo colectivo169
	Colectivo colectivo343
	Colectivo colectivo57
	Colectivo colectivo328

	Banco bancoSantander
	Banco bancoNacion
	Banco bancoCiudad
	Banco bancoPiano
	Banco bancoRioDelPlata

	LocalComercial verduleriaManolo
	LocalComercial verduleriaAmanda
	LocalComercial libreriaGarabombo
	LocalComercial viveroPalmeras
	LocalComercial viveroLotoAzul

	private new() {
		ApplicationContext.instance.configureSingleton(typeof(Usuario), RepositorioUsuario.instance)
		ApplicationContext.instance.configureSingleton(typeof(Rubro), RepositorioRubro.instance)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), RepositorioServicio.instance)
		ApplicationContext.instance.configureSingleton(typeof(Review), RepositorioReview.instance)
		ApplicationContext.instance.configureSingleton(typeof(Calificacion), RepositorioCalificacion.instance)
		ApplicationContext.instance.configureSingleton(typeof(Poi), RepositorioPoi.instance)
	}

	override run() {

		crearUsuarios()
		crearReviews()
		crearCalificaciones() 	//cuando se crean los pois previamente tengo que tener la lista con las calificaciones
		crearColectivos()
		crearBancos()
		crearLocalesComerciales()
		crearCGPs()		
		agregarPoisFavoritosAUsuarios() 
		// necesitas tener los pois creados para hacer el ManyToMany de la lista de pois que tenes en usuario y se hacen cuando lo creas.
	}

		
	def void crearUsuario(Usuario usuario){
			val repoUsuario = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuario
			val listaUsuario = repoUsuario.searchByExample(usuario)
				if (listaUsuario.isEmpty) {
				repoUsuario.createOrUpdate(usuario)
				println("Usuario " + usuario.cuenta + " creado")
			} else {
				val usuarioBD = listaUsuario.head
				usuario.id = usuarioBD.id
				repoUsuario.createOrUpdate(usuario)
			}
		}

	def void crearRubros(Rubro rubro){
			val repoRubro = ApplicationContext.instance.getSingleton(typeof(Rubro)) as RepositorioRubro
			val listaRubro = repoRubro.searchByExample(rubro)
				if (listaRubro.isEmpty) {
				repoRubro.createOrUpdate(rubro)
				println("Rubro " + rubro.nombre + " creado")
			} else {
				val rubroBD = listaRubro.head
				rubro.id = rubroBD.id
				repoRubro.createOrUpdate(rubro)
			}
		}
		
	def void crearServicio(Servicio servicio){
			val repoServicio = ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepositorioServicio
			val listaServicio = repoServicio.searchByExample(servicio)
				if (listaServicio.isEmpty) {
				repoServicio.createOrUpdate(servicio)
				println("Servicio " + servicio.nombre + " creado")
			} else {
				val servicioBD = listaServicio.head
				servicio.id = servicioBD.id
				repoServicio.createOrUpdate(servicio)
			}
		}
		
	def void crearPoi(Poi poi) {
			val repoPoi = ApplicationContext.instance.getSingleton(typeof(Poi)) as RepositorioPoi
			val listaPoi = repoPoi.searchByExample(poi)
			if (listaPoi.isEmpty) {
				repoPoi.createOrUpdate(poi)
				println("Poi " + poi.nombre +  " creado")
			} else {
				val poiBD = listaPoi.head
				poi.id = poiBD.id
				repoPoi.createOrUpdate(poi)
			}
	}
	
	def void agregarPoiFavorito(Usuario usuario, Poi poi) {
			val repoFavorito = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepositorioUsuario
			val listaFavorito = repoFavorito.searchByExample(usuario)
				val favoritoBD = listaFavorito.head
				usuario.id = favoritoBD.id
				usuario.agregarPoiFavorito(poi)
				repoFavorito.createOrUpdate(usuario)
	}
	
	def void crearReview(Review review) {
			val repoReview = ApplicationContext.instance.getSingleton(typeof(Review)) as RepositorioReview
				repoReview.createOrUpdate(review)

	}
	
	def void crearCalificacion(Calificacion calificacion) {
			val repoCalificacion = ApplicationContext.instance.getSingleton(typeof(Calificacion)) as RepositorioCalificacion
			val listaCalificacion = repoCalificacion.searchByExample(calificacion)
			if (listaCalificacion.isEmpty) {
				repoCalificacion.createOrUpdate(calificacion)
				println("Calificacion " + /*calificacion.nombre +*/  " creada")
			} else {
				val calificacionBD = listaCalificacion.head
				calificacion.id = calificacionBD.id
				repoCalificacion.createOrUpdate(calificacion)
			}
	}
	
	def void crearUsuarios() {
		
		/**Los primeros 5 usuarios calificaron */
		armando = new Usuario("ArmandoEsteban", "Quito", new Punto(-34.578500, -58.528810))
		guillermo = new Usuario("Guillermo", "Nigote", new Punto(-34.578510, -58.528880))
		admin = new Usuario("admin", "admin", new Punto(-34.579100, -58.528108))
		juanchi = new Usuario("Juanchi", "Cato", new Punto(-34.580310, -58.525458))
		susy = new Usuario("Susy", "Lueta", new Punto(-34.581767, -58.522186))
		/**Estos usuarios Nunca calificaron */
		jaimito = new Usuario("Jaime", "Talero", new Punto(-34.582968, -58.519643))
		bergoglio = new Usuario("bergoglio", "666", new Punto(-34.580310, -58.525458))
		lueta = new Usuario("Lueta", "Rado", new Punto(-34.578510, -58.528880))
		martin = new Usuario("Martin", "Gala", new Punto(-34.579100, -58.528108))
		edu = new Usuario("Edu", "Cado", new Punto(-34.581767, -58.522186))

		crearUsuario(armando)
		crearUsuario(guillermo)
		crearUsuario(admin)
		crearUsuario(juanchi)
		crearUsuario(susy)
		crearUsuario(jaimito)
		crearUsuario(bergoglio)
		crearUsuario(lueta)
		crearUsuario(martin)
		crearUsuario(edu)
	}
			
	def void crearColectivos() {


		colectivo78 = new ColectivoBuilder()
			.agregarNombre("78")
			.agregarParada(-34.570444, -58.538289)
			.agregarParada(-34.578555, -58.528354)
			.agregarParada(-34.568666, -58.542023)
			.agregarCalificacion(calificacion1)
			.build
		colectivo169 = new ColectivoBuilder()
			.agregarNombre("169")
			.agregarParada(-34.577999, -58.528354)
			.agregarParada(-34.568755, -58.542023)
			.agregarCalificacion(calificacion2)
			.build
		colectivo343 = new ColectivoBuilder()
			.agregarNombre("343")
			.agregarParada(-34.579999, -58.520000)
			.agregarParada(-34.687777, -58.418651)
			.agregarParada(-34.568888, -58.542023)
			.agregarCalificacion(calificacion3)
			.build
		colectivo57 = new ColectivoBuilder()
			.agregarNombre("57")
			.agregarParada(-34.57999, -58.528354)
			.agregarParada(-34.568666, -58.542023)
			.build
		colectivo328 = new ColectivoBuilder()
			.agregarNombre("328")
			.agregarParada(-34.579100, -58.528545)
			.agregarParada(-34.568555, -58.542777)
			.build

			crearPoi(colectivo78)
			crearPoi(colectivo169)
			crearPoi(colectivo343)
			crearPoi(colectivo57)
			crearPoi(colectivo328)
	}

	def void crearBancos() {
		deposito = new Servicio("Depósitos")
		transferencia= new Servicio("Transferencias")
		cobro_cheques = new Servicio("Cobro de cheques")
		extracciones = new Servicio("Extracciones")
		prestamo = new Servicio("Prestamo")
		inversion = new Servicio("Inversión")
		
		crearServicio(deposito)
		crearServicio(transferencia)
		crearServicio(cobro_cheques)
		crearServicio(extracciones)
		crearServicio(prestamo)
		crearServicio(inversion)

		bancoSantander = new BancoBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.565000, -58.542023).agregarCalle("Rondeau").
				agregarEntreCalle1("Av Primavera").agregarEntreCalle2("6 de Julio").agregarNumero(250).
				agregarCodigoPostal(1650).agregarLocalidad("San Martin").agregarBarrio("San Martin").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorarioBanco(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(10, 0, 0)).agregarHoraFin(new LocalTime(15, 0, 0)).build)
			.agregarNombre("Santander")
			.agregarServicios(#[deposito, transferencia, cobro_cheques])
			.agregarCalificacion(calificacion4)
			.build
		bancoNacion = new BancoBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.575000, -58.528354).agregarCalle("Av Darko").
				agregarEntreCalle1("Los Conejos").agregarEntreCalle2("Las Alicias").agregarNumero(820).
				agregarCodigoPostal(1650).agregarLocalidad("San Martin").agregarBarrio("San Martin").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorarioBanco(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(10, 0, 0)).agregarHoraFin(new LocalTime(15, 0, 0)).build)
			.agregarNombre("Nacion")
			.agregarServicios(#[deposito, transferencia, cobro_cheques, extracciones])
			.agregarCalificacion(calificacion5)
			.build
		bancoCiudad = new BancoBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.580000, -58.542023).agregarCalle("Av Los Talares").
				agregarEntreCalle1("Ebano").agregarEntreCalle2("Pino").agregarNumero(1320).agregarCodigoPostal(1650).
				agregarLocalidad("San Martin").agregarBarrio("San Martin").agregarProvincia("Buenos Aires").agregarPais("Argentina")
				.build)
			.agregarHorarioBanco(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(10, 0, 0)).agregarHoraFin(new LocalTime(15, 0, 0)).build)
			.agregarNombre("Ciudad")
			.agregarServicios(#[deposito, extracciones])
			.agregarCalificacion(calificacion6)
			.build
		bancoPiano = new BancoBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.56000, -58.528354).agregarCalle("Av Cipres").
				agregarEntreCalle1("Los Conejos").agregarEntreCalle2("Algarrobo").agregarNumero(2560).
				agregarCodigoPostal(1650).agregarLocalidad("San Martin").agregarBarrio("San Martin").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorarioBanco(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(10, 0, 0)).agregarHoraFin(new LocalTime(15, 0, 0)).build)
			.agregarNombre("Piano")
			.agregarServicios(#[transferencia, cobro_cheques])
			.build
		bancoRioDelPlata = new BancoBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.57000, -58.529354).agregarCalle("Av Naranjo").
				agregarEntreCalle1("Los Tomates").agregarEntreCalle2("Las Alicias").agregarNumero(2320).
				agregarCodigoPostal(1650).agregarLocalidad("San Martin").agregarBarrio("San Martin").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorarioBanco(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(10, 0, 0)).agregarHoraFin(new LocalTime(15, 0, 0)).build)
			.agregarNombre("Rio Del Plata")
			.agregarServicios(#[prestamo, inversion])
			.build

			crearPoi(bancoSantander)
			crearPoi(bancoRioDelPlata)
			crearPoi(bancoPiano)
			crearPoi(bancoCiudad)
			crearPoi(bancoNacion)
	}

	def void crearLocalesComerciales() {
		
		rubroVerduleria = new Rubro("Verduleria", 0.4)
		rubroVivero = new Rubro("Vivero", 0.9)
		rubroLibreria =  new Rubro("Libreria", 0.2)
		crearRubros(rubroVerduleria)
		crearRubros(rubroVivero)
		crearRubros(rubroLibreria)

		verduleriaManolo = new LocalComercialBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.579999, -58.521234).agregarCalle("Quirno").
				agregarEntreCalle1("Bolivia").agregarEntreCalle2("San Pedrito").agregarNumero(343).
				agregarCodigoPostal(1650).agregarLocalidad("Flores").agregarBarrio("C.A.B.A").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorario(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(8, 0, 0)).agregarHoraFin(new LocalTime(17, 0, 0)).build)
			.agregarNombre("Don Manolo")
			.agregarRubro(rubroVerduleria)
			.agregarPalabrasClave(Arrays.asList("Maracuya", "Mango", "Melon", "Cereza"))
			.agregarCalificacion(calificacion7)
			.build
		verduleriaAmanda = new LocalComercialBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.578555, -58.530000).agregarCalle("Avellaneda").
				agregarEntreCalle1("Tannat").agregarEntreCalle2("San Pedrito").agregarNumero(100).
				agregarCodigoPostal(1650).agregarLocalidad("Flores").agregarBarrio("C.A.B.A").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorario(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(8, 0, 0)).agregarHoraFin(new LocalTime(17, 0, 0)).build)
			.agregarNombre("Las Amandas")
			.agregarRubro(rubroVerduleria)
			.agregarPalabrasClave(Arrays.asList("Mango", "Anco Zapallo", "Alcaucil", "Arandano"))
			.agregarCalificacion(calificacion9)
			.build
		libreriaGarabombo = new LocalComercialBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.578555, -58.525000).agregarCalle("Amerello").
				agregarEntreCalle1("Celeste").agregarEntreCalle2("San Pedrito").agregarNumero(900).
				agregarCodigoPostal(1650).agregarLocalidad("Flores").agregarBarrio("C.A.B.A").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorario(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(8, 0, 0)).agregarHoraFin(new LocalTime(19, 30, 0)).build)
			.agregarNombre("Garabombo")
			.agregarRubro(rubroLibreria)
			.agregarPalabrasClave(Arrays.asList("Libros", "Textos", "Textos Escolares", "Libros Antiguos"))
			.build
		viveroPalmeras = new LocalComercialBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.578555, -58.535000).agregarCalle("Marcos Sastre").
				agregarEntreCalle1("Helguera").agregarEntreCalle2("Argerich").agregarNumero(3100).
				agregarCodigoPostal(1417).agregarLocalidad("Villa Del Parque").agregarBarrio("Villa Del Parque").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorario(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(8, 0, 0)).agregarHoraFin(new LocalTime(17, 0, 0)).build)
			.agregarNombre("Las Palmeras")
			.agregarRubro(rubroVivero)
			.agregarPalabrasClave(Arrays.asList("Palmera", "Platano", "Pino", "Duraznero"))
			.build
		viveroLotoAzul = new LocalComercialBuilder()
			.agregarDireccion(new DireccionBuilder().agregarPunto(-34.578793, -58.515000).agregarCalle("Cielo Razo").
				agregarEntreCalle1("Terrada").agregarEntreCalle2("San Pedrito").agregarNumero(300).
				agregarCodigoPostal(1650).agregarLocalidad("Flores").agregarBarrio("C.A.B.A").
				agregarProvincia("Buenos Aires").agregarPais("Argentina").build)
			.agregarHorario(new HorarioDeAtencionBuilder().agregarHoraInicio(new LocalTime(8, 0, 0)).agregarHoraFin(new LocalTime(17, 0, 0)).build)
			.agregarNombre("LotoAzul")
			.agregarRubro(rubroVivero)
			.agregarPalabrasClave(Arrays.asList("Solanacea", "Hipomea Violacia", "Bromelia", "Orquidea"))
			.build

			crearPoi(verduleriaManolo)
			crearPoi(verduleriaAmanda)
			crearPoi(viveroLotoAzul)
			crearPoi(viveroPalmeras)
			crearPoi(libreriaGarabombo)
	}

	def void crearCGPs() {

			poligono1 = new Poligono() =>[
				add(new Punto(-34.577777, -58.528354))
				add(new Punto(-34.578555, -58.528974))
				add(new Punto(-34.578555, -58.528974))
				add(new Punto(-34.599284, -58.386868))
				add(new Punto(-34.579900, -58.528354))
			]
			poligono2 = new Poligono() =>[
				add(new Punto(-55.569901, -88.322222))
				add(new Punto(-99.576603, -18.377776))
				add(new Punto(-34.576999, -58.528354))
				add(new Punto(-38.597805, -58.475952))
			]
			poligono3 = new Poligono() =>[
				add(new Punto(-34.577555, -58.528354))
				add(new Punto(-34.578555, -58.528888))
				add(new Punto(-34.599284, -108.386868))
				add(new Punto(-33.597805, -76.46952))
			]
			poligono4 = new Poligono() =>[
				add(new Punto(-38.569901, -48.399922))
				add(new Punto(-79.579503, -158.376716))
				add(new Punto(-34.578555, -58.528354))
				add(new Punto(-34.578666, -58.528354))
			]
			poligono5 = new Poligono() =>[
				add(new Punto(-34.578999, -58.528354))
				add(new Punto(-34.578000, -58.528354))
				add(new Punto(-104.599284, -199.386868))
				add(new Punto(-101.597805, -106.417852))
			]

		val comuna1 = new Comuna(poligono1, "CGP Comuna 1")
		val comuna2 = new Comuna(poligono2, "CGP Comuna 2")
		val comuna3 = new Comuna(poligono3, "CGP Comuna 3")
		val comuna4 = new Comuna(poligono4, "CGP Comuna 4")
		val comuna5 = new Comuna(poligono5, "CGP Comuna 5")
		
		val direccionComuna1 = new Direccion(new Punto(-107.567801, -128.397822), "La Paz", "Bolivia", "Paraguay", 281,
			1986, "Altamirano", "Buenos Aires", "Buenos Aires", "Argentina")
		val direccionComuna2 = new Direccion(new Punto(-34.577900, -58.528354), "Lavalle", "Lacroze",
			"Boulevard Ballester", 222, 1653, "Villa Ballester", "San Martin", "Buenos Aires", "Argentina")
		val direccionComuna3 = new Direccion(new Punto(-34.579555, -58.528354), "Av. 5 de Mayo", "Libertador",
			"America", 2203, 1986, "Altamirano", "Buenos Aires", "Buenos Aires", "Argentina")
		val direccionComuna4 = new Direccion(new Punto(-128.567901, -105.399222), "Av. Independencia", "Francia",
			"Estado de Israel", 654, 1458, "Bella Vista", "Buenos Aires", "Buenos Aires", "Argentina")
		val direccionComuna5 = new Direccion(new Punto(-54.569121, -26.393232), "Av. Ricardo Balbin", "Los Ceibos",
			"Alamedas", 635, 1623, "Caballito", "Capital Federal", "Buenos Aires", "Argentina")

		val horarioServicioRentas = new HorarioDeAtencion(new LocalTime(7, 30, 0), new LocalTime(15, 30, 0))
		val horarioServicioSocial = new HorarioDeAtencion(new LocalTime(8, 0, 0), new LocalTime(19, 0, 0))
		val horarioServicioDireccionGeneralDeLaMujer = new HorarioDeAtencion(new LocalTime(9, 0, 0), new LocalTime(21, 0, 0))
		val horarioServicioRegistroCivil = new HorarioDeAtencion(new LocalTime(8, 30, 0), new LocalTime(20, 30, 0))
		val horarioServicioTesoreria = new HorarioDeAtencion(new LocalTime(7, 0, 0), new LocalTime(13, 0, 0))

		//Servicios CGP
		val rentas = new ServicioCGP("Rentas", horarioServicioRentas)
		val servicioSocial = new ServicioCGP("Servicio Social", horarioServicioSocial)
		val direccionGeneralDeLaMujer = new ServicioCGP("Dirección Gral. de la Mujer",
			horarioServicioDireccionGeneralDeLaMujer)
		val registroCivil = new ServicioCGP("Registro Civil", horarioServicioRegistroCivil)
		val tesoreria = new ServicioCGP("Tesorería", horarioServicioTesoreria)
		crearServicio(rentas)
		crearServicio(servicioSocial)
		crearServicio(direccionGeneralDeLaMujer)
		crearServicio(registroCivil)
		crearServicio(tesoreria)

		sedeComuna1 = new Cgp(comuna1, direccionComuna1)
		sedeComuna1.servicios.addAll(Arrays.asList(direccionGeneralDeLaMujer, registroCivil))
		sedeComuna2 = new Cgp(comuna2, direccionComuna2)
		sedeComuna2.servicios.addAll(Arrays.asList(direccionGeneralDeLaMujer, registroCivil))
		sedeComuna3 = new Cgp(comuna3, direccionComuna3)
		sedeComuna3.servicios.addAll(Arrays.asList(tesoreria, rentas))
		sedeComuna4 = new Cgp(comuna4, direccionComuna4)
		sedeComuna4.servicios.add(servicioSocial)
		sedeComuna5 = new Cgp(comuna5, direccionComuna5)
		sedeComuna5.servicios.add(tesoreria)
		
		sedeComuna2.calificacion = calificacion10
		sedeComuna4.calificacion = calificacion11
		sedeComuna5.calificacion = calificacion12

		crearPoi(sedeComuna1)
		crearPoi(sedeComuna2)
		crearPoi(sedeComuna3)
		crearPoi(sedeComuna4)
		crearPoi(sedeComuna5)
		
	}

	def void agregarPoisFavoritosAUsuarios() {

	agregarPoiFavorito(admin,bancoSantander)
	agregarPoiFavorito(jaimito,colectivo78)
	agregarPoiFavorito(jaimito,bancoSantander)
//		jaimito => [
//			agregarPoiFavorito(colectivo78)
//			agregarPoiFavorito(bancoSantander)
//			agregarPoiFavorito(colectivo343)
//			agregarPoiFavorito(bancoCiudad)
//			agregarPoiFavorito(libreriaGarabombo)
//		]
//		bergoglio => [
//			agregarPoiFavorito(bancoNacion)
//			agregarPoiFavorito(verduleriaManolo)
//			agregarPoiFavorito(viveroLotoAzul)
//			agregarPoiFavorito(sedeComuna2)
//			agregarPoiFavorito(sedeComuna5)
//		]
//		lueta => [
//			agregarPoiFavorito(colectivo78)
//			agregarPoiFavorito(sedeComuna2)
//			agregarPoiFavorito(colectivo343)
//			agregarPoiFavorito(bancoSantander)
//			agregarPoiFavorito(sedeComuna2)
//		]
//		martin => [
//			agregarPoiFavorito(bancoNacion)
//			agregarPoiFavorito(bancoRioDelPlata)
//			agregarPoiFavorito(sedeComuna2)
//			agregarPoiFavorito(sedeComuna4)
//			agregarPoiFavorito(colectivo343)
//		]
//		edu => [
//			agregarPoiFavorito(bancoSantander)
//			agregarPoiFavorito(colectivo78)
//			agregarPoiFavorito(viveroLotoAzul)
//			agregarPoiFavorito(colectivo343)
//			agregarPoiFavorito(sedeComuna5)
//		]
//		admin => [
//			agregarPoiFavorito(bancoSantander)
//			//agregarPoiFavorito(colectivo78)
//			//agregarPoiFavorito(colectivo57)
//			//agregarPoiFavorito(sedeComuna3)
//			//agregarPoiFavorito(sedeComuna1)
//		]
	}

	def void crearReviews(){
		
		opinion1 = new Review(armando, "Que buen Poi pero le pongo 1", 1)
		opinion2 = new Review(guillermo, "No me gusto el lugar", 2)
		opinion3 = new Review(admin, "Vamos con un 3", 3)
		opinion4 = new Review(juanchi, "Tengo sueño", 4)
		opinion5 = new Review(susy, "POI recomendado", 5)
		opinion6 = new Review(susy, "POI No recomendado", 2)
		opinion7 = new Review(guillermo, "Entra review,sale calificación", 3)
		opinion8 = new Review(juanchi, "Haciendo casos de prueba", 5)
		opinion9 = new Review(susy, "Me gusta el arrrrte", 5)
		opinion10 = new Review(admin, "Modelando un toque", 2)
		opinion11 = new Review(guillermo, "No me gusto el lugar", 2)
		opinion12 = new Review(armando, "Soy un usuario calificador toma", 4)
		opinion13 = new Review(susy, "POI recomendado", 5)
		opinion14 = new Review(armando, "Que buen Poi pero le pongo 1", 1)
		opinion15 = new Review(admin, "Estoy re duro de mappear", 1)
		opinion16 = new Review(guillermo, "No me gusto el lugar", 2)
		opinion17 = new Review(armando, "No me gusto el poi", 2)
		opinion18 = new Review(susy, "GRACIAS HIJA,BESOS!", 1)
		opinion19 = new Review(admin, "Que buen Poi pero le pongo 1", 1)
		opinion20 = new Review(juanchi, "Tengo sueño", 4)
		
		crearReview(opinion1)
		crearReview(opinion2)
		crearReview(opinion3)
		crearReview(opinion4)
		crearReview(opinion5)	
		crearReview(opinion6)
		crearReview(opinion7)
		crearReview(opinion8)
		crearReview(opinion9)
		crearReview(opinion10)
		crearReview(opinion11)
		crearReview(opinion12)
		crearReview(opinion13)
		crearReview(opinion14)
		crearReview(opinion15)
		crearReview(opinion16)
		crearReview(opinion17)
		crearReview(opinion18)
		crearReview(opinion19)
		crearReview(opinion20)
		
	}
	
	def void crearCalificaciones() {

		calificacion1 = new Calificacion()=>[
			agregarReview(opinion1)
			agregarReview(opinion2)
		]
		calificacion2 = new Calificacion()=>[
			agregarReview(opinion3)
			agregarReview(opinion4)
			agregarReview(opinion5)
		]
		calificacion3 = new Calificacion() =>[
			agregarReview(opinion6)
			agregarReview(opinion7)
		]
		calificacion4 = new Calificacion()=>[
			agregarReview(opinion8)
			agregarReview(opinion9)
		]
		calificacion5 = new Calificacion()=>[
			agregarReview(opinion10)
		]
		calificacion6 = new Calificacion()=>[
			agregarReview(opinion11)
			agregarReview(opinion12)
		]
		calificacion7 = new Calificacion()=>[
			agregarReview(opinion13)
		]
		calificacion8 = new Calificacion()=>[
			agregarReview(opinion14)
		]
		calificacion9 = new Calificacion()=>[
			agregarReview(opinion15)
			agregarReview(opinion16)
		]
		calificacion10 = new Calificacion()=>[
			agregarReview(opinion17)
		]
		calificacion11 = new Calificacion()=>[
			agregarReview(opinion18)
			agregarReview(opinion19)
		]
		calificacion12 = new Calificacion()=>[
			agregarReview(opinion20)
		]

	crearCalificacion(calificacion1)	
	crearCalificacion(calificacion2)
//	colectivo169.calificacion = calificacion2
//		colectivo343.calificacion = calificacion3
//		bancoSantander.calificacion = calificacion4
//		bancoCiudad.calificacion = calificacion5
//		bancoNacion.calificacion = calificacion6
//		viveroLotoAzul.calificacion = calificacion7
//		verduleriaManolo.calificacion = calificacion8
//		libreriaGarabombo.calificacion = calificacion9
//		sedeComuna2.calificacion = calificacion10
//		sedeComuna4.calificacion = calificacion11
//		sedeComuna5.calificacion = calificacion12
	
	}

}
