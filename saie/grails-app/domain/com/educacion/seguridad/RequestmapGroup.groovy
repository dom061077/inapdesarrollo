package com.educacion.seguridad

class RequestmapGroup {
	String descripcion
	
	static hasMany= [requests:Requestmap]
    static constraints = {
		descripcion (blank:false,nullable:false,unique:true)
    }
	
	def beforeInsert(){
		descripcion = descripcion.toUpperCase()
	}
	
	def beforeUpdate(){
		descripcion = descripcion.toUpperCase()
	}
}
