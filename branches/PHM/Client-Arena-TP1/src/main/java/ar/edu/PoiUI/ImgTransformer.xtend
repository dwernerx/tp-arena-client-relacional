package ar.edu.PoiUI

import org.apache.commons.collections15.Transformer
import org.uqbar.arena.graphics.Image
import ar.edu.POIs.Poi
import ar.edu.POIs.Colectivo
import ar.edu.POIs.LocalComercial
import ar.edu.POIs.Banco
import ar.edu.POIs.Cgp

class ImgTransformer implements Transformer<Poi, Image> {
	
	new(Poi poi){
		this.transform(poi)
	}
	override transform(Poi poi) {
		if (poi.class == typeof(Colectivo)) return new Image("bus-icon.png")
		if (poi.class == typeof(LocalComercial)) return new Image("shopicon.png")
		if (poi.class == typeof(Banco)) return new Image("bank-icon.png")
		if (poi.class == typeof(Cgp)) return new Image("community-icon.png")
		else return new Image("nopic.jpg")
	}
}