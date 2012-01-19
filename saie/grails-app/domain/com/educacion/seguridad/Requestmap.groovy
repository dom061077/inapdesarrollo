package com.educacion.seguridad

class Requestmap {

	String url
	String configAttribute
	
	RequestmapGroup requestmapGroup
	
	static belongsTo = [requestmapGroup:RequestmapGroup]
	
	static mapping = {
		cache true
	}

	
	static constraints = {
		url blank: false, unique: true
		configAttribute blank: true
	}
}
