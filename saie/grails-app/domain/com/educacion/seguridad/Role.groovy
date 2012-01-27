package com.educacion.seguridad

class Role {

	String authority

	static hasMany=[requests:Requestmap]
	
	static mapping = {
		cache true
		requests(cascade: 'save-update')
	}

	static constraints = {
		authority blank: false,nullable:false, unique: true
	}
}
