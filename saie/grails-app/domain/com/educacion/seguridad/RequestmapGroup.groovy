package com.educacion.seguridad

class RequestmapGroup {
	String descripcion
	
	static hasMany= [requests:Requestmap]
    static constraints = {
    }
}
