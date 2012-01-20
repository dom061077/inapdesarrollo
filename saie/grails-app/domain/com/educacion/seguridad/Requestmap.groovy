package com.educacion.seguridad

class Requestmap {

	String url
	String configAttribute
	String descripcion
	
	RequestmapGroup requestmapGroup
	
	static belongsTo = [requestmapGroup:RequestmapGroup]
	
	static mapping = {
		cache true
	}

	
	static constraints = {
		url blank: false, unique: true
		configAttribute blank: true , nullable:true
		descripcion blank: false
	}
}
