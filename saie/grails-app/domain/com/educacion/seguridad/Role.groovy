package com.educacion.seguridad

class Role {

	String authority

	static hasMany=[requests:Requestmap]
	
	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
