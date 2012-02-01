package com.educacion.seguridad

class RequestmapGroup {
	String descripcion
	
	static hasMany= [requests:Requestmap]
    static constraints = {
		descripcion (blank:false,nullable:false,unique:true)
		requests validator: {
			it?.every { it?.validate() }
		}
    }
	
	static mapping={
		requests (cascade: 'all-delete-orphan')
	}
	
	def beforeInsert(){
		descripcion = descripcion.toUpperCase()
	}
	
	def beforeUpdate(){
		descripcion = descripcion.toUpperCase()
	}
}
