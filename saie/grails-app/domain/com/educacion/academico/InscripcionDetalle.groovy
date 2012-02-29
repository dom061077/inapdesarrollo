package com.educacion.academico

class InscripcionDetalle {

	Inscripcion inscripcion
	
	
	
	static belongsTo = [inscripcion:Inscripcion]
	
	static hasMany = [requisitos:Requisito]
	
    static constraints = {
    }
}
