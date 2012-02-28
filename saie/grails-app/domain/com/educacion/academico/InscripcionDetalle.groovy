package com.educacion.academico

class InscripcionDetalle {

	Inscripcion inscripcion
	
	
	
	static belongTo = [inscripcion:Inscripcion]
	
	static hasMany = [requisitos:Requisito]
	
    static constraints = {
    }
}
