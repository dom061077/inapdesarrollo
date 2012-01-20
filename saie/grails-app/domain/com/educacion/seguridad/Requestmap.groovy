package com.educacion.seguridad

class Requestmap {

	String url
	String configAttribute
	String descripcion
	
	RequestmapGroup requestmapGroup
	Role role
	
	static belongsTo = [requestmapGroup:RequestmapGroup,role:Role]
	static hasMany =[roles:Role]
	static mapping = {
		cache true
	}

	
	static constraints = {
		url blank: false, unique: true
		configAttribute blank: true , nullable:true
		descripcion blank: true, nullable:true
		requestmapGroup blank: true, nullable:true
		role blank:true,nullable:true
		
	}
}
